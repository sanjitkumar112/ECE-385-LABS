`timescale 1ns / 1ps

module testbench();

    // One signal for every port of processor_top
    logic        clk;
    logic        reset;
    logic        run_i;
    logic        continue_i;
    logic [15:0] sw_i;

    logic [15:0] led_o;
    logic [7:0]  hex_seg_left;
    logic [3:0]  hex_grid_left;
    logic [7:0]  hex_seg_right;
    logic [3:0]  hex_grid_right;

    // The design under test
    processor_top dut (.*);

    // Shortcuts to internal CPU signals so they're easy to find in the waveform
    logic [15:0] PC, MAR, MDR, IR, BUS;
    assign PC  = dut.slc3.cpu.pc;
    assign MAR = dut.slc3.cpu.mar;
    assign MDR = dut.slc3.cpu.mdr;
    assign IR  = dut.slc3.cpu.ir;
    assign BUS = dut.slc3.cpu.databus;

    // Clock: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus: press the buttons like a person would
    initial begin
        // Starting values
        reset      = 1;
        run_i      = 0;
        continue_i = 0;
        sw_i       = 16'h0000;

        // Hold reset, then release
        repeat (10) @(posedge clk);
        reset = 0;
        repeat (10) @(posedge clk);

        // Press and release Run -> first fetch
        run_i = 1;
        repeat (10) @(posedge clk);
        run_i = 0;
        repeat (50) @(posedge clk);
        $display("t=%0t  PC=%h  IR=%h", $time, PC, IR);

        // Press Continue 5 times -> 5 more fetches
        repeat (5) begin
            continue_i = 1;
            repeat (10) @(posedge clk);
            continue_i = 0;
            repeat (50) @(posedge clk);
            $display("t=%0t  PC=%h  IR=%h", $time, PC, IR);
        end

        $finish;
    end

endmodule