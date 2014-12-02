`include "inst_memory.v"


module inst_memory_fixture;

reg [15:0] addr;
reg clk,rst;

wire [15:0] data;
wire exc;

integer i;

initial 
	$vcdpluson;


initial
begin
	$monitor($time," CLK: %d, RST: %d, ADDR: %x \t MEM_DATA: %x\t DATA_OUT: %x \t\tEXC: %d\n",clk,rst,addr,mem_module.mem[addr], data,exc);
end


inst_memory #(16,16,64) mem_module (addr,clk,rst,data,exc);

initial
begin
	mem_module.mem[0] = 16'h1111;
	mem_module.mem[1] = 16'h2222;
	mem_module.mem[2] = 16'h3333;
	mem_module.mem[3] = 16'h4444;
	mem_module.mem[63] = 16'h6464;
	
	#2 addr = 0;
	#2 addr = 1;
	#2 addr = 63;
	#2 addr = 100;
	#2 addr = 2;
	#2 addr = 3;
	#2 $finish;
end


initial 
begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial
begin
	rst = 1;
	#10 rst=0;
	#1 rst=1;
end

endmodule
