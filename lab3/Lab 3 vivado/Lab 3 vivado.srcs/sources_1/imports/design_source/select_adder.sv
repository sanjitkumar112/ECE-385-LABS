module select_adder (
	input  logic  [15:0] a, 
    input  logic  [15:0] b,
	input  logic         cin,
	
	output logic  [15:0] s,
	output logic         cout
);

	/* TODO
		*
		* Insert code here to implement a CSA adder.
		* Your code should be completly combinational (don't use always_ff or always_latch).
		* Feel free to create sub-modules or other files. */
		
	wire [4:0] c;
	assign c[0] = cin;
	assign cout = c[4];
	wire [15:4] sum0, sum1;
	wire[3:1] cout0, cout1;
	
	four_bit_ripple_adder first_fbra (
	       .a (a[3:0]),
	       .b (b[3:0]),
	       .cin (c[0]),
	       .s (s[3:0]),
	       .cout (c[1])
	   );
	
	genvar i;
	for (i = 4; i < 16; i=i+4) begin:sa
	   four_bit_ripple_adder carry_fbra (
	       .a (a[i+3:i]),
	       .b (b[i+3:i]),
	       .cin (1),
	       .s (sum1[i+3:i]),
	       .cout (cout1[i/4])
	   );
	   
	   four_bit_ripple_adder no_carry_fbra (
	       .a (a[i+3:i]),
	       .b (b[i+3:i]),
	       .cin (0),
	       .s (sum0[i+3:i]),
	       .cout (cout0[i/4])
	   );
	   
	   assign s[i+3:i] = c[i/4] ? sum1[i+3:i] : sum0[i+3:i];
	   assign c[(i/4) + 1] = cout0[i/4] | (cout1[i/4] & c[i/4]);
	end
	
endmodule
