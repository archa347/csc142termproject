/*****sign_extender.v********************
 *
 * A sign extension unit
 *
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * *************************************/

module sign_extender #(REGISTER_DATA_BIT_WIDTH=16, DATA_2_WIDTH=4) 
	(input [DATA_2_WIDTH-1:0] data_in, 
	output reg [REGISTER_DATA_BIT_WIDTH-1:0] data_out);

always @(*)
begin
	data_out =   {{(REGISTER_DATA_BIT_WIDTH-DATA_2_WIDTH){data_in[DATA_2_WIDTH-1]}},data_in};
end

endmodule
