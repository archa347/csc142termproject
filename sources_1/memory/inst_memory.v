/* inst_memory.v
 * Memory for holding CPU instructions
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module inst_memory(addr, clk, rst, data, exc);

//Parameters
parameter INSTR_ADDR_WIDTH = 16;
parameter INSTR_DATA_BIT_WIDTH = 16;
parameter INSTR_MEM_SIZE = 4096;

//I/O ports
input [INSTR_ADDR_WIDTH-1:0] addr;
input clk, rst;

//Outputs defined as registers
output reg [INSTR_DATA_BIT_WIDTH-1:0] data;
output reg exc;

//Registers
reg [INSTR_DATA_BIT_WIDTH-1:0] data_reg;
reg [7:0] mem [INSTR_MEM_SIZE-1:0];

//Integers
integer i;

//Procedural blocks
always @(posedge clk, negedge rst)
begin
    exc = 0; 
    if (!rst)
        for ( i = 0; i < INSTR_MEM_SIZE; i=i+1)
            mem[i] <= 0;
    else 
        if (addr < INSTR_MEM_SIZE-1)
            data_reg <= {mem[addr+1],mem[addr]} ;
        else
            exc <= 1'b1;
end

always @(*)
begin
    data = data_reg;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
	
