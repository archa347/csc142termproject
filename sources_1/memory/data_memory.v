/* data_memory.v
 * data memory
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module data_memory(addr, data_in, write, data_out, exception);

//Parameters
parameter DATA_ADDR_WIDTH = 16;
parameter DATA_WIDTH = 16;
parameter DATA_SIZE = 1024;

// I/O ports
input [DATA_ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
input write;

output exception;

//Output defined as register
output reg [DATA_WIDTH-1:0] data_out;

//Registers
reg ex_w, ex_r;

reg [DATA_WIDTH-1:0] data [DATA_SIZE-1:0];

//Continuous assignments
assign exception = ex_w | ex_r;

//Procedural blocks
always @(*)
begin
   ex_w = 1'b0; 

   if (write)
        if (addr < DATA_SIZE)
            data[addr] = data_in;
        else
            ex_w = 1'b1;
end

always @(*)
begin
    ex_r = 1'b0;

    if (addr < DATA_SIZE)
        data_out = data[addr];
    else
        ex_r = 1'b1;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
