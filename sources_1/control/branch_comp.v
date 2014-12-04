/* branch_comp.v
 * Generates branch signal based on comparign two data values
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module branch_comp(data_1, data_2, branch_control, branch);

//Parameters
parameter REG_DATA_WIDTH = 16;
parameter BRANCH_CONTROL_WIDTH = 2;

parameter BRANCH_GT = 2'b10;
parameter BRANCH_LT = 2'b11;
parameter BRANCH_EQ = 2'b01;

// I/O ports
input [REG_DATA_WIDTH - 1:0] data_1, data_2;
input [BRANCH_CONTROL_WIDTH - 1:0] branch_control;

//Output defined as register
output reg branch;

initial
begin
    branch = 0;        
end

//Procedural blocks
always @(*)
begin
    case (branch_control)
        BRANCH_GT:
            branch = (data_1 > data_2) ? 1'b1 : 1'b0;

        BRANCH_LT:
            branch = (data_1 < data_2) ? 1'b1 : 1'b0;

        BRANCH_EQ:
            branch = (data_1 == data_2) ? 1'b1 : 1'b0;

        default:
            branch = 1'b0;
    endcase
end

endmodule

//-----------------------------END OF FILE-------------------------------------
