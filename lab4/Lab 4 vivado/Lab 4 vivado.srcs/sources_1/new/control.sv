`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 01:16:50 PM
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
	input  logic reset,   
	input  logic run,     
	input  logic M,       

	output logic clr_ld,
	output logic clr_xa,
	output logic shift,
	output logic add,
	output logic sub
);

	typedef enum logic [2:0] {IDLE, CLEAR, ADD, SHIFT} state_t;
	state_t state, next_state;

	logic [2:0] count;
	logic       last;

	assign last = (count == 3'b111);

	always_ff @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			count <= 3'b000;
		end else begin
			state <= next_state;
			if (state == CLEAR)
				count <= 3'b000;
			else if (state == SHIFT)
				count <= count + 3'd1;
		end
	end

	always_comb begin
		next_state = state;
		unique case (state)
			IDLE:  if (run)   next_state = CLEAR;
			CLEAR:            next_state = ADD;
			ADD:              next_state = SHIFT;
            SHIFT: if (last)  next_state = IDLE;
                   else       next_state = ADD;
		endcase
	end

	assign clr_ld = reset;
	assign clr_xa = (state == CLEAR);
	assign add    = (state == ADD) & M & ~last;
	assign sub    = (state == ADD) & M &  last;
	assign shift  = (state == SHIFT);

endmodule