/* alu_src.v
 * Muxes register data with immediate operand data for ALU operands
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

`include "sign_extender.v"

module alu_src(data_1, data_2, alu_src, data_out);

//Parameters
parameter REG_DATA_WIDTH = 16;
parameter DATA_2_WIDTH = 4;

//I/O ports
input [REG_DATA_WIDTH-1:0] data_1;
input [DATA_2_WIDTH-1:0] data_2;
input alu_src;

//Outputs defined as register
output reg [REG_DATA_WIDTH-1:0] data_out;

//Wires
wire [REG_DATA_WIDTH-1:0] data_2_ext;

initial
begin
    data_out = 0;    
end

//Instantiations
sign_extender #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .DATA_2_WIDTH(DATA_2_WIDTH)
    ) 
    sign_ext1(
        .data_in(data_2),
        .data_out(data_2_ext)
    );

//Procedural blocks
always @(*)
begin
    if (alu_src)
        data_out = data_2_ext;
    else 
        data_out = data_1;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
