/**sign_extender_shifter.v*************
 * Sign extends input and shifts it left based on a control signal
 *
 * Writen by Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * *************************************/


module sign_extend_shifter #(DATA_IN_MAX_WIDTH=12, DATA_IN_MIN_WIDTH=8, DATA_OUT_WIDTH=16, SHIFT_AMOUNT=1) (
	input [DATA_IN_MAX_WIDTH-1:0] data_in,
	input jump,
	output [DATA_OUT_WIDTH-1:0] data_out);

reg [DATA_OUT_WIDTH-1:0] ext_result;
reg [DATA_OUT_WIDTH-1:0] shift_result;

assign data_out = shift_result;


always @(*)
begin 
	if (jump)
		ext_result = { { (DATA_OUT_WIDTH - DATA_IN_MAX_WIDTH){data_in[DATA_IN_MAX_WIDTH-1]}},data_in[DATA_IN_MAX_WIDTH-2:0]};
	else
		ext_result = { {(DATA_OUT_WIDTH - DATA_IN_MIN_WIDTH){data_in[DATA_IN_MIN_WIDTH-1]}},data_in[DATA_IN_MIN_WIDTH-2:0]};

	shift_result = ext_result << SHIFT_AMOUNT;
end

endmodule
