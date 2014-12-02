`include "pc.v"

`define INST_ADDR_WIDTH 16

//Top level stimulus module
module pc_fixture;

//Declare variables for stimulating input
reg CLOCK, RESET;
reg [`INST_ADDR_WIDTH-1:0] PC_IN;
wire [`INST_ADDR_WIDTH-1:0] PC_OUT;

initial
   $vcdpluson;

initial
   $monitor($time, "PC_OUT = %d", PC_OUT[`INST_ADDR_WIDTH-1:0]);


pc #(
       .INST_ADDR_WIDTH(`INST_ADDR_WIDTH)
    )    
    pc1(
      .clk(CLOCK),
      .rst(RESET),
      .pc_in(PC_IN),
      .pc_out(PC_OUT)
    );

//Stimulate Signals
initial
begin
   RESET = 1'b0;
   PC_IN = 0;
   #34 RESET = 1'b1;
   #40 PC_IN = 20;
   #20 PC_IN = 22;   
   #200 RESET = 1'b0;
   #50 RESET = 1'b1;
end

//Setup the clock to toggle every 10 time units
initial
begin
   CLOCK = 1'b0;
   forever #10 CLOCK = ~CLOCK;
end

//Finish the simulation at time 400
initial
begin
   #400 $finish;
end

endmodule
