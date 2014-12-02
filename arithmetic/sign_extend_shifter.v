/**sign_extender_shifter.v*************
 * Sign extends input and shifts it left based on a control signal
 *
 * Writen by Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * *************************************/

`include "sign_extender.v"


module sign_extend_shifter #(DATA_IN_MAX_WIDTH=12, DATA_IN_MIN_WIDTH=8, DATA_OUT_WIDTH=16, SHIFT_AMOUNT=1) (
	input [DATA_IN_MAX_WIDTH-1:0] data_in,
	input jump,
	output reg [DATA_OUT_WIDTH-1:0] data_out);


reg [DATA_OUT_WIDTH-1:0] ext_result;
wire [DATA_OUT_WIDTH-1:0] ext_result_max,ext_result_min;

sign_extender #(DATA_OUT_WIDTH,DATA_IN_MAX_WIDTH) sign_ext_max(data_in[DATA_IN_MAX_WIDTH-1:0],ext_result_max);
sign_extender #(DATA_OUT_WIDTH,DATA_IN_MIN_WIDTH) sign_ext_min(data_in[DATA_IN_MIN_WIDTH-1:0],ext_result_min);




always @(*)
begin 
	if (jump)	//If jump, uses largest width
		ext_result = ext_result_max;  
	else		//else use min width
		ext_result = ext_result_min;

	data_out = ext_result << SHIFT_AMOUNT;  //shift result
end

endmodule
