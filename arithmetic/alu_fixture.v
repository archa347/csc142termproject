`include "alu.v"

module alu_fixture #(
	//Function Codes
	ADD = 4'b1111,
	SUB = 4'b1110,
	AND = 4'b1101,
	OR = 4'b1100,
	MUL = 4'b0001,
	DIV = 4'b0010,
	SLL = 4'b1010,
	SLR = 4'b1011,
	ROL = 4'b1001,
	ROR = 4'b1000
);

reg [3:0] ctl;
reg [15:0] A,B;
wire [15:0] R,S;
wire alu_exception;

initial 
	$vcdpluson;

initial
begin
	$display("\tTime\tALU_Ctrl\tA\tB\tR\tS\tALU_Exc");
	$monitor($time, " %b\t %x\t %x\t  %x\t %x\t %b\t", ctl, A, B, R, S,alu_exception);
end

alu main_alu(A,B,ctl,R,S,alu_exception);

initial
begin
	ctl = 0;
	#1 ctl = ADD;
	$display("ADD");
	#5 ctl = SUB;
	$display("SUB");
	#5 ctl = AND;
	$display("AND");
	#5 ctl = OR;
	$display("OR");
	#5 ctl = MUL;
	$display("MUL");
	#5 ctl = DIV;
	$display("DIV");
	#5 ctl = SLL;
	$display("SLL");
	#5 ctl = SLR;
	$display("SLR");
	#5 ctl = ROL;
	$display("ROL");
	#5 ctl = ROR;
	$display("ROR");
	#5 $finish; 
end

always
begin
	#1 A = 16'h0001;
	#1 A = 16'h00F0;
	#1 A = 16'hFFFF;
	#1 A = 16'h0001;
	#1 A = 16'h7FFF;
end

always
begin
	#1 B = 16'h0001;
	#1 B = 16'h0004;
	#1 B = 16'h0001; 
	#1 B = 16'h8000; 
	#1 B = 16'h0001; 
end

	
endmodule

	
