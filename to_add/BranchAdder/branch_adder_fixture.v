`include "branch_adder.v"

`define INST_1_WIDTH 8
`define INST_2_WIDTH 12
`define INST_ADDR_WIDTH 16

//Top level stimulus module
module branch_adder_fixture;

//Declare variables for stimulating input
reg JUMP;
reg [`INST_1_WIDTH-1:0] INST_1;
reg [`INST_2_WIDTH-1:0] INST_2;
reg [`INST_ADDR_WIDTH-1:0] PC;

wire [`INST_ADDR_WIDTH-1:0] BRANCH_ADDR;

initial
   $vcdpluson;

initial
   $monitor($time, "BRANCH_ADDR = %d", BRANCH_ADDR[`INST_ADDR_WIDTH-1:0]);

branch_adder #(
       .INST_1_WIDTH(`INST_1_WIDTH),
       .INST_2_WIDTH(`INST_2_WIDTH),      
       .INST_ADDR_WIDTH(`INST_ADDR_WIDTH)
    )    
    branch_adder_1(
      .jump(JUMP),
      .inst_1(INST_1),
      .inst_2(INST_2),
      .pc(PC),
      .branch_addr(BRANCH_ADDR)
    );

//Stimulate Signals
initial
begin
    JUMP = 0;
    PC = 1000;
    INST_1 = 255;
    INST_2 = 3500;
    #10;
    JUMP = 1;   
end

//Finish the simulation at time 400
initial
begin
   #400 $finish;
end

endmodule
