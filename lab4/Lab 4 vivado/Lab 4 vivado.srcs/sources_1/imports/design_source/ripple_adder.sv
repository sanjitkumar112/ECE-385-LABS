module ripple_adder (
	input  logic  [7:0] a, 
    input  logic  [7:0] b,
	input  logic         fn,
	
	output logic  [8:0] s,
	output logic         cout
);
    
    logic c0, c1 , c2 , c3, c4, c5, c6 , c7, c8, c9 ,c10, c11, c12, c13, c14;
    //attempt to do it in blocks of 4 and use init to solve
    single_ripple s0 (.a(a[0]), .b(b[0]^fn), .s(s[0]), .cin(fn), .c_out(c0));
    single_ripple s1 (.a(a[1]), .b(b[1]^fn), .s(s[1]), .cin(c0), .c_out(c1));
    single_ripple s2 (.a(a[2]), .b(b[2]^fn), .s(s[2]), .cin(c1), .c_out(c2));
    single_ripple s3 (.a(a[3]), .b(b[3]^fn), .s(s[3]), .cin(c2), .c_out(c3));
    single_ripple s4 (.a(a[4]), .b(b[4]^fn), .s(s[4]), .cin(c3), .c_out(c4));
    single_ripple s5 (.a(a[5]), .b(b[5]^fn), .s(s[5]), .cin(c4), .c_out(c5));
    single_ripple s6 (.a(a[6]), .b(b[6]^fn), .s(s[6]), .cin(c5), .c_out(c6));
    single_ripple s7 (.a(a[7]), .b(b[7]^fn), .s(s[7]), .cin(c6), .c_out(c7));
    single_ripple s8 (.a(a[7]), .b(b[7]^fn), .s(s[8]), .cin(c7), .c_out(cout));
    
	/* TODO
		*
		* Insert code here to implement a ripple adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		
    
endmodule