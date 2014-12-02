/* sign_extender.v
 * A sign extension unit
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module sign_extender(data_in, data_out);

//Parameters
parameter REGISTER_DATA_BIT_WIDTH = 16;
parameter DATA_2_WIDTH = 4; 

//I/O ports
input [DATA_2_WIDTH-1:0] data_in;

//Outputs defined as register 
output reg [REGISTER_DATA_BIT_WIDTH-1:0] data_out;

//Procedural blocks
always @(*)
begin
    data_out = {{(REGISTER_DATA_BIT_WIDTH-DATA_2_WIDTH){data_in[DATA_2_WIDTH-1]}}, data_in};
end

endmodule

//-----------------------------END OF FILE-------------------------------------