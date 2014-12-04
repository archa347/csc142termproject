/* sign_extender_shifter.v
 * Sign extends input and shifts it left based on a control signal
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module sign_extend_shifter(rst, data_in, data_out_1, data_out_2);

//Parameters
parameter DATA_IN_MAX_WIDTH = 12;
parameter DATA_IN_MIN_WIDTH = 8;
parameter DATA_OUT_WIDTH = 16;
parameter SHIFT_AMOUNT = 1;

//I/O ports
input rst;
input [DATA_IN_MAX_WIDTH-1:0] data_in;

//Outputs defined as registers
output reg [DATA_OUT_WIDTH-1:0] data_out_1, data_out_2;

//Wires
wire [DATA_OUT_WIDTH-1:0] ext_result_max, ext_result_min;

//Instantiations
sign_extender #(
        .REG_DATA_WIDTH(DATA_OUT_WIDTH),
        .DATA_2_WIDTH(DATA_IN_MAX_WIDTH)
    ) 
    sign_ext_max(
        .rst(rst),
        .data_in(data_in[DATA_IN_MAX_WIDTH-1:0]),
        .data_out(ext_result_max)
    );

sign_extender #(
        .REG_DATA_WIDTH(DATA_OUT_WIDTH),
        .DATA_2_WIDTH(DATA_IN_MIN_WIDTH)
    ) 
    sign_ext_min(
        .rst(rst),
        .data_in(data_in[DATA_IN_MIN_WIDTH-1:0]),
        .data_out(ext_result_min)
    );

//Procedural blocks
always @(*)
begin 
    if (!rst)
    begin
        data_out_1 = 0;    
        data_out_2 = 0; 
    end
    else
    begin
        data_out_1 = ext_result_max << SHIFT_AMOUNT;  //shift result
        data_out_2 = ext_result_min << SHIFT_AMOUNT;  //shift result
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------
