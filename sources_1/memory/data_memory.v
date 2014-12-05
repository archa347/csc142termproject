/* data_memory.v
 * data memory
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module data_memory(rst, addr, data_in, write, data_out, exception);

//Parameters
parameter DATA_MEM_ADDR_WIDTH = 16;
parameter DATA_MEM_WIDTH = 16;
parameter DATA_MEM_SIZE = 3;

// I/O ports
input rst;
input [DATA_MEM_ADDR_WIDTH-1:0] addr;
input [DATA_MEM_WIDTH-1:0] data_in;
input write;

//Output defined as register
output reg exception;
output reg [DATA_MEM_WIDTH-1:0] data_out;

//Registers
reg [DATA_MEM_WIDTH-1:0] data [DATA_MEM_SIZE-1:0];

integer i;

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        exception = 1'b0; 
        
        data[0] = 16'h2bcd;
        
        for (i = 1; i < DATA_MEM_SIZE; i = i + 1)        
            data[i] = 0; 
    end
    else
    begin
        if (write)
            if (addr < DATA_MEM_SIZE)
                data[addr] = data_in;
    end
end

always @(addr)
begin
    if (addr < DATA_MEM_SIZE)
        data_out = data[addr];  
    else 
        data_out = 0;
end

endmodule

//-----------------------------END OF FILE-------------------------------------