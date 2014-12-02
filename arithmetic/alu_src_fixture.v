/****alu_src_fixture.v**************************
 *
 * Test fixture for ALU Source module
 *
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * **************************************************/

`include "alu_src.v"

module alu_src_fixture;

reg [15:0] data_1;
reg [3:0] data_2;
reg ALU_Src;
wire [15:0] data_out;

initial
	$vcdpluson;

alu_src source(data_1,data_2,ALU_Src,data_out);

initial
begin
	$monitor($time, "\t data_1 : %b \t data_2 : %b \t ALU_Src: %b \t data_out %b", data_1, data_2, ALU_Src, data_out);
end

initial
begin
	#1 data_2 = 4'b0000;
	#1 data_2 = 4'b0001;
	#1 data_2 = 4'b1000;
	#1 data_2 = 4'b1111;
	#1 $finish;
end

initial
begin
	#1 data_1 = 16'hABCD;
	#1 data_1 = 16'h1234;
	#1 data_1 = 16'hFEED;
	#1 data_1 = 16'hAAAA;
end

initial
begin
	ALU_Src=0;
	forever #1 ALU_Src=~ALU_Src;
end

endmodule
