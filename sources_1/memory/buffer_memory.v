/* buffer_memory.v
 * buffer between pipeline stages
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module buffer_memory(clk, rst, flush, data_in, data_out);

//Parameters
parameter DATA_WIDTH = 64;

// I/O ports
input clk, rst, flush;
input [DATA_WIDTH - 1:0] data_in;

//Output defined as register
output reg [DATA_WIDTH-1:0] data_out;

initial
begin
    data_out = 0;          
end

//Procedural blocks
always @(posedge clk or negedge rst)
begin
    if (!rst)
        data_out <= 0;
    else if (flush)
        data_out <= 0;
    else
        data_out <= data_in;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
