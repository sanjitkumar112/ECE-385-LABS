module lookahead_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CLA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
		logic [3:0] PG;
		logic [3:0] GG;
		logic [2:0] c;
		
		mini_cla cla0 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .s(s[3:0]), .PG(PG[0]), .GG(GG[0]));
        mini_cla cla1 (.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .s(s[7:4]), .PG(PG[1]), .GG(GG[1]));
        mini_cla cla2 (.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .s(s[11:8]), .PG(PG[2]), .GG(GG[2]));
        mini_cla cla3 (.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .s(s[15:12]), .PG(PG[3]), .GG(GG[3]));
        
        assign c[0] = GG[0] | (cin& PG[0]);
        assign c[1] = (GG[1]) | (GG[0] & PG[1]) | (cin & PG[0] & PG[1]);
		assign c[2] = GG[2] | (GG[1]&PG[2]) | (GG[0] & PG[2] & PG[1]) | (cin & PG[2] & PG[1]&PG[0]);

        assign cout = GG[3]| (GG[2] & PG[3]) | (GG[1] & PG[2] & PG[3]) | (GG[0] & PG[1] & PG[2] & PG[3]) | (cin & PG[0] & PG[1] & PG[2] & PG[3]);
endmodule
