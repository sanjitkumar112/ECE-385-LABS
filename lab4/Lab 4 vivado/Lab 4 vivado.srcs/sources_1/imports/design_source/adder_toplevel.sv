//Top level for ECE 385 adders lab
//modified for Spring 2024

//Note: lowest 2 HEX digits will reflect lower 8 bits of switch input
//Upper 4 HEX digits will reflect value in the accumulator


module adder_toplevel   (
	input  logic 		clk, 
	input  logic		reset_load_clear, 
	input  logic 		run_i, // _i stands for input
	input  logic [7:0] sw_i,

	output logic 		Xval,
	output logic [7:0]  Aval, 
	output logic [7:0]  Bval,
	output logic [7:0]  hex_seg,
	output logic [3:0]  hex_grid
);

	// Declare temporary values used by other modules
	logic       run_pulse, clr_ld, clr_xa, shift, add, sub;
	logic [8:0] sum;
	
	// Synchronized inputs (denoted by _s in naming convention)
	logic       rlc_s, run_s;
	logic [7:0] sw_s;  
	
	// Allows the register to load once, and not during full duration of button press
	// ie. converts an active low button press to a single clock cycle active high event
	negedge_detector run_once ( 
		.clk	(clk), 
		.in	    (run_s), 
		.out    (run_pulse)
	);
	
	control ctrl (
		.clk(clk), .reset(rlc_s), .run(run_pulse), .M(Bval[0]),
		.clr_ld(clr_ld), .clr_xa(clr_xa),
		.shift(shift), .add(add), .sub(sub)
	);

	// Addition unit
	ripple_adder adder_ra (
		.a	 	(Aval), 
		.b	 	(sw_s), 
		.fn 	(sub), 
		.cout	(), 
		.s   	(sum) 
	);

    always_ff @(posedge clk) begin
		if (clr_ld) begin
			Xval <= 1'b0;
			Aval <= 8'h00;
			Bval <= sw_s;
		end else if (clr_xa) begin
			Xval <= 1'b0;
			Aval <= 8'h00;
		end else if (add | sub) begin
			Xval <= sum[8];
			Aval <= sum[7:0];
		end else if (shift) begin
			{Xval, Aval, Bval} <= {Xval, Xval, Aval, Bval[7:1]};
		end
	end


	// Hex unit that display contents of sw and sum register in hex
	hex_driver hex (
		.clk		(clk),
		.reset		(rlc_s),
		.in			({Aval[7:4], Aval[3:0], Bval[7:4], Bval[3:0]}),
		.hex_seg	(hex_seg),
		.hex_grid	(hex_grid)
	);
	
	// Synchchronizers/debouncers
	sync_debounce button_sync [1:0] (
	   .clk    (clk),
	   
	   .d      ({reset_load_clear, run_i}),
	   .q      ({rlc_s, run_s})
	);
	
		
	load_reg #(
	   .DATA_WIDTH(8) // specifying the data width of synchronizer through a parameter
	) sw_sync ( 
		.clk		(clk), 
		.reset		(1'b0), // there is no reset for the inputs, so hardcode 0
		.load		(1'b1), // always load data_i into the register
		.data_i		(sw_i), 
		
		.data_q   	(sw_s) 
	);		
endmodule