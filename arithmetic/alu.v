/****alu.v*******************
 * Main ALU for the CPU system
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
****************************/


module alu 
//Begin Parameter List
#(
	REGISTER_DATA_BIT_WIDTH=16,
	ALU_CONTROL_WIDTH=4,
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
)
//END Parameter List

//BEGIN Port List
(input [REGISTER_DATA_BIT_WIDTH-1:0] A,B,
input [ALU_CONTROL_WIDTH-1:0] ALU_Ctrl,
output reg [REGISTER_DATA_BIT_WIDTH-1:0] R,	//Result to be output
output reg [REGISTER_DATA_BIT_WIDTH-1:0] S,
output reg ALU_Exception);	//Additional result fro MUL/DIV
//End Port List

reg [REGISTER_DATA_BIT_WIDTH*2-1:0] ovf_result; 	// ALU result upper and lower half

always @(*)
begin
	ALU_Exception = 0;   //combinatorial logic
	case (ALU_Ctrl)
		ADD :  begin 
			ovf_result = A + B;
			if ( A[REGISTER_DATA_BIT_WIDTH-1] == B[REGISTER_DATA_BIT_WIDTH-1] && A[REGISTER_DATA_BIT_WIDTH-1] != ovf_result[REGISTER_DATA_BIT_WIDTH-1])
				begin	// Overflow occurs when (-) + (-) = (+) or (+) + (+) = (-)
					$display("Arithmetic overflow!");
					ALU_Exception = 1;
				end
			end
		SUB : begin
			ovf_result = A - B;
			if ( A[REGISTER_DATA_BIT_WIDTH-1] != B[REGISTER_DATA_BIT_WIDTH-1] && A[REGISTER_DATA_BIT_WIDTH-1] != ovf_result[REGISTER_DATA_BIT_WIDTH-1])
				begin	// Overflow occurs when (-) - (+) = (+) or (+) - (-) = (-)
					$display("Arithmetic overflow!");
					ALU_Exception = 1;
				end
			end
		AND :  ovf_result = A | B;
		OR :  ovf_result = A & B;
		MUL : ovf_result = A * B;  //Upper half will automatically be in ovf_result
		DIV : begin
			ovf_result = A / B;	//integer division result
			ovf_result[REGISTER_DATA_BIT_WIDTH*2-1:REGISTER_DATA_BIT_WIDTH] = A % B; //Remainder result
			end
		SLL : ovf_result = A << B;  
		SLR : ovf_result = A >> B;
		ROL : begin 
			ovf_result = A; 
			ovf_result = ovf_result << B;   //Shift bits
			ovf_result[REGISTER_DATA_BIT_WIDTH-1:0] = ovf_result[REGISTER_DATA_BIT_WIDTH*2-1:REGISTER_DATA_BIT_WIDTH] | ovf_result[REGISTER_DATA_BIT_WIDTH-1:0];  //Then copy shifted bits from upper half to lower
			end
		ROR : begin
			ovf_result = 0;  // Takes care of lower half
			ovf_result[REGISTER_DATA_BIT_WIDTH*2-1:REGISTER_DATA_BIT_WIDTH] = A;	   //Put operand A in upper half
			ovf_result = ovf_result >> B;   //shift bits left
			//move lower portion of upper half to low portion of lower half
			ovf_result[REGISTER_DATA_BIT_WIDTH-1:0] = ovf_result[REGISTER_DATA_BIT_WIDTH*2-1:REGISTER_DATA_BIT_WIDTH] | ovf_result[REGISTER_DATA_BIT_WIDTH-1:0];  //Then copy shifted bits from upper half to lower
			end
		0 :  ovf_result = 0;  //No operation requested
		default : begin
			$display("Invalid function code");
			ALU_Exception = 1;
			end
	endcase
	
	// Assign to result output signals
	R = ovf_result[REGISTER_DATA_BIT_WIDTH-1:0];
	S = ovf_result[REGISTER_DATA_BIT_WIDTH*2-1:REGISTER_DATA_BIT_WIDTH];
	
end

endmodule
