`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2026 02:32:39 AM
// Design Name: 
// Module Name: mini_cla
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

//this is the 4-bit cla
module mini_cla(
    input logic  [3:0] a,
    input logic [3:0] b,
    input logic cin,
    
    output logic [3:0] s,
    output logic PG,
    output logic GG
    );
    
    logic [2:0] c_array;
    logic [3:0] g_array;
    logic [3:0] p_array;
    
    assign g_array[0] = a[0] & b[0];
    assign g_array[1] = a[1] & b[1];
    assign g_array[2] = a[2] & b[2];
    assign g_array[3] = a[3] & b[3];
    
    assign p_array[0] = a[0] ^ b[0];
    assign p_array[1] = a[1] ^ b[1];
    assign p_array[2] = a[2] ^ b[2];
    assign p_array[3] = a[3] ^ b[3];
    
    assign c_array[0] = (cin & p_array[0]) | g_array[0];
    assign c_array[1] = (cin & p_array[0] & p_array[1]) | (g_array[0] & p_array[1]) | g_array[1];
    assign c_array[2] = (cin& p_array[0] & p_array[1] & p_array[2]) |( g_array[0] & p_array[1] & p_array[2]) | (g_array[1] & p_array[2]) | g_array[2];
    
    assign PG = p_array[0] & p_array[1] & p_array[2] & p_array[3];
    assign GG = (g_array[3]) | (g_array[2] & p_array[3]) | (g_array[1] & p_array[3] & p_array[2]) | (g_array[0] & p_array[3] & p_array[2] & p_array[1]);
    
    single_ripple s0(.a(a[0]), .b(b[0]) , .s(s[0]) , .cin(cin), .c_out());
    single_ripple s1(.a(a[1]), .b(b[1]) , .s(s[1]) , .cin(c_array[0]),.c_out());
    single_ripple s2(.a(a[2]), .b(b[2]) , .s(s[2]) , .cin(c_array[1]), .c_out());
    single_ripple s3(.a(a[3]), .b(b[3]) , .s(s[3]) , .cin(c_array[2]) , .c_out());
    
endmodule
