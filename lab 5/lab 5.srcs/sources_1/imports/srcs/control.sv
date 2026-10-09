//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Given Code - Incomplete ISDU for SLC-3
// Module Name:    Control - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//    Revised 07-25-2023
//    Xilinx Vivado
//	  Revised 12-29-2023
// 	  Spring 2024 Distribution
// 	  Revised 6-22-2024
//	  Summer 2024 Distribution
//	  Revised 9-27-2024
//	  Fall 2024 Distribution
//------------------------------------------------------------------------------

module control (
    input logic         clk,
    input logic         reset,
 
    input logic  [15:0] ir,
    input logic         ben,
 
    input logic         continue_i,
    input logic         run_i,
 
    output logic        ld_mar,
    output logic        ld_mdr,
    output logic        ld_ir,
    output logic        ld_pc,
    output logic        ld_led,
    output logic        ld_reg,
    output logic        ld_cc,
 
    output logic        gate_pc,
    output logic        gate_mdr,
    output logic        gate_alu,
    output logic        gate_marmux,
 
    output logic [1:0]  pcmux,
    output logic        drmux,
    output logic        sr1mux,
    output logic        addr1mux,
    output logic [1:0]  addr2mux,
    output logic [1:0]  aluk,
    output logic        mio_en,
 
    output logic        mem_mem_ena, // Mem Operation Enable
    output logic        mem_wr_ena   // Mem Write Enable
);


    enum logic [4:0] {
        halted,
        pause_ir1,
        pause_ir2,
        // Fetch
        s_18,
        s_33_1,
        s_33_2,
        s_33_3,
        s_35,
        // Decode
        s_32,
        // ALU ops
        s_1,        // ADD
        s_5,        // AND
        s_9,        // NOT
        // LDR
        s_6,
        s_25_1,
        s_25_2,
        s_25_3,
        s_27,
        // STR
        s_7,
        s_23,
        s_16_1,
        s_16_2,
        // Control flow
        s_0,        // BR test
        s_22,       // BR taken
        s_12,       // JMP
        s_4,        // JSR save R7
        s_21        // JSR target
    } state, state_nxt;



	always_ff @ (posedge clk)
	begin
		if (reset) 
			state <= halted;
		else 
			state <= state_nxt;
	end
   
	always_comb
	begin 
		
		// Default controls signal values so we don't have to set each signal
		// in each state case below (If we don't set all signals in each state,
		// we can create an inferred latch)
        ld_mar      = 1'b0;
        ld_mdr      = 1'b0;
        ld_ir       = 1'b0;
        ld_pc       = 1'b0;
        ld_led      = 1'b0;
        ld_reg      = 1'b0;
        ld_cc       = 1'b0;
 
        gate_pc     = 1'b0;
        gate_mdr    = 1'b0;
        gate_alu    = 1'b0;
        gate_marmux = 1'b0;
 
        pcmux       = 2'b00;
        drmux       = 1'b0;
        sr1mux      = 1'b0;
        addr1mux    = 1'b0;
        addr2mux    = 2'b00;
        aluk        = 2'b00;
        mio_en      = 1'b0;
 
        mem_mem_ena = 1'b0;
        mem_wr_ena  = 1'b0;

        
		// Assign relevant control signals based on current state
		case (state)
			halted: ;
			// MAR <- PC, PC <- PC + 1
            s_18 :
                begin
                    gate_pc = 1'b1;     // since pc needs to feed to the bus
                    ld_mar  = 1'b1;     // mar needs to receive input
                    pcmux   = 2'b00;    // this is selecting the pc = pc + 1 line
                    ld_pc   = 1'b1;     // load pcmux output
                end
 
            // MDR <- M[MAR].  Three states cover the BRAM read latency.
            s_33_1, s_33_2, s_33_3 :
                begin
                    mem_mem_ena = 1'b1;
                    ld_mdr      = 1'b1;
                    mio_en      = 1'b1; // MDR takes memory, not the bus
                end
 
            // IR <- MDR
            s_35 :
                begin
                    gate_mdr = 1'b1;
                    ld_ir    = 1'b1;
                end

			// you need to finish the rest of state output logic..... 
                        // DR <- SR1 + OP2, set CC
            s_1 :
                begin
                    gate_alu = 1'b1;
                    ld_reg   = 1'b1;
                    ld_cc    = 1'b1;
                    aluk     = 2'b00;   // ADD
                    sr1mux   = 1'b0;    // ir[8:6]
                    drmux    = 1'b0;    // ir[11:9]
                end
 
            // DR <- SR1 AND OP2, set CC
            s_5 :
                begin
                    gate_alu = 1'b1;
                    ld_reg   = 1'b1;
                    ld_cc    = 1'b1;
                    aluk     = 2'b01;   // AND
                    sr1mux   = 1'b0;
                    drmux    = 1'b0;
                end
 
            // DR <- NOT SR, set CC
            s_9 :
                begin
                    gate_alu = 1'b1;
                    ld_reg   = 1'b1;
                    ld_cc    = 1'b1;
                    aluk     = 2'b10;   // NOT
                    sr1mux   = 1'b0;
                    drmux    = 1'b0;
                end

                        // MAR <- BaseR + SEXT(offset6)
            s_6 :
                begin
                    gate_marmux = 1'b1;
                    ld_mar      = 1'b1;
                    addr1mux    = 1'b1;     // SR1 output
                    addr2mux    = 2'b01;    // offset6
                    sr1mux      = 1'b0;     // BaseR is ir[8:6]
                end
 
            // MDR <- M[MAR]
            s_25_1, s_25_2, s_25_3 :
                begin
                    mem_mem_ena = 1'b1;
                    ld_mdr      = 1'b1;
                    mio_en      = 1'b1;
                end
 
            // DR <- MDR, set CC
            s_27 :
                begin
                    gate_mdr = 1'b1;
                    ld_reg   = 1'b1;
                    ld_cc    = 1'b1;
                    drmux    = 1'b0;
                end

                        // MAR <- BaseR + SEXT(offset6)
            s_7 :
                begin
                    gate_marmux = 1'b1;
                    ld_mar      = 1'b1;
                    addr1mux    = 1'b1;
                    addr2mux    = 2'b01;
                    sr1mux      = 1'b0;     // BaseR is ir[8:6]
                end
 
            // MDR <- R(SR).  The ALU pass-through is the only path from the
            // register file onto the bus, and SR lives in ir[11:9] for STR.
            s_23 :
                begin
                    gate_alu = 1'b1;
                    aluk     = 2'b11;   // pass A
                    sr1mux   = 1'b1;    // ir[11:9]
                    ld_mdr   = 1'b1;
                    mio_en   = 1'b0;    // MDR takes the bus, not memory
                end
 
            // M[MAR] <- MDR
            s_16_1, s_16_2 :
                begin
                    mem_mem_ena = 1'b1;
                    mem_wr_ena  = 1'b1;
                end

            // Test BEN - no datapath activity
            s_0 : ;
 
            // PC <- PC + SEXT(PCoffset9)
            s_22 :
                begin
                    ld_pc    = 1'b1;
                    pcmux    = 2'b10;   // address adder
                    addr1mux = 1'b0;    // PC
                    addr2mux = 2'b10;   // PCoffset9
                end

            s_12 :
                begin
                    ld_pc    = 1'b1;
                    pcmux    = 2'b10;
                    addr1mux = 1'b1;    // SR1 output
                    addr2mux = 2'b00;   // zero
                    sr1mux   = 1'b0;    // BaseR is ir[8:6]
                end
                
            // R7 <- PC.  No ld_cc: the ISA table exempts JSR from setting NZP.
            s_4 :
                begin
                    gate_pc = 1'b1;
                    ld_reg  = 1'b1;
                    drmux   = 1'b1;     // R7
                end
 
            // PC <- PC + SEXT(PCoffset11)
            s_21 :
                begin
                    ld_pc    = 1'b1;
                    pcmux    = 2'b10;
                    addr1mux = 1'b0;    // PC
                    addr2mux = 2'b11;   // PCoffset11
                end

            pause_ir1 : ld_led = 1'b1;
            pause_ir2 : ld_led = 1'b1;

			default : ;
		endcase
	end 


    always_comb
        begin
            // default next state is staying at current state
            state_nxt = state;
        
            unique case (state)
        
                halted :
                    if (run_i)
                        state_nxt = s_18;
        
                // Fetch
                s_18   : state_nxt = s_33_1;
                s_33_1 : state_nxt = s_33_2;
                s_33_2 : state_nxt = s_33_3;
                s_33_3 : state_nxt = s_35;
                s_35   : state_nxt = s_32;
        
                // Decode: dispatch on the opcode in ir[15:12]
                s_32 :
                    case (ir[15:12])
                        4'b0001 : state_nxt = s_1;          // ADD / ADDi
                        4'b0101 : state_nxt = s_5;          // AND / ANDi
                        4'b1001 : state_nxt = s_9;          // NOT
                        4'b0000 : state_nxt = s_0;          // BR
                        4'b1100 : state_nxt = s_12;         // JMP
                        4'b0100 : state_nxt = s_4;          // JSR
                        4'b0110 : state_nxt = s_6;          // LDR
                        4'b0111 : state_nxt = s_7;          // STR
                        4'b1101 : state_nxt = pause_ir1;    // PAUSE
                        default : state_nxt = s_18;         // unused opcode: NOP
                    endcase
        
                // ALU ops
                s_1 : state_nxt = s_18;
                s_5 : state_nxt = s_18;
                s_9 : state_nxt = s_18;
        
                // LDR
                s_6    : state_nxt = s_25_1;
                s_25_1 : state_nxt = s_25_2;
                s_25_2 : state_nxt = s_25_3;
                s_25_3 : state_nxt = s_27;
                s_27   : state_nxt = s_18;
        
                // STR
                s_7    : state_nxt = s_23;
                s_23   : state_nxt = s_16_1;
                s_16_1 : state_nxt = s_16_2;
                s_16_2 : state_nxt = s_18;
        
                // BR
                s_0 :
                    if (ben)
                        state_nxt = s_22;
                    else
                        state_nxt = s_18;
                s_22 : state_nxt = s_18;
        
                // JMP
                s_12 : state_nxt = s_18;
        
                // JSR
                s_4  : state_nxt = s_21;
                s_21 : state_nxt = s_18;
        
                // PAUSE: wait for press, then for release
                pause_ir1 :
                    if (continue_i)
                        state_nxt = pause_ir2;
                pause_ir2 :
                    if (~continue_i)
                        state_nxt = s_18;
        
                default : ;
            endcase
        end
	
endmodule
