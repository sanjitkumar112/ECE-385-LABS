`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2026 12:53:43 AM
// Design Name: 
// Module Name: single_ripple
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


module single_ripple(
    input logic a,
    input logic b,
    input logic cin,
    
    output logic s,
    output logic c_out
    );
    
    always_comb
    begin 
    c_out = (a & b) | (b&cin) | (a&cin);
    s = a^b^cin;
    end
endmodule
