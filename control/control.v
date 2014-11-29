/*******control.v********************************
 * The central control unit for the cpu design
 *
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 * *********************************************/

module control 
	/*BEGIN Parameters*/
	#(FUNCTION_CODE_WIDTH=4,OP_CODE_WIDTH=4,BRANCH_CONTROL_WIDTH=2,ALU_CONTROL_WIDTH=4,
	//Op codes
	ALU = 4'b0,
	LW = 4'b1000,
	SW = 4'b1011,
	BLT = 4'b0100,
	BGT = 4'b0101,
	BEQ = 4'b0110,
	JMP = 4'b1100,
	HALT = 4'b1111,
	//Function codes
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
	/*END Parameter List*/
		 	
	( /*BEGIN  Ports */
	input [OP_CODE_WIDTH-1:0] op_code,
	input [FUNCTION_CODE_WIDTH-1:0] func_code,
	input inst_memory_exception,alu_exception,data_memory_exception,
	output reg jump,halt,write_reg,write_r0,
	output reg [BRANCH_CONTROL_WIDTH-1:0] branch,
	output reg mem_wrt,
	output reg [ALU_CONTROL_WIDTH-1:0] alu_control,
	output reg alu_a_src,alu_b_src,reg_wr_src
	); /*END Ports*/

always @(*)
begin
	//zero out the control signals
	jump = 0;
	halt = 0;
	write_reg = 0;
	write_r0 = 0;
	branch = 0;
	mem_wrt = 0;
	alu_control = 0;
	alu_a_src = 0;
	alu_b_src = 0;
	reg_wr_src = 0;
	
	//check for exceptions
	if (inst_memory_exception ||  data_memory_exception || alu_exception)
	begin
		halt = 1;
		$display("Exception signal received %b", {inst_memory_exception,data_memory_exception,alu_exception});
	end	
	
	//check opcodes
	else
	case (op_code)
		ALU : 	begin
			case (func_code)
				MUL : write_r0 = 1;
				DIV : write_r0 = 1;
				SLL : alu_b_src = 1;
				SLR : alu_b_src = 1;
				ROL : alu_b_src = 1;
				ROR : alu_b_src = 1;
			endcase
			
			write_reg = 1;
			alu_control = func_code;
			end
		
		LW : 	begin
				alu_a_src = 1;
				write_reg = 1;
				reg_wr_src = 1;
				alu_control = ADD;
			end
		
		SW : 	begin
				alu_a_src = 1;
				mem_wrt = 1;
				alu_control = ADD;
			end

		BLT : 	branch = 2'b11;
		BGT :	branch = 2'b10;
		BEQ :	branch = 2'b01;
		JMP :  	jump = 1;
		HALT :  halt = 1;

		default: begin
				halt = 1;
				$display("Invalid opcode received");
			end
	endcase
end

endmodule	 
