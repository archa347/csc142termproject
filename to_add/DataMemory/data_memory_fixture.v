`include "data_memory.v"

`define DATA_ADDR_WIDTH 16
`define DATA_WIDTH 16
`define DATA_SIZE 1024

//Top level stimulus module
module data_memory_fixture;

//Declare variables for stimulating input
reg WRITE;
reg [`DATA_ADDR_WIDTH-1:0] ADDR;
reg [`DATA_WIDTH-1:0] DATA_IN;

wire [`DATA_WIDTH-1:0] DATA_OUT;
wire EXCEPTION;

initial
   $vcdpluson;

initial
begin
   $monitor($time, "DATA_OUT = %d", DATA_OUT[`DATA_WIDTH-1:0]);
end


data_memory #(
       .DATA_ADDR_WIDTH(`DATA_ADDR_WIDTH),
       .DATA_WIDTH(`DATA_WIDTH),
       .DATA_SIZE(`DATA_SIZE)
    )    
    data_memory1(
      .addr(ADDR),
      .data_in(DATA_IN),
      .write(WRITE),
      .data_out(DATA_OUT),
      .exception(EXCEPTION)
    );

//Stimulate Signals
initial
begin
   ADDR = 0;
   DATA_IN = 100;
   WRITE = 0;
   #10;
   WRITE = 1;
   #10;
   WRITE = 0;
   
end

//Finish the simulation at time 400
initial
begin
   #400 $finish;
end

endmodule
