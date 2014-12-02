/* pc_adder.v
 * Program counter adder
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module pc_adder(pc_in, branch_addr, halt, branch, pc_out);

//Parameters
parameter INST_ADDR_WIDTH = 16;
parameter NUM_BYTES_IN_INST = 2;

// I/O ports
input halt, branch;
input [INST_ADDR_WIDTH - 1:0] pc_in, branch_addr;

//Output defined as register
output reg [INST_ADDR_WIDTH-1:0] pc_out;

//Procedural blocks
always @(*)
begin
    if (halt)
        pc_out = pc_in;
    else if (branch)
        pc_out = branch_addr;
    else
        pc_out = pc_in + NUM_BYTES_IN_INST;  
end

endmodule

//-----------------------------END OF FILE------------------------------------- 