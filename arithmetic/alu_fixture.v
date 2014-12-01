`include "alu.v"

module alu_fixture;

reg [3:0] ctl;
reg [16:0] A,B;
wire [16:0] R,S;
wire alu_exception

initial 
	$vcdpluson;

initial
begin
	$display("\tTime\tALU_Ctrl\tA\tB\tR\tS\tALU_Exc");
	$monitor($time, " %b\t %x\t %x\t %x\t %x\t %b\t", ctl, A, B, R, S,alu_exception);
end

alu main_alu(A,B,ctl,R,S,alu_exception);

initial
begin
	ctl = 2'b00;
	#4 ctl = 2'b01;
	#4 ctl = 2'b10;
	#4 ctl = 2'b11;
end

initial
begin
	A = 32'b00;
	B = 32'b00;
end

always
begin
	#1 A = 32'h1;
	#1 A = 32'h8000_0001;
	#1 A = 32'hffff_ffff;
end

always
begin
	#1 B = 32'h1;
	#1 B = 32'hffff_ffff;
	#1 B = 32'h1;
end

initial
	#20 $finish;

	
endmodule

	
