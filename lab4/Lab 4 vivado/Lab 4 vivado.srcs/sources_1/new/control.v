`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 01:14:23 PM
// Design Name: 
// Module Name: control
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


module control (
	input  logic clk,
	input  logic reset,   // synchronized Reset_Load_Clear
	input  logic run,     // synchronized Run
	input  logic M,       // Bval[0]

	output logic clr_ld,
	output logic clr_xa,
	output logic shift,
	output logic add,
	output logic sub
);

	

endmodule
