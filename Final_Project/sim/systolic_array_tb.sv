`timescale 1ns / 1ps
module systolic_array_tb;
    logic clk = 0, rst = 1, start = 0, done;
    logic signed [7:0] a[0:3][0:2], b[0:2][0:3];
    logic signed [31:0] sums[0:3][0:3];
    systolic_array dut (.*);
    always #5 clk = ~clk;
    int expected, ticks;
    initial begin
        repeat (3) @(negedge clk);
        rst = 0;
        for (int test = 0; test < 4; test++) begin
            for (int r = 0; r < 4; r++) begin
                for (int k = 0; k < 3; k++) a[r][k] = test == 3 ? 8'sh80 : 8'(r - 2 * k + test);
            end
            for (int k = 0; k < 3; k++) begin
                for (int c = 0; c < 4; c++) b[k][c] = test == 3 ? 8'sh80 : 8'(3 * k - c - test);
            end
            start = 1;
            @(negedge clk);
            start = 0;
            ticks = 0;
            while (!done && ticks < 12) begin
                @(negedge clk);
                ticks++;
            end
            if (!done || ticks != 9) $fatal(1, "Expected 9 array issue clocks, saw %0d", ticks);
            for (int r = 0; r < 4; r++) begin
                for (int c = 0; c < 4; c++) begin
                    expected = 0;
                    for (int k = 0; k < 3; k++) expected += int'(a[r][k]) * int'(b[k][c]);
                    if (sums[r][c] !== expected)
                        $fatal(1, "C[%0d,%0d] got %0d expected %0d", r, c, sums[r][c], expected);
                end
            end
            @(negedge clk);
        end
        $display("PASS: four 4x3 by 3x4 signed matrix products.");
        $finish;
    end
endmodule
