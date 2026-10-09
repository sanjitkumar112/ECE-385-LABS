`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2026 06:44:54 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input logic clk,reset,
    input logic ld_reg,
    input logic[2:0] sr1, sr2, dr,
    input logic [15:0] data_i,
    output logic [15:0] sr1_out, sr2_out
    );
    
       logic [15:0] regs[8];
       always_ff @(posedge clk) begin
            if (reset)
                for (int i = 0; i < 8; i++) regs[i] <= 1'b0;
            else if (ld_reg) 
                regs[dr] <= data_i;
       end
       assign sr1_out = regs[sr1];
       assign  sr2_out = regs[sr2];
endmodule
