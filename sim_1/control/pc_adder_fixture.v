`include "pc_adder.v"

`define INST_ADDR_WIDTH 16

//Top level stimulus module
module pc_adder_fixture;

//Declare variables for stimulating input
reg HALT, BRANCH;
reg [`INST_ADDR_WIDTH-1:0] PC_IN, BRANCH_ADDR;
wire [`INST_ADDR_WIDTH-1:0] PC_OUT;

initial
   $vcdpluson;

initial
   $monitor($time, "PC_OUT = %d", PC_OUT[`INST_ADDR_WIDTH-1:0]);


pc_adder #(
       .INST_ADDR_WIDTH(`INST_ADDR_WIDTH)
    )    
    pc_adder1(
      .pc_in(PC_IN),
      .branch_addr(BRANCH_ADDR),
      .halt(HALT),
      .branch(BRANCH),     
      .pc_out(PC_OUT)
    );

//Stimulate Signals
initial
begin
    PC_IN = 10;
    BRANCH_ADDR = 500;
    HALT = 0;
    BRANCH = 0;
    #1
    PC_IN = PC_OUT;
    #1
    BRANCH = 1;
    #1
    PC_IN = PC_OUT;
    #1
    BRANCH = 0;
    #1
    HALT = 1;

end

//Finish the simulation at time 1000
initial
begin
   #1000 $finish;
end

endmodule
