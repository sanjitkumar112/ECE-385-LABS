`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 04:51:12 PM
// Design Name: 
// Module Name: tb_processor_programs
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_processor_programs;

    localparam integer BUTTON_CYCLES = 16;
    localparam integer NORMAL_TIMEOUT = 200000;
    localparam integer AUTO_TIMEOUT = 20000000;

    logic clk = 0;
    always #5 clk = ~clk;

    logic reset = 0;
    logic run_i = 0;
    logic continue_i = 0;
    logic [15:0] sw_i = 0;

    wire [15:0] led_o;
    wire [7:0] hex_seg_left, hex_seg_right;
    wire [3:0] hex_grid_left, hex_grid_right;

    processor_top dut (.*);

    // Signals to add to the waveform.
    wire [15:0] pc = dut.slc3.cpu.pc;
    wire [15:0] ir = dut.slc3.cpu.ir;
    wire [15:0] bus_value = dut.slc3.cpu._slc3_bus_;
    wire [15:0] hex_value = dut.slc3.io_bridge.hex_display;

    wire [15:0] cpu_addr = dut.slc3.cpu_addr;
    wire [15:0] cpu_wdata = dut.slc3.cpu_wdata;
    wire [15:0] cpu_rdata = dut.slc3.cpu_rdata;
    wire cpu_mem_ena = dut.slc3.cpu_mem_ena;
    wire cpu_wr_ena = dut.slc3.cpu_wr_ena;

    wire paused = dut.slc3.cpu.ld_led;
    wire fetching = dut.slc3.cpu.gate_pc &&
                    dut.slc3.cpu.ld_mar;

    wire [4:0] control_state =
        dut.slc3.cpu.cpu_control.state;

    wire [2:0] nzp = {
        dut.slc3.cpu.n,
        dut.slc3.cpu.z,
        dut.slc3.cpu.p
    };

    // Test IDs:
    // 1 = I/O Test 1
    // 2 = I/O Test 2
    // 3 = Self-Modifying Code
    // 4 = XOR
    // 5 = Multiplier
    // 6 = Auto Count
    // 7 = Sort

    integer test_id = 0;
    integer event_number = 0;

    // Set these two signals to ASCII radix in the waveform.
    logic [511:0] annotation = 0;
    logic [127:0] event_kind = 0;

    logic [15:0] expected_value = 0;
    logic [15:0] observed_value = 0;

    logic [6:0] passed_tests = 0;
    logic all_passed = 0;

    integer io_write_count = 0;
    logic [15:0] last_io_write = 0;
    logic previous_io_write = 0;

    logic vcd_enabled = 0;
    logic full_vcd = 0;
    logic trace_gap = 0;

    integer log_fd;

    logic [15:0] sort_input [0:15];

    // A STR write lasts two cycles.
    // Count it once when the write first becomes active.
    always @(posedge clk) begin
        if (dut.reset_s === 1'b1) begin
            previous_io_write <= 0;
        end
        else begin
            if (cpu_mem_ena &&
                cpu_wr_ena &&
                cpu_addr == 16'hffff &&
                !previous_io_write) begin

                io_write_count <= io_write_count + 1;
                last_io_write <= cpu_wdata;

                if (log_fd != 0)
                    $fdisplay(
                        log_fd,
                        "%0d,%0d,%0d,IO_WRITE,%04h,%04h,%04h,%04h,HEX write transaction",
                        $time, test_id, event_number,
                        pc, sw_i, cpu_wdata, cpu_wdata
                    );
            end

            previous_io_write <=
                cpu_mem_ena &&
                cpu_wr_ena &&
                cpu_addr == 16'hffff;
        end
    end

    // Drive and sample on falling edges to avoid races
    // with the DUT's rising-edge register updates.
    task automatic tick(input integer n);
        repeat (n) @(negedge clk);
    endtask

    // Put a readable annotation in the waveform,
    // simulation console, and CSV log.
    task automatic note(
        input string kind,
        input string message
    );
        event_kind = 0;
        annotation = 0;

        for (integer j = 0;
             j < 16 && j < kind.len();
             j = j + 1)
            event_kind[(15-j)*8 +: 8] = kind.getc(j);

        for (integer j = 0;
             j < 64 && j < message.len();
             j = j + 1)
            annotation[(63-j)*8 +: 8] = message.getc(j);

        event_number = event_number + 1;

        $display(
            "[%0t] TEST %0d %-8s %s",
            $time, test_id, kind, message
        );

        $fdisplay(
            log_fd,
            "%0d,%0d,%0d,%s,%04h,%04h,%04h,%04h,%s",
            $time, test_id, event_number, kind,
            pc, sw_i, expected_value, observed_value,
            message
        );
    endtask

    task automatic fail(input string message);
        observed_value = hex_value;
        note("FAIL", message);
        $fclose(log_fd);

        $fatal(
            1,
            "%s; PC=%04h IR=%04h LEDs=%04h HEX=%04h",
            message, pc, ir, led_o, hex_value
        );
    endtask

    task automatic wait_fetch(
        input logic [15:0] address,
        input integer limit
    );
        integer n;
        begin
            n = 0;

            while (!(fetching === 1'b1 &&
                     pc === address)) begin
                tick(1);
                n = n + 1;

                if (n >= limit)
                    fail($sformatf(
                        "Timed out waiting for fetch at x%04h",
                        address
                    ));
            end
        end
    endtask

    task automatic wait_pause(
        input logic [15:0] instruction_address,
        input logic [15:0] expected_ir
    );
        integer n;
        begin
            n = 0;

            while (!(paused === 1'b1 &&
                     pc === (instruction_address + 16'd1))) begin
                tick(1);
                n = n + 1;

                if (n >= NORMAL_TIMEOUT)
                    fail($sformatf(
                        "Timed out waiting for PAUSE at x%04h",
                        instruction_address
                    ));
            end

            if (ir !== expected_ir)
                fail($sformatf(
                    "PAUSE at x%04h expected IR=%04h got %04h",
                    instruction_address, expected_ir, ir
                ));

            tick(4);
        end
    endtask

    task automatic user_input(
        input logic [15:0] value,
        input string description
    );
        sw_i = value;

        note("INPUT", $sformatf(
            "%s: switches=x%04h",
            description, value
        ));

        // Allow the switch synchronizers to settle.
        tick(BUTTON_CYCLES);
    endtask

    task automatic press_continue;
        integer n;
        begin
            if (paused !== 1'b1)
                fail("Continue requested outside a PAUSE");

            continue_i = 1;
            note("CONTINUE", "Press Continue");
            tick(BUTTON_CYCLES);

            continue_i = 0;
            note("CONTINUE", "Release Continue");

            n = 0;

            while (paused !== 1'b0) begin
                tick(1);
                n = n + 1;

                if (n > 100)
                    fail("PAUSE did not exit after Continue release");
            end
        end
    endtask

    task automatic check_hex(
        input logic [15:0] expected,
        input string description
    );
        expected_value = expected;
        observed_value = hex_value;

        if (hex_value !== expected)
            fail($sformatf(
                "%s expected %04h got %04h",
                description, expected, hex_value
            ));

        note("RESULT", $sformatf(
            "%s: expected=x%04h observed=x%04h",
            description, expected, hex_value
        ));

        tick(8);
    endtask

    task automatic next_hex_write(
        input logic [15:0] expected,
        input string description,
        input integer limit
    );
        integer before_count;
        integer n;
        begin
            before_count = io_write_count;
            n = 0;

            while (io_write_count == before_count) begin
                tick(1);
                n = n + 1;

                if (n >= limit)
                    fail($sformatf(
                        "No HEX write for %s",
                        description
                    ));
            end

            if (last_io_write !== expected)
                fail($sformatf(
                    "%s write expected %04h got %04h",
                    description, expected, last_io_write
                ));

            check_hex(expected, description);
        end
    endtask

    task automatic check_memory(
        input integer address,
        input logic [15:0] expected
    );
        logic [15:0] actual;
        begin
            actual =
                dut.mem_subsystem.test_mem_subsystem.mem_array[address];

            if (actual !== expected)
                fail($sformatf(
                    "RAM[%0d] expected %04h got %04h",
                    address, expected, actual
                ));
        end
    endtask

    task automatic start_program(
        input integer id,
        input logic [15:0] address,
        input string name
    );
        begin
            test_id = id;

            reset = 1;
            run_i = 0;
            continue_i = 0;
            sw_i = address;

            expected_value = 0;
            observed_value = 0;

            note("SELECT", $sformatf(
                "%s: boot address=%0d (x%04h)",
                name, address, address
            ));

            tick(BUTTON_CYCLES);

            reset = 0;
            tick(BUTTON_CYCLES);

            run_i = 1;
            tick(BUTTON_CYCLES);
            run_i = 0;

            // Run the original boot instructions at addresses 0, 1, 2.
            wait_fetch(address, NORMAL_TIMEOUT);

            note("START", $sformatf(
                "%s: first instruction at x%04h",
                name, address
            ));
        end
    endtask

    task automatic pass_test(input string description);
        passed_tests[test_id-1] = 1;
        note("PASS", description);
    endtask

    // Optional VCD trimming. The CPU keeps running normally.
    // These tasks do not trim Vivado's separate WDB recording.
    task automatic gap_begin(input string description);
        begin
            if (vcd_enabled && !full_vcd) begin
                trace_gap = 1;
                note("GAP_BEGIN", description);
                tick(4);
                $dumpoff;
            end
        end
    endtask

    task automatic gap_end(input string description);
        begin
            if (vcd_enabled && !full_vcd) begin
                $dumpon;
                trace_gap = 0;
                note("GAP_END", description);
                tick(4);
            end
        end
    endtask

    initial begin : tests
        integer i;

        log_fd = $fopen("simulation_annotations.csv", "w");

        if (log_fd == 0)
            $fatal(1, "Cannot create simulation_annotations.csv");

        $timeformat(-9, 0, " ns", 12);

        $fdisplay(
            log_fd,
            "time_ns,test_id,event_number,event,pc,switches,expected,observed,description"
        );

        // Optional simulator plusargs:
        // +VCD            Record VCD with long loops omitted.
        // +VCD +FULL_VCD  Record every cycle.
        vcd_enabled = $test$plusargs("VCD");
        full_vcd = $test$plusargs("FULL_VCD");

        if (vcd_enabled) begin
            $dumpfile("seven_programs.vcd");
            $dumpvars(1, tb_processor_programs);
        end

        tick(2);

        // =========================================================
        // 1. I/O TEST 1
        // Switch values should appear on the left HEX display.
        // =========================================================

        start_program(1, 16'd3, "I/O Test 1");

        // This program has no PAUSE.
        // Change switches immediately when its first LDR is fetched.
        sw_i = 16'h1234;
        note("INPUT", "I/O Test 1 input=x1234");

        next_hex_write(
            16'h1234,
            "I/O Test 1 first echo",
            NORMAL_TIMEOUT
        );

        sw_i = 16'habcd;
        note("INPUT", "I/O Test 1 input=xABCD");

        next_hex_write(
            16'habcd,
            "I/O Test 1 second echo",
            NORMAL_TIMEOUT
        );

        sw_i = 16'h0000;
        note("INPUT", "I/O Test 1 input=x0000");

        next_hex_write(
            16'h0000,
            "I/O Test 1 zero echo",
            NORMAL_TIMEOUT
        );

        pass_test("I/O Test 1: three complete echo transactions");

        // =========================================================
        // 2. I/O TEST 2
        // Test input/output with Continue handshakes.
        // =========================================================

        start_program(2, 16'd6, "I/O Test 2");

        wait_pause(16'd6, 16'hd801);
        user_input(16'h2468, "I/O Test 2 first input");
        press_continue();

        wait_pause(16'd9, 16'hdc02);
        check_hex(16'h2468, "I/O Test 2 first echo");

        user_input(16'h1357, "I/O Test 2 second input");
        press_continue();

        wait_pause(16'd9, 16'hdc02);
        check_hex(16'h1357, "I/O Test 2 second echo");

        pass_test("I/O Test 2: input and output pauses verified");

        // =========================================================
        // 3. SELF-MODIFYING CODE
        // RAM[16] changes from DC02 to DC03 to DC04.
        // =========================================================

        start_program(3, 16'd11, "Self-Modifying Code");

        wait_pause(16'd11, 16'hd801);
        user_input(16'h1111, "Self-modifying input 1");
        press_continue();

        wait_pause(16'd16, 16'hdc02);
        check_hex(16'h1111, "Self-modifying echo 1");

        user_input(16'h2222, "Self-modifying input 2");
        press_continue();

        wait_pause(16'd16, 16'hdc03);
        check_memory(16, 16'hdc03);
        check_hex(
            16'h2222,
            "Self-modifying echo 2; PAUSE changed to xDC03"
        );

        user_input(16'h3333, "Self-modifying input 3");
        press_continue();

        wait_pause(16'd16, 16'hdc04);
        check_memory(16, 16'hdc04);
        check_hex(
            16'h3333,
            "Self-modifying echo 3; PAUSE changed to xDC04"
        );

        pass_test(
            "Self-modifying code: modified instruction stored and executed"
        );

        // =========================================================
        // 4. XOR
        // Test mixed bits, complementary bits, and a zero result.
        // =========================================================

        start_program(4, 16'd20, "XOR");

        for (i = 0; i < 3; i = i + 1) begin
            wait_pause(16'd21, 16'hd801);

            case (i)
                0: user_input(16'h00f0, "XOR operand A");
                1: user_input(16'haaaa, "XOR operand A");
                2: user_input(16'hffff, "XOR operand A");
            endcase

            press_continue();
            wait_pause(16'd23, 16'hd802);

            case (i)
                0: user_input(16'h0f0f, "XOR operand B");
                1: user_input(16'h5555, "XOR operand B");
                2: user_input(16'hffff, "XOR operand B");
            endcase

            press_continue();
            wait_pause(16'd34, 16'hd405);

            case (i)
                0: check_hex(16'h0fff, "x00F0 XOR x0F0F");
                1: check_hex(16'hffff, "xAAAA XOR x5555");
                2: check_hex(16'h0000, "xFFFF XOR xFFFF");
            endcase

            if (i < 2)
                press_continue();
        end

        pass_test("XOR: all three results matched");

        // =========================================================
        // 5. MULTIPLIER
        // Signed 8-bit inputs, with a 16-bit result.
        // =========================================================

        start_program(5, 16'd49, "Multiplier");

        for (i = 0; i < 3; i = i + 1) begin
            wait_pause(16'd54, 16'hd801);

            case (i)
                0: user_input(16'd7, "Multiplier operand A=7");
                1: user_input(16'hfff9, "Multiplier operand A=-7");
                2: user_input(16'hfff8, "Multiplier operand A=-8");
            endcase

            press_continue();
            wait_pause(16'd56, 16'hd802);

            case (i)
                0: user_input(16'd9, "Multiplier operand B=9");
                1: user_input(16'd6, "Multiplier operand B=6");
                2: user_input(16'hfffd, "Multiplier operand B=-3");
            endcase

            press_continue();
            wait_pause(16'd71, 16'hd403);

            case (i)
                0: check_hex(16'h003f, "7 * 9 = 63");
                1: check_hex(16'hffd6, "-7 * 6 = -42");
                2: check_hex(16'h0018, "-8 * -3 = 24");
            endcase

            if (i < 2)
                press_continue();
        end

        pass_test("Multiplier: positive and signed products matched");

        // =========================================================
        // 6. AUTO COUNT
        // Keep the original delay constants and check 0, 1, 2.
        // This part takes most of the simulation time.
        // =========================================================

        start_program(6, 16'd156, "Auto Count");

        for (i = 0; i < 3; i = i + 1) begin
            gap_begin(
                "Auto Count: omit repetitive delay loop from VCD"
            );

            wait_fetch(16'd170, AUTO_TIMEOUT);

            gap_end(
                "Auto Count: resume before HEX write"
            );

            next_hex_write(
                i[15:0],
                $sformatf("Auto Count output %0d", i),
                NORMAL_TIMEOUT
            );
        end

        pass_test(
            "Auto Count: original delay loops produced 0 then 1 then 2"
        );

        // =========================================================
        // 7. SORT
        // Menu 1: enter values.
        // Menu 2: sort.
        // Menu 3: display sorted values.
        // =========================================================

        sort_input[0]  = 9;
        sort_input[1]  = 3;
        sort_input[2]  = 15;
        sort_input[3]  = 1;
        sort_input[4]  = 12;
        sort_input[5]  = 7;
        sort_input[6]  = 0;
        sort_input[7]  = 14;
        sort_input[8]  = 6;
        sort_input[9]  = 2;
        sort_input[10] = 11;
        sort_input[11] = 5;
        sort_input[12] = 13;
        sort_input[13] = 4;
        sort_input[14] = 10;
        sort_input[15] = 8;

        start_program(7, 16'd90, "Sort");

        wait_pause(16'd94, 16'hd3ff);
        user_input(16'd1, "Sort menu: select data entry");
        press_continue();

        for (i = 0; i < 16; i = i + 1) begin
            wait_pause(16'd111, 16'hdc01);

            check_hex(
                i[15:0],
                $sformatf("Sort entry index %0d", i)
            );

            user_input(
                sort_input[i],
                $sformatf("Sort data[%0d]", i)
            );

            press_continue();
        end

        wait_pause(16'd94, 16'hd3ff);

        for (i = 0; i < 16; i = i + 1)
            check_memory(74+i, sort_input[i]);

        note(
            "CHECK",
            "All 16 entered values are stored at RAM[74..89]"
        );

        user_input(16'd2, "Sort menu: select sorting");
        press_continue();

        gap_begin(
            "Sort: omit intermediate comparisons and swaps from VCD"
        );

        wait_pause(16'd94, 16'hd3ff);

        gap_end(
            "Sort: sorting completed and menu returned"
        );

        for (i = 0; i < 16; i = i + 1)
            check_memory(74+i, i[15:0]);

        note(
            "CHECK",
            "RAM[74..89] verified in ascending order 0 through 15"
        );

        user_input(16'd3, "Sort menu: select display");
        press_continue();

        for (i = 0; i < 16; i = i + 1) begin
            // The display routine modifies this PAUSE
            // instruction by x0010 after each displayed value.
            wait_pause(
                16'd148,
                16'(16'hd802 + (i*16))
            );

            check_hex(
                i[15:0],
                $sformatf("Sorted output[%0d]", i)
            );

            press_continue();
        end

        wait_pause(16'd94, 16'hd3ff);

        pass_test(
            "Sort: entered 16 values; RAM and every displayed value matched"
        );

        // =========================================================
        // FINAL CHECK
        // =========================================================

        if (passed_tests !== 7'b1111111)
            fail("Not all seven tests were marked complete");

        all_passed = 1;

        note(
            "ALL_PASS",
            "All seven supplied programs passed their bounded test sequences"
        );

        tick(20);
        $fclose(log_fd);
        $finish;
    end

    // Independent timeout for the whole simulation.
    initial begin
        #1000000000;
        $fatal(
            1,
            "Global watchdog expired; inspect PC and annotation"
        );
    end

endmodule
