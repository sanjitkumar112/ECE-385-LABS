// 640 x 480 scanout. The canvas supplies one RGB pixel at (x, y).
module screen (
    input  logic clk, reset,
    output logic pix, rst,
    output logic [9:0] x, y,
    input  logic [3:0] r, g, b, led,
    input  logic [15:0] result,
    output logic hdmi_clk_p, hdmi_clk_n,
    output logic [2:0] hdmi_p, hdmi_n
);
    logic fast;
    logic fb, feedback_clock, pixel_clock_raw, serial_clock_raw, locked, clk_in;
    IBUF clock_input (
        .I(clk),
        .O(clk_in)
    );
    MMCME2_BASE #(
        .CLKIN1_PERIOD(10.0),
        .CLKFBOUT_MULT_F(10.0),
        .DIVCLK_DIVIDE(1),
        .CLKOUT0_DIVIDE_F(40.0),
        .CLKOUT1_DIVIDE(8)
    ) mmcm (
        .CLKIN1(clk_in),
        .CLKFBIN(feedback_clock),
        .CLKFBOUT(fb),
        .CLKOUT0(pixel_clock_raw),
        .CLKOUT1(serial_clock_raw),
        .LOCKED(locked),
        .RST(1'b0),
        .PWRDWN(1'b0)
    );
    BUFG feedback (
        .I(fb),
        .O(feedback_clock)
    );
    BUFG pclk (
        .I(pixel_clock_raw),
        .O(pix)
    );
    BUFG fclk (
        .I(serial_clock_raw),
        .O(fast)
    );
    logic reset_req;
    assign reset_req = reset || !locked;
    (* ASYNC_REG="TRUE" *) logic [3:0] reset_sync = 15;
    always_ff @(posedge pix or posedge reset_req)
        if (reset_req) reset_sync <= '1;
        else reset_sync <= {reset_sync[2:0], 1'b0};
    assign rst = reset_sync[3];

    always_ff @(posedge pix) begin
        if (rst) begin
            x <= 0;
            y <= 0;
        end else if (x == 799) begin
            x <= 0;
            y <= y == 524 ? 0 : y + 1'b1;
        end else x <= x + 1'b1;
    end

    // Sixteen on-screen cells show C[0,0] in two's complement, bit 15 on left.
    logic panel;
    assign panel = x >= 192 && x < 448 && y >= 384 && y < 397;
    logic bit_on;
    assign bit_on = result[4'd15-(x[7:4]-4'd12)];
    logic text_pixel;
    demo_hud hud (.x, .y, .leds(led), .result, .ink(text_pixel));
    logic [11:0] rgb;
    always_comb begin
        rgb = {r, g, b};
        if (panel) begin
            rgb = bit_on ? 12'h4ec : 12'h346;
            if (x[3:0] == 15) rgb = 12'h124;
        end
        if (text_pixel) rgb = 12'heff;
    end
    logic active;
    assign active = x < 640 && y < 480;
    logic [1:0] syncs;
    assign syncs = {!(y >= 490 && y < 492), !(x >= 656 && x < 752)};
    for (genvar k = 0; k < 3; k++) begin : video_lanes
        logic [9:0] code;
        tmds_encoder enc (
            .clk(pix),
            .reset(rst),
            .de(active),
            .control(k == 0 ? syncs : 2'b00),
            .data({2{rgb[k*4+:4]}}),
            .symbol(code)
        );
        serial_lane ser (
            .pix(pix),
            .fast(fast),
            .rst(rst),
            .word_in(code),
            .p(hdmi_p[k]),
            .n(hdmi_n[k])
        );
    end
    serial_lane clock_lane (
        .pix(pix),
        .fast(fast),
        .rst(rst),
        .word_in(10'b1111100000),
        .p(hdmi_clk_p),
        .n(hdmi_clk_n)
    );
endmodule

// DVI video over an HDMI connector. Each lane emits one 10-bit TMDS word
// per pixel. Control periods reset running disparity.
module tmds_encoder (
    input logic clk,
    input logic reset,
    input logic de,
    input logic [1:0] control,
    input logic [7:0] data,
    output logic [9:0] symbol
);
    logic [8:0] q;
    int ones, balance;
    logic signed [5:0] disparity;
    always_comb begin
        ones = 0;
        for (int i = 0; i < 8; i++) ones = ones + int'(data[i]);
        q[8] = !(ones > 4 || (ones == 4 && !data[0]));
        q[0] = data[0];
        for (int i = 1; i < 8; i++) q[i] = q[i-1] ^ data[i] ^ !q[8];
        balance = -8;
        for (int i = 0; i < 8; i++) balance = balance + (q[i] ? 2 : 0);
    end
    always_ff @(posedge clk) begin
        if (reset || !de) begin
            disparity <= 0;
            case (control)
                0: symbol <= 10'b1101010100;
                1: symbol <= 10'b0010101011;
                2: symbol <= 10'b0101010100;
                3: symbol <= 10'b1010101011;
            endcase
        end else if (disparity == 0 || balance == 0) begin
            symbol <= {!q[8], q[8], q[8] ? q[7:0] : ~q[7:0]};
            disparity <= disparity + (q[8] ? balance : -balance);
        end else if ((disparity > 0) == (balance > 0)) begin
            symbol <= {1'b1, q[8], ~q[7:0]};
            disparity <= disparity - balance + (q[8] ? 2 : 0);
        end else begin
            symbol <= {1'b0, q[8], q[7:0]};
            disparity <= disparity + balance - (q[8] ? 0 : 2);
        end
    end
endmodule
module serial_lane (
    input logic pix,
    input logic fast,
    input logic rst,
    input logic [9:0] word_in,
    output logic p,
    output logic n
);
    logic s1, s2, line;
    OSERDESE2 #(
        .DATA_WIDTH  (10),
        .DATA_RATE_OQ("DDR"),
        .DATA_RATE_TQ("SDR"),
        .TRISTATE_WIDTH(1),
        .SERDES_MODE ("MASTER")
    ) master (
        .CLK(fast),
        .CLKDIV(pix),
        .OCE(1'b1),
        .RST(rst),
        .OQ(line),
        .D1(word_in[0]),
        .D2(word_in[1]),
        .D3(word_in[2]),
        .D4(word_in[3]),
        .D5(word_in[4]),
        .D6(word_in[5]),
        .D7(word_in[6]),
        .D8(word_in[7]),
        .SHIFTIN1(s1),
        .SHIFTIN2(s2),
        .TCE(1'b0),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0)
    );
    OSERDESE2 #(
        .DATA_WIDTH  (10),
        .DATA_RATE_OQ("DDR"),
        .DATA_RATE_TQ("SDR"),
        .TRISTATE_WIDTH(1),
        .SERDES_MODE ("SLAVE")
    ) slave (
        .CLK(fast),
        .CLKDIV(pix),
        .OCE(1'b1),
        .RST(rst),
        .SHIFTOUT1(s1),
        .SHIFTOUT2(s2),
        .D1(1'b0),
        .D2(1'b0),
        .D3(word_in[8]),
        .D4(word_in[9]),
        .D5(1'b0),
        .D6(1'b0),
        .D7(1'b0),
        .D8(1'b0),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .TCE(1'b0),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0)
    );
    OBUFDS #(
        .IOSTANDARD("TMDS_33")
    ) outbuf (
        .I (line),
        .O (p),
        .OB(n)
    );
endmodule

module demo_hud (
    input logic [9:0] x,
    input logic [9:0] y,
    input logic [3:0] leds,
    input logic [15:0] result,
    output logic ink
);
    logic [ 7:0] code;
    logic [34:0] glyph;
    logic [9:0] lx, ly;
    logic [  4:0] index;
    logic [  7:0] nibble;
    logic [127:0] line;
    always_comb begin
        lx   = x - 192;
        ly   = 0;
        line = 0;
        if (y >= 40 && y < 54) begin
            ly   = y - 40;
            line = "QUICK DRAW      ";
        end else if (y >= 60 && y < 74) begin
            ly = y - 60;
            if (leds[0]) line = "MATRIX PASS     ";
            else if (leds[1]) line = "MATRIX FAIL     ";
            else line = "MATRIX RUN      ";
        end else if (y >= 405 && y < 419) begin
            ly   = y - 405;
            line = "C00 HEX =       ";
        end else if (y >= 428 && y < 442) begin
            ly   = y - 428;
            line = leds[2] ? "USB MOUSE READY " : "USB MOUSE WAIT  ";
        end
        index  = lx[8:4];
        code   = 0;
        nibble = 0;
        if (x >= 192 && x < 448) begin
            code = line[(15-index[3:0])*8+:8];
            if (y >= 405 && y < 419 && index >= 10 && index < 14) begin
                nibble = (result >> ((13 - index) * 4)) & 15;
                code   = nibble < 10 ? 8'd48 + nibble : 8'd55 + nibble;
            end
        end
        case (code)
            "H": glyph = 35'b10001_10001_10001_11111_10001_10001_10001;
            "Q": glyph = 35'b01110_10001_10001_10001_10101_10010_01101;
            "U": glyph = 35'b10001_10001_10001_10001_10001_10001_01110;
            "I": glyph = 35'b01110_00100_00100_00100_00100_00100_01110;
            "C": glyph = 35'b01110_10001_10000_10000_10000_10001_01110;
            "K": glyph = 35'b10001_10010_10100_11000_10100_10010_10001;
            "D": glyph = 35'b11110_10001_10001_10001_10001_10001_11110;
            "R": glyph = 35'b11110_10001_10001_11110_10100_10010_10001;
            "A": glyph = 35'b01110_10001_10001_11111_10001_10001_10001;
            "W": glyph = 35'b10001_10001_10001_10101_10101_10101_01010;
            "M": glyph = 35'b10001_11011_10101_10101_10001_10001_10001;
            "T": glyph = 35'b11111_00100_00100_00100_00100_00100_00100;
            "X": glyph = 35'b10001_10001_01010_00100_01010_10001_10001;
            "P": glyph = 35'b11110_10001_10001_11110_10000_10000_10000;
            "S": glyph = 35'b01111_10000_10000_01110_00001_00001_11110;
            "F": glyph = 35'b11111_10000_10000_11110_10000_10000_10000;
            "L": glyph = 35'b10000_10000_10000_10000_10000_10000_11111;
            "O": glyph = 35'b01110_10001_10001_10001_10001_10001_01110;
            "E": glyph = 35'b11111_10000_10000_11110_10000_10000_11111;
            "B": glyph = 35'b11110_10001_10001_11110_10001_10001_11110;
            "Y": glyph = 35'b10001_10001_01010_00100_00100_00100_00100;
            "N": glyph = 35'b10001_11001_11001_10101_10011_10011_10001;
            "0": glyph = 35'b01110_10001_10011_10101_11001_10001_01110;
            "1": glyph = 35'b00100_01100_00100_00100_00100_00100_01110;
            "2": glyph = 35'b01110_10001_00001_00010_00100_01000_11111;
            "3": glyph = 35'b11110_00001_00001_01110_00001_00001_11110;
            "4": glyph = 35'b00010_00110_01010_10010_11111_00010_00010;
            "5": glyph = 35'b11111_10000_10000_11110_00001_00001_11110;
            "6": glyph = 35'b01110_10000_10000_11110_10001_10001_01110;
            "7": glyph = 35'b11111_00001_00010_00100_01000_01000_01000;
            "8": glyph = 35'b01110_10001_10001_01110_10001_10001_01110;
            "9": glyph = 35'b01110_10001_10001_01111_00001_00001_01110;
            "=": glyph = 35'b00000_00000_11111_00000_11111_00000_00000;
            "-": glyph = 35'b00000_00000_00000_11111_00000_00000_00000;

            default: glyph = 0;
        endcase
        ink = 0;
        if (lx[3:1] < 5 && ly[3:1] < 7) ink = glyph[34-(ly[3:1]*5+lx[3:1])];
    end
endmodule