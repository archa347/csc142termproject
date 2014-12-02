`include "branch_comp.v"

`define REG_DATA_WIDTH 16
`define BRANCH_CONTROL_WIDTH 2

`define BRANCH_GT 2'b10
`define BRANCH_LT 2'b11
`define BRANCH_EQ 2'b01

//Top level stimulus module
module branch_comp_fixture;

//Declare variables for stimulating input
reg [`REG_DATA_WIDTH-1:0] DATA_1, DATA_2;
reg [`BRANCH_CONTROL_WIDTH-1:0] BRANCH_CONTROL;

wire BRANCH;

initial
   $vcdpluson;

initial
   $monitor($time, "DATA_1 = %d, DATA_2 = %d, BRANCH_CONTROL = %d, BRANCH = %d",  DATA_1[`REG_DATA_WIDTH-1:0], DATA_2[`REG_DATA_WIDTH-1:0], BRANCH_CONTROL[`BRANCH_CONTROL_WIDTH-1:0], BRANCH);

branch_comp #(
       .REG_DATA_WIDTH(`REG_DATA_WIDTH),
       .BRANCH_CONTROL_WIDTH(`BRANCH_CONTROL_WIDTH),      
       .BRANCH_LT(`BRANCH_LT),
       .BRANCH_GT(`BRANCH_GT),
       .BRANCH_EQ(`BRANCH_EQ)
    )    
    branch_comp_1(
      .data_1(DATA_1),
      .data_2(DATA_2),
      .branch_control(BRANCH_CONTROL),
      .branch(BRANCH)
    );

//Stimulate Signals
initial
begin
    DATA_1 = 3000;
    DATA_2 = 1000;
    #10;
    BRANCH_CONTROL = `BRANCH_LT;
    #10;
    BRANCH_CONTROL = `BRANCH_GT;   
    #10;
    BRANCH_CONTROL = `BRANCH_EQ;
    #10;
    DATA_2 = 3000;
end

//Finish the simulation at time 400
initial
begin
   #400 $finish;
end

endmodule
