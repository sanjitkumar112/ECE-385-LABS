//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//    Revised 12-29-2023
//    Revised 09-25-2024
//------------------------------------------------------------------------------
module cpu (
    input   logic        clk,
    input   logic        reset,

    input   logic        run_i,
    input   logic        continue_i,
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,
   
    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections, follow the datapath block diagram and add the additional needed signals
logic ld_mar; 
logic ld_mdr; 
logic ld_ir; 
logic ld_pc; 
logic ld_led;
logic ld_reg;
logic ld_cc;

//additional signals not Added

//need to account for the databus mux

logic gate_pc;
logic gate_mdr;
logic gate_alu;
logic gate_marmux;

logic [1:0] pcmux;
logic       drmux;      // 0 = ir[11:9],  1 = R7 (for JSR)
logic       sr1mux;     // 0 = ir[8:6],   1 = ir[11:9] (for STR)
logic       addr1mux;   // 0 = PC,        1 = SR1 output
logic [1:0] addr2mux;   // 00 = 0, 01 = off6, 10 = off9, 11 = off11
logic [1:0] aluk;       // 00 = ADD, 01 = AND, 10 = NOT, 11 = pass A
logic       mio_en;     // 0 = MDR loads from bus, 1 = MDR loads from memory

logic [15:0] mar; 
logic [15:0] mdr;
logic [15:0] mdr_next;
logic [15:0] ir;
logic [15:0] pc;
logic [15:0] pc_next;

logic [15:0] _slc3_bus_;

logic [2:0]  dr_sel;
logic [2:0]  sr1_sel;
logic [15:0] sr1_out;
logic [15:0] sr2_out;

logic [15:0] sr2mux_out;
logic [15:0] alu_out;

logic [15:0] addr1_out;
logic [15:0] addr2_out;
logic [15:0] addr_sum;

logic n, z, p;
logic ben;

assign mem_addr = mar;
assign mem_wdata = mdr;

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);
//data bus mux since no tristate buffers in fpga
always_comb begin : bus_mux
    if (gate_pc)
        _slc3_bus_ = pc;
    else if (gate_mdr)
        _slc3_bus_ = mdr;
    else if (gate_alu)
        _slc3_bus_ = alu_out;
    else if (gate_marmux)
        _slc3_bus_ = addr_sum;
    else
        _slc3_bus_ = '0;
end : bus_mux

//Register File

assign dr_sel  = drmux  ? 3'b111   : ir[11:9];
assign sr1_sel = sr1mux ? ir[11:9] : ir[8:6];
 
reg_file regfile (
    .clk     (clk),
    .reset   (reset),
 
    .ld_reg  (ld_reg),
    .dr      (dr_sel),
    .data_i  (_slc3_bus_),
 
    .sr1     (sr1_sel),
    .sr2     (ir[2:0]),
 
    .sr1_out (sr1_out),
    .sr2_out (sr2_out)
);

assign sr2mux_out = ir[5] ? {{11{ir[4]}}, ir[4:0]} : sr2_out;
 
// ALU

always_comb begin : alu
    unique case (aluk)
        2'b00:   alu_out = sr1_out + sr2mux_out;   // ADD / ADDi
        2'b01:   alu_out = sr1_out & sr2mux_out;   // AND / ANDi
        2'b10:   alu_out = ~sr1_out;               // NOT
        2'b11:   alu_out = sr1_out;                // pass A (STR)
    endcase
end : alu

// Address adder

assign addr1_out = addr1mux ? sr1_out : pc;
 
always_comb begin : addr2_mux
    unique case (addr2mux)
        2'b00:   addr2_out = 16'd0;                        // JMP
        2'b01:   addr2_out = {{10{ir[5]}},  ir[5:0]};      // LDR / STR
        2'b10:   addr2_out = {{7{ir[8]}},   ir[8:0]};      // BR
        2'b11:   addr2_out = {{5{ir[10]}},  ir[10:0]};     // JSR
    endcase
end : addr2_mux
 
assign addr_sum = addr1_out + addr2_out;

//PC MUX

always_comb begin : pc_mux
    unique case (pcmux)
        2'b00:   pc_next = pc + 16'd1;   // normal increment during fetch
        2'b01:   pc_next = _slc3_bus_;   // value arriving over the bus
        2'b10:   pc_next = addr_sum;     // BR, JSR, JMP target
        default: pc_next = pc + 16'd1;
    endcase
end : pc_mux


//mdrmux
always_comb begin : mdr_mux
    if (mio_en)
        mdr_next = mem_rdata;
    else
        mdr_next = _slc3_bus_;
end : mdr_mux

//Condition codes
always_ff @(posedge clk) begin : cc_reg
    if (reset) begin
        n <= 1'b0;
        z <= 1'b0;
        p <= 1'b0;
    end
    else if (ld_cc) begin
        n <= _slc3_bus_[15];
        z <= (_slc3_bus_ == 16'd0);
        p <= (_slc3_bus_[15] == 1'b0) && (_slc3_bus_ != 16'd0);
    end
end : cc_reg
 
assign ben = (n & ir[11]) | (z & ir[10]) | (p & ir[9]);


assign led_o = ld_led ? ir : 16'h0000;
assign hex_display_debug = ir;

load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (_slc3_bus_),

    .data_q (ir)
);
load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_mar),
    .data_i (_slc3_bus_),

    .data_q (mar)
);
load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_mdr),
    .data_i (mdr_next),

    .data_q (mdr)
);

load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pc_next),

    .data_q(pc)
);



endmodule