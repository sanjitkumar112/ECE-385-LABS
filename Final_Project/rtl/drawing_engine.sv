module drawing_engine (
    input logic clk,
    input logic reset,
    input logic [31:0] command,
    output logic [31:0] response,
    input logic [9:0] draw_x,
    input logic [9:0] draw_y,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);
    // Firmware toggles bit 31 for each new command. Return the same bit once
    // the line, clear or matrix operation has finished.
    logic completed;
    logic [19:0] result;
    assign response = {completed, 7'h2d, 4'b0, result};

    logic [7:0] cursor_x, cursor_y, x, y, end_x, end_y;
    logic signed [10:0] dx, dy, line_error;
    logic signed [10:0] twice_error;
    assign twice_error = line_error <<< 1;
    logic step_x;
    assign step_x = twice_error >= dy;
    logic step_y;
    assign step_y = twice_error <= dx;
    logic [7:0] target_x;
    assign target_x = command[7:0];
    logic [7:0] target_y;
    assign target_y = command[15:8];
    function automatic logic signed [10:0] distance(input logic [7:0] from_pos, to_pos);
        if (from_pos <= to_pos) return $signed({3'b0, to_pos - from_pos});
        return $signed({3'b0, from_pos - to_pos});
    endfunction
    logic signed [10:0] span_x, span_y;
    assign span_x = distance(cursor_x, target_x);
    assign span_y = distance(cursor_y, target_y);
    logic [15:0] clear_index;
    logic [ 1:0] verdict;
    logic signed [7:0] a[0:3][0:2], b[0:2][0:3];
    logic signed [31:0] sums[0:3][0:3];
    logic start_array, array_done;
    systolic_array array_core (
        .clk(clk),
        .rst(reset),
        .start(start_array),
        .a(a),
        .b(b),
        .sums(sums),
        .done(array_done)
    );

    typedef enum logic [2:0] {
        IDLE,
        CLEAR,
        LINE,
        COMPUTE
    } state_t;
    state_t state;
    // Port A writes one bit per cycle. Port B prefetches the next display pixel.
    (* ram_style="block" *) logic canvas[0:65535];
    logic dot;
    localparam logic [9:0] X0 = 10'd192, Y0 = 10'd112;
    logic [9:0] local_x;
    assign local_x = draw_x - X0;
    logic [9:0] local_y;
    assign local_y = draw_y - Y0;
    logic [7:0] next_x;
    assign next_x = local_x[7:0] + 1'b1;
    always_ff @(posedge clk) begin
        if (state == CLEAR) canvas[clear_index] <= 0;
        else if (state == LINE) canvas[{y, x}] <= 1;
        dot <= canvas[{local_y[7:0], next_x}];
    end

    typedef enum logic [3:0] {
        MOVE_CURSOR  = 1,
        DRAW_LINE,
        CLEAR_CANVAS,
        LOAD_A,
        LOAD_B,
        RUN_ARRAY,
        READ_SUM,
        SET_VERDICT
    } command_t;

    always_ff @(posedge clk) begin
        start_array <= 0;
        if (reset) begin
            state <= IDLE;
            completed <= 0;
            result <= 0;
            cursor_x <= 128;
            cursor_y <= 128;
            verdict <= 0;
            clear_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (command[31] != completed) begin
                        case (command[27:24])
                            MOVE_CURSOR: begin
                                cursor_x  <= target_x;
                                cursor_y  <= target_y;
                                completed <= command[31];
                            end
                            DRAW_LINE: begin  // draw from last cursor position, including endpoints
                                x <= cursor_x;
                                y <= cursor_y;
                                end_x <= target_x;
                                end_y <= target_y;
                                dx <= span_x;
                                dy <= -span_y;
                                line_error <= span_x - span_y;
                                cursor_x <= target_x;
                                cursor_y <= target_y;
                                state <= LINE;
                            end
                            CLEAR_CANVAS: begin
                                clear_index <= 0;
                                state <= CLEAR;
                            end
                            LOAD_A: begin  // A operand: row [11:10], k [9:8]
                                if (command[9:8] < 3) a[command[11:10]][command[9:8]] <= command[7:0];
                                completed <= command[31];
                            end
                            LOAD_B: begin  // B operand: k [11:10], column [9:8]
                                if (command[11:10] < 3) b[command[11:10]][command[9:8]] <= command[7:0];
                                completed <= command[31];
                            end
                            RUN_ARRAY: begin
                                start_array <= 1;
                                state <= COMPUTE;
                            end
                            READ_SUM: begin  // signed 20-bit result covers every three-term INT8 sum
                                result <= sums[command[3:2]][command[1:0]][19:0];
                                completed <= command[31];
                            end
                            SET_VERDICT: begin
                                verdict   <= command[1:0];
                                completed <= command[31];
                            end
                            default: begin
                                result <= 20'hbad;
                                completed <= command[31];
                            end
                        endcase
                    end
                end

                CLEAR: begin
                    if (&clear_index) begin
                        completed <= command[31];
                        state <= IDLE;
                    end else clear_index <= clear_index + 1'b1;
                end

                LINE: begin
                    if (x == end_x && y == end_y) begin
                        completed <= command[31];
                        state <= IDLE;
                    end else begin
                        if (step_x) x <= x < end_x ? x + 1'b1 : x - 1'b1;
                        if (step_y) y <= y < end_y ? y + 1'b1 : y - 1'b1;
                        line_error <= line_error + (step_x ? dy : 11'sd0) + (step_y ? dx : 11'sd0);
                    end
                end

                COMPUTE: begin
                    if (array_done) begin
                        completed <= command[31];
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    logic inside_canvas;
    assign inside_canvas = draw_x >= X0 && draw_x < X0 + 10'd256 &&
                           draw_y >= Y0 && draw_y < Y0 + 10'd256;
    logic [8:0] cursor_dx;
    assign cursor_dx = local_x[7:0] >= cursor_x ? local_x[7:0] - cursor_x : cursor_x - local_x[7:0];
    logic [8:0] cursor_dy;
    assign cursor_dy = local_y[7:0] >= cursor_y ? local_y[7:0] - cursor_y : cursor_y - local_y[7:0];
    always_comb begin
        {red, green, blue} = 12'h124;
        if (draw_x >= X0 - 10'd2 && draw_x < X0 + 10'd258 &&
            draw_y >= Y0 - 10'd2 && draw_y < Y0 + 10'd258)
            {red, green, blue} = 12'h678;
        if (inside_canvas) begin
            {red, green, blue} = dot ? 12'h123 : 12'hfff;
            if ((cursor_dx == 0 && cursor_dy <= 4) || (cursor_dy == 0 && cursor_dx <= 4))
                {red, green, blue} = 12'hf80;
        end
        if (draw_x >= X0 && draw_x < X0 + 10'd256 && draw_y >= 80 && draw_y < 96)
            case (verdict)
                1: {red, green, blue} = 12'h2c5;
                2: {red, green, blue} = 12'he32;
                default: {red, green, blue} = 12'h666;
            endcase
    end
endmodule
