`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2026 10:45:53 PM
// Design Name: 
// Module Name: four_bit_ripple_adder
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


module four_bit_ripple_adder(
    input [3:0] a, 
    input [3:0] b,
	input cin,
	
	output [3:0] s,
	output cout
);

    wire [4:0] c;
    assign c[0] = cin; 
    assign cout = c[4];
    
    genvar i;
    for (i = 0; i < 4; i = i+1) begin:ra
        single_ripple sr (
            .a (a[i]),
            .b (b[i]),
            .cin (c[i]),
            .s (s[i]),
            .c_out (c[i+1])
        );
    end

endmodule
