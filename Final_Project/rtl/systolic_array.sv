// A[4][3] times B[3][4]. Each cell holds one output sum for the entire run.
module systolic_array (
    input logic clk,
    input logic rst,
    input logic start,
    input logic signed [7:0] a[4][3],
    input logic signed [7:0] b[3][4],
    output logic signed [31:0] sums[4][4],
    output logic done
);
    logic busy;
    logic [3:0] cycle;

    // Cell (row, col) gets term k on cycle k + row + col.
    // Term 2 reaches cell (3, 3) on cycle 8.
    always_ff @(posedge clk) begin
        done <= 1'b0;
        if (rst || start) begin
            cycle <= '0;
            busy  <= start && !rst;
        end else if (busy) begin
            if (cycle == 8) begin
                done <= 1'b1;
                busy <= 1'b0;
            end else begin
                cycle <= cycle + 1'b1;
            end
        end
    end

    logic signed [7:0] east[4][4], south[4][4];
    for (genvar row = 0; row < 4; row++) begin : rows
        for (genvar col = 0; col < 4; col++) begin : columns
            logic signed [7:0] activation, weight;
            logic signed [15:0] product;

            if (col == 0) begin : from_input
                always_comb begin
                    activation = '0;
                    if (cycle >= row && cycle < row + 3) activation = a[row][cycle-row];
                end
            end else begin : from_west
                assign activation = east[row][col-1];
            end

            if (row == 0) begin : from_filter
                always_comb begin
                    weight = '0;
                    if (cycle >= col && cycle < col + 3) weight = b[cycle-col][col];
                end
            end else begin : from_north
                assign weight = south[row-1][col];
            end

            assign product = activation * weight;
            always_ff @(posedge clk) begin
                if (rst || start) begin
                    east[row][col]  <= '0;
                    south[row][col] <= '0;
                    sums[row][col]  <= '0;
                end else if (busy) begin
                    east[row][col]  <= activation;
                    south[row][col] <= weight;
                    sums[row][col]  <= sums[row][col] + 32'(product);
                end
            end
        end
    end
endmodule
