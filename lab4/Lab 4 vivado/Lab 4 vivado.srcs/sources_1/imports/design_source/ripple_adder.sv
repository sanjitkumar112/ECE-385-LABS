module ripple_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);
    
    logic c0, c1 , c2 , c3, c4, c5, c6 , c7, c8, c9 ,c10, c11, c12, c13, c14;
    //attempt to do it in blocks of 4 and use init to solve
    single_ripple s0 (.a(a[0]), .b(b[0]), .s(s[0]), .cin(cin), .c_out(c0));
    single_ripple s1 (.a(a[1]), .b(b[1]), .s(s[1]), .cin(c0), .c_out(c1));
    single_ripple s2 (.a(a[2]), .b(b[2]), .s(s[2]), .cin(c1), .c_out(c2));
    single_ripple s3 (.a(a[3]), .b(b[3]), .s(s[3]), .cin(c2), .c_out(c3));
    single_ripple s4 (.a(a[4]), .b(b[4]), .s(s[4]), .cin(c3), .c_out(c4));
    single_ripple s5 (.a(a[5]), .b(b[5]), .s(s[5]), .cin(c4), .c_out(c5));
    single_ripple s6 (.a(a[6]), .b(b[6]), .s(s[6]), .cin(c5), .c_out(c6));
    single_ripple s7 (.a(a[7]), .b(b[7]), .s(s[7]), .cin(c6), .c_out(c7));
    single_ripple s8 (.a(a[8]), .b(b[8]), .s(s[8]), .cin(c7), .c_out(c8));
    single_ripple s9 (.a(a[9]), .b(b[9]), .s(s[9]), .cin(c8), .c_out(c9));
    single_ripple s10 (.a(a[10]), .b(b[10]), .s(s[10]), .cin(c9), .c_out(c10));
    single_ripple s11 (.a(a[11]), .b(b[11]), .s(s[11]), .cin(c10), .c_out(c11));
    single_ripple s12 (.a(a[12]), .b(b[12]), .s(s[12]), .cin(c11), .c_out(c12));
    single_ripple s13 (.a(a[13]), .b(b[13]), .s(s[13]), .cin(c12), .c_out(c13));
    single_ripple s14 (.a(a[14]), .b(b[14]), .s(s[14]), .cin(c13), .c_out(c14));
    single_ripple s15 (.a(a[15]), .b(b[15]), .s(s[15]), .cin(c14), .c_out(cout));
    
	/* TODO
		*
		* Insert code here to implement a ripple adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		
    
endmodule