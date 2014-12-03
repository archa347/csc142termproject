/* alu_src.v
 * Muxes register data with immediate operand data for ALU operands
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

`include "sign_extender.v"

module alu_src(data_1, data_2, ALU_Src, data_out);

//Parameters
parameter DATA_WIDTH = 16;
parameter DATA_2_WIDTH = 4;

//I/O ports
input [DATA_WIDTH-1:0] data_1;
input [DATA_2_WIDTH-1:0] data_2;
input ALU_Src;

//Outputs defined as register
output reg [DATA_WIDTH-1:0] data_out;

//Wires
wire [DATA_WIDTH-1:0] data_2_ext;

//Instantiations
sign_extender #(
        .DATA_WIDTH(DATA_WIDTH),
        .DATA_2_WIDTH(DATA_2_WIDTH)
    ) 
    sign_ext1(
        .data_2(data_2),
        .data_2_ext(data_2_ext)
    );

//Procedural blocks
always @(*)
begin
    if (ALU_Src)
        data_out = data_2_ext;
    else 
        data_out = data_1;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
