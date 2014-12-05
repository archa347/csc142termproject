/* pc_adder.v
 * Program counter adder
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module pc_adder(rst, pc_in, branch_addr, halt, pc_src, pc_added);

//Parameters
parameter INST_ADDR_WIDTH = 16;
parameter NUM_BYTES_IN_INST = 2;

// I/O ports
input rst, halt, pc_src;
input [INST_ADDR_WIDTH - 1:0] pc_in, branch_addr;

//Output defined as register
output reg [INST_ADDR_WIDTH-1:0] pc_added;

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        pc_added = 0;
    end
    else
    begin
        if (halt)
            pc_added = pc_in;
        else if (pc_src)
            pc_added = branch_addr;
        else
            pc_added = pc_in + NUM_BYTES_IN_INST;  
    end
end

endmodule

//-----------------------------END OF FILE------------------------------------- 