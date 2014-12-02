`include "reg_file.v"

`define REG_DATA_WIDTH 16
`define REG_NUM_WIDTH 4
`define REG_FORWARD_WIDTH 2
`define NUM_REG 16

`define REG_FORWARD_REG_FILE 2'b00
`define REG_FORWARD_WB 2'b01
`define REG_FORWARD_R0 2'b10

//Top level stimulus module
module reg_file_fixture;

//Declare variables for stimulating input
reg [`REG_NUM_WIDTH-1:0] RN_1, RN_2, WRN;
reg [`REG_DATA_WIDTH-1:0] WRD, R0D;
reg [`REG_FORWARD_WIDTH-1:0] REG_FORWARD_1, REG_FORWARD_2;
reg WR0, WR;

wire [`REG_DATA_WIDTH-1:0] RD_1, RD_2, RD0;
wire EXCEPTION;

initial
   $vcdpluson;

initial
   $monitor($time, "RD_0 = %d, RD_2 = %d", RD_1, RD_2);

reg_file #(
       .REG_DATA_WIDTH(`REG_DATA_WIDTH),
       .REG_NUM_WIDTH(`REG_NUM_WIDTH),      
       .REG_FORWARD_WIDTH(`REG_FORWARD_WIDTH),
       .NUM_REG(`NUM_REG),
       .REG_FORWARD_REG_FILE(`REG_FORWARD_REG_FILE),
       .REG_FORWARD_WB(`REG_FORWARD_WB),
       .REG_FORWARD_R0(`REG_FORWARD_R0)
    )    
    reg_file_1(
      .rn_1(RN_1),
      .rn_2(RN_2),
      .wrn(WRN),
      .wrd(WRD),
      .r0d(R0D),
      .wr0(WR0),
      .wr(WR),
      .reg_forward_1(REG_FORWARD_1),
      .reg_forward_2(REG_FORWARD_2),
      .rd_1(RD_1),
      .rd_2(RD_2),
      .rd0(RD0),
      .exception(EXCEPTION)
    );

//Stimulate Signals
initial
begin
   REG_FORWARD_1 = `REG_FORWARD_REG_FILE;
   REG_FORWARD_2 = `REG_FORWARD_REG_FILE;
   WRN = 0;
   WRD = 30;
   RN_1 = 1;
   RN_2 = 2;
   R0D = 20;
   WRD = 30;
   WR = 0;
   #10;
   WRN = 3;
   WR = 1;
   #10;
   WR = 0;
   #10;
   WR0 = 1;
   #10;
   WR0 = 0;
   #10
   RN_1 = 3;
   RN_2 = 0;  
   #10
   WRD = 50;
   WRN = 4; 
   #10
   WR = 1;
   #10
   WR = 0;
   #10
   RN_2 = 4;
   WRD = 60;
   #10
   REG_FORWARD_1 = `REG_FORWARD_WB;
   REG_FORWARD_2 = `REG_FORWARD_R0;
end

//Finish the simulation at time 400
initial
begin
   #400 $finish;
end

endmodule
