//Branch Adder
module branch_adder(inst_1, inst_2, pc, jump, branch_addr);

//Parameters
parameter INST_1_WIDTH = 8;
parameter INST_2_WIDTH = 12;
parameter INST_ADDR_WIDTH = 16;

// I/O ports
input jump;
input [INST_1_WIDTH - 1:0] inst_1;
input [INST_2_WIDTH - 1:0] inst_2;
input [INST_ADDR_WIDTH - 1:0] pc;

//Output defined as register
output reg [INST_ADDR_WIDTH-1:0] branch_addr;

always @(*)
begin
   if (!jump)
      branch_addr = pc + inst_1;
   else
      branch_addr = pc + inst_2;
end

endmodule
