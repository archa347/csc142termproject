//PC Latch
module pc(clk, rst, pc_in, pc_out);

//Parameters
parameter INST_ADDR_WIDTH = 16;

// I/O ports
input clk, rst;
input [INST_ADDR_WIDTH - 1:0] pc_in;

//Output defined as register
output reg [INST_ADDR_WIDTH-1:0] pc_out;

always @(posedge clk or negedge rst)
begin
   if (!rst)
      pc_out <= 0;
   else
      pc_out <= pc_in;
end

endmodule
