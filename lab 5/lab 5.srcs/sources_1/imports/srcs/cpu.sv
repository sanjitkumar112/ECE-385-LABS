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

//additional signals not Added

//need to account for the databus mux

logic gate_pc;
logic gate_mdr;

logic [1:0] pcmux;

logic [15:0] mar; 
logic [15:0] mdr;
logic [15:0] mdr_next;
logic [15:0] ir;
logic [15:0] pc;
logic [15:0] pc_next;
logic ben;
logic [15:0] databus;
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
    if (gate_pc == 1'b1)
        databus = pc;
    else if (gate_mdr == 1'b1)
        databus = mdr;
    else
        databus = '0;
end : bus_mux
//pcmux
always_comb begin : pc_mux
    if (pcmux == 2'b00)
        pc_next = pc + 1;
    else if (pcmux == 2'b01)
        pc_next = databus;        
    else if (pcmux == 2'b10)
        pc_next = '0;// week 2: address adder output
    else
        pc_next = '0;
end : pc_mux
//mdrmux
always_comb begin : mdr_mux
    if(mem_mem_ena == 1'b1)
        mdr_next = mem_rdata;
    else
        mdr_next = databus;
end : mdr_mux



assign led_o = ir;
assign hex_display_debug = ir;

load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (databus),

    .data_q (ir)
);
load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_mar),
    .data_i (databus),

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