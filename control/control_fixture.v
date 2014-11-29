`include "control.v"


module control_fixture;
	
reg [15:0] instr;
wire inst_memory_exception,alu_exception,data_memory_exception, jump,halt,write_reg,write_r0;
wire [BRANCH_CONTROL_WIDTH-1:0] branch;
wire mem_wrt;
wire [ALU_CONTROL_WIDTH-1:0] alu_control;
wire alu_a_src,alu_b_src,reg_wr_src;

initial
	$vcdpluson;


initial
begin
	$monitor($time, " inst: %x \t op_code: %b \t func_code: %b \t exception: %b %b %b | alu_control: %b \t branch: %b \t mem_wrt: %b \t write_reg: %b \t write_r0: %b \t alu_a_src : %b \t alu_b_src : %b \t reg_wr_src \t halt: %b", 
	instr, instr[15:12], instr[3:0], inst_memory_exception, data_memory_exception, alu_exception, alu_control, branch, mem_wrt, write_reg, write_r0, alu_a_src, alu_b_src, reg_wr_src, halt  );
end

control main_control( 
	instr[15:12],
	func_code[3:0],
	inst_memory_exception,alu_exception,data_memory_exception,
	jump,halt,write_reg,write_r0,branch,mem_wrt,alu_control,
	alu_a_src,alu_b_src,reg_wr_src);

initial
begin
	instr = 16'b0000_0000_0000_0000;
	inst_memory_exception = 0;
	alu_exception = 0;
	data_memory_exception = 0;

	#1 instr = 16'b0000_0101_1010_1111;
	#1 instr = 16'b0000_0101_1010_1101;
	#1 instr = 16'b0000_0101_1010_0001;
	#1 instr = 16'b0000_0101_1010_1000;
	#1 instr = 16'b1000_1010_0101_1111;
	#1 instr = 16'b1011_1010_0101_0001;
	#1 instr = 16'b0100_1010_0101_1000;
	#1 instr = 16'b0101_1010_0101_0110;
	#1 instr = 16'b0110_1010_0101_1001;
	#1 instr = 16'b1100_1001_1001_0101;
	#1 instr = 16'b1111_0001_1000_1010;
	// Test exceptions
	#1 instr = 16'b0000_0101_1010_0111; //invalid function code
	#1 instr = 16'b0011_1001_0011_1110; //invalid op code
	#1 instr = 16'b0100_0011_1100_1010; //test alu exception
	#1 instr = 16'b0000_1001_0110_1101; //test inst memory exception
	#1 instr = 16'b0110_1100_1111_1011; //test data memory exception
	#1 $finish
end

initial
begin
	#14 alu_exception=1;
	#1 alu_exception=0;
end

initial
begin
	#15 inst_memory_exception=1;
	#1  inst_memory_exception=0;
end

initial
begin
	#16 data_memory_exception=1;
	#1  data_memory_exception=0;
end

endmodule