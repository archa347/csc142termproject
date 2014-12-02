/****sign_extender_fixture.v**************************
 *
 * Test fixture for a sign extension unit
 *
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * **************************************************/

`include "sign_extender.v"

module sign_extender_fixture;

reg [3:0] data_in;
wire [15:0] data_out;

initial
	$vcdpluson;

sign_extender sign_ext(data_in, data_out);

initial
begin
	$monitor($time, "\t data_in : %b \t data_out %b", data_in, data_out);
end

initial
begin
	#1 data_in = 4'b0000;
	#1 data_in = 4'b0001;
	#1 data_in = 4'b1000;
	#1 data_in = 4'b1111;
	#1 $finish;
end

endmodule
