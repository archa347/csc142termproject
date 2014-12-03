/* inst_memory.v
 * Memory for holding CPU instructions
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module inst_memory(addr, clk, rst, data, exc);

//Parameters
parameter INST_ADDR_WIDTH = 16;
parameter INST_DATA_WIDTH = 16;
parameter INST_MEM_SIZE = 4096;

//I/O ports
input [INST_ADDR_WIDTH-1:0] addr;
input clk, rst;

//Outputs defined as registers
output reg [INST_DATA_WIDTH-1:0] data;
output reg exc;

//Registers
reg [7:0] mem [INSTR_MEM_SIZE-1:0];

//Integers
integer i;

//Procedural blocks
always @(posedge clk, negedge rst)
begin
    exc = 0; 
    if (!rst)
        for ( i = 0; i < INST_MEM_SIZE; i=i+1)
            mem[i] <= 0;
    else 
        if (addr < INST_MEM_SIZE-1)
            data <= {mem[addr+1],mem[addr]} ;
        else
            exc <= 1'b1;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
	
