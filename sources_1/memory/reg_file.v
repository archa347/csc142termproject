/* reg_file.v
 * Register file
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

`include "reg_port.v"

module reg_file(rn_1, rn_2, wrn, wrd, r0d, wr0, wr, 
                reg_forward_1, reg_forward_2, rd_1, rd_2, rd0, exception
               );

//Parameters
parameter REG_DATA_WIDTH = 16;
parameter REG_NUM_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;
parameter NUM_REG = 16;

parameter REG_FORWARD_REG_FILE = 2'b00;
parameter REG_FORWARD_WB = 2'b01;
parameter REG_FORWARD_R0 = 2'b10;

// I/O ports
input [REG_NUM_WIDTH - 1:0] rn_1, rn_2, wrn;
input [REG_DATA_WIDTH - 1:0] wrd, r0d;
input [REG_FORWARD_WIDTH - 1:0] reg_forward_1, reg_forward_2;
input wr0, wr;

output [REG_DATA_WIDTH -1:0] rd_1, rd_2;
output exception;

//Output defined as register
output reg [REG_DATA_WIDTH -1:0] rd0;

//Registers
reg [REG_DATA_WIDTH - 1:0] rfile [NUM_REG - 1:0];
reg ex_wrn;

//Wires
wire ex_rp1, ex_rp2;

//Instantiations 
reg_port #(
      .REG_DATA_WIDTH(REG_DATA_WIDTH),
      .REG_NUM_WIDTH(REG_NUM_WIDTH),
      .REG_FORWARD_WIDTH(REG_FORWARD_WIDTH),
      .NUM_REGISTERS(NUM_REG),
      .REG_FORWARD_REG_FILE(REG_FORWARD_REG_FILE),
      .REG_FORWARD_WB(REG_FORWARD_WB),
      .REG_FORWARD_R0(REG_FORWARD_R0)
    )
    reg_port_1(
      .rfile_data(rfile[rn_1]),
      .rn(rn_1),
      .wrd(wrd),
      .r0d(r0d),
      .reg_forward(reg_forward_1),     
      .rd(rd_1),
      .exception(ex_rp1)
    );

reg_port #(
      .REG_DATA_WIDTH(REG_DATA_WIDTH),
      .REG_NUM_WIDTH(REG_NUM_WIDTH),
      .REG_FORWARD_WIDTH(REG_FORWARD_WIDTH),
      .NUM_REGISTERS(NUM_REG),
      .REG_FORWARD_REG_FILE(REG_FORWARD_REG_FILE),
      .REG_FORWARD_WB(REG_FORWARD_WB),
      .REG_FORWARD_R0(REG_FORWARD_R0)
    )
    reg_port_2(
      .rfile_data(rfile[rn_2]),
      .rn(rn_2),
      .wrd(wrd),
      .reg_forward(reg_forward_2),
      .r0d(r0d),
      .rd(rd_2),
      .exception(ex_rp2)
    );

//Continuos assignments
assign exception = ex_rp1 | ex_rp2 | ex_wrn;

//Procedural blocks
always @(*)
begin
    if (wr0)
        rd0 = r0d;
    else
        rd0 = rfile[0];
end

always @(*)
begin
    ex_wrn = 1'b0;

    if (wr)
        if (wrn < NUM_REG)
            rfile[wrn] = wrd; 
        else
            ex_wrn = 1'b1;

    if (wr0)
        rfile[0] = r0d;
end

endmodule

//-----------------------------END OF FILE-------------------------------------
