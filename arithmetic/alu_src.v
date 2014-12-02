/****alu_src.v**********************************
 * Muxes register data with immediate operand data for ALU operands
 *
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * ********************************************/

`include "sign_extender.v"

module alu_src #(REGISTER_DATA_BIT_WIDTH=16,DATA_2_WIDTH=4) 
	(input [REGISTER_DATA_BIT_WIDTH-1:0] data_1,
	input [DATA_2_WIDTH-1:0] data_2,
	input ALU_Src,
	output reg [REGISTER_DATA_BIT_WIDTH-1:0] data_out);

wire [REGISTER_DATA_BIT_WIDTH-1:0] data_2_ext;
sign_extender #(REGISTER_DATA_BIT_WIDTH,DATA_2_WIDTH) sign_ext (data_2,data_2_ext);

always @(*)
	if (ALU_Src)
		data_out = data_2_ext;
	else data_out = data_1;

endmodule
