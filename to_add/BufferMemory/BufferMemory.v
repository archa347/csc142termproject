//PC Latch
module BufferMemory(clk, rst, flush, data_in, data_out);

//Parameters
parameter DATA_WIDTH = 64;

// I/O ports
input clk, rst, flush;
input [DATA_WIDTH - 1:0] data_in;

//Output defined as register
output reg [DATA_WIDTH-1:0] data_out;

always @(posedge clk or negedge rst)
begin
   if (!rst)
      data_out <= 0;
   else if (flush)
      data_out <= 0;
   else
      data_out <= data_in;
end

endmodule
