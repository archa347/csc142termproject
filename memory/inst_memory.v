/***inst_memory.v*****
 * Memory for holding CPU instructions
 * 
 * Written By Daniel Gallegos, Brandon Ortiz
 * CSC/CpE 142, Fall 2014, CSUS
 *******************/


module inst_memory #(parameter INSTR_ADDR_WIDTH=16,INSTR_DATA_BIT_WIDTH=16,INSTR_MEM_SIZE=64) (
	input [INSTR_ADDR_WIDTH-1:0] addr,
	input clk, input rst,
	output reg [INSTR_DATA_BIT_WIDTH-1:0] data,
	output reg exc);
	
	integer i;
	reg [INSTR_DATA_BIT_WIDTH-1:0] data_reg;
    reg [INSTR_DATA_BIT_WIDTH-1:0] mem [INSTR_MEM_SIZE-1:0];

    always @(posedge clk, negedge rst)
	begin
		exc = 0; 
		if (!rst)
			for ( i = 0; i < INSTR_MEM_SIZE; i=i+1)
				mem[i] = 0;
		if (clk) 
			if (addr < 64)
				data_reg <= mem[addr];
			else
				exc <= 1'b1;
	end
	
	always @(*)
	begin
		data <= data_reg;
	end

endmodule
	
