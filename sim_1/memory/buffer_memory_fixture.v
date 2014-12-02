`include "buffer_memory.v"

`define DATA_WIDTH 64

//Top level stimulus module
module buffer_memory_fixture;

//Declare variables for stimulating input
reg CLOCK, RESET, FLUSH;
reg [`DATA_WIDTH-1:0] DATA_IN;
wire [`DATA_WIDTH-1:0] DATA_OUT;

initial
   $vcdpluson;

initial
   $monitor($time, "DATA_OUT = %d", DATA_OUT[`DATA_WIDTH-1:0]);


buffer_memory #(
       .DATA_WIDTH(`DATA_WIDTH)
    )    
    buffer_memory1(
      .clk(CLOCK),
      .rst(RESET),
      .flush(FLUSH),
      .data_in(DATA_IN),
      .data_out(DATA_OUT)
    );

//Stimulate Signals
initial
begin
   RESET = 1'b0;
   FLUSH = 1'b0;
   DATA_IN = 0;
   #34 RESET = 1'b1;
   #40 DATA_IN = 20;
   #20 DATA_IN = 22;   
   #20 FLUSH = 1'b1;
   #40 DATA_IN = 50;
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
   #1000 $finish;
end

endmodule
