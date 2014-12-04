/* branch_adder.v
 * Adds value to PC based on jump input
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module branch_adder(inst_1, inst_2, pc, jump, branch_addr);

//Parameters
parameter INST_ADDR_WIDTH = 16;

// I/O ports
input jump;
input [INST_ADDR_WIDTH - 1:0] inst_1, inst_2;
input [INST_ADDR_WIDTH - 1:0] pc;

//Output defined as register
output reg [INST_ADDR_WIDTH-1:0] branch_addr;

initial
begin
    branch_addr = 0;        
end

//Procedural blocks
always @(*)
begin
    if (!jump)
        branch_addr = pc + inst_1;
    else
        branch_addr = pc + inst_2;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
