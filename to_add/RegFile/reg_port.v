//Register Port
module reg_port(rfile_data, rn, wrd, r0d, 
                reg_forward, rd, exception
               );

//Parameters
parameter REG_DATA_WIDTH = 16;
parameter REG_NUM_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;
parameter NUM_REGISTERS = 16;

parameter REG_FORWARD_REG_FILE = 2'b00;
parameter REG_FORWARD_WB = 2'b01;
parameter REG_FORWARD_R0 = 2'b10;

// I/O ports
input [REG_DATA_WIDTH - 1:0] rfile_data;
input [REG_NUM_WIDTH - 1:0] rn;
input [REG_DATA_WIDTH - 1:0] wrd, r0d;
input [REG_FORWARD_WIDTH - 1:0] reg_forward;

//Output defined as register
output reg [REG_DATA_WIDTH -1:0] rd;
output reg exception;

reg ex_rn, ex_rf; 

always @(*)
begin
   exception = ex_rn | ex_rf;
end

always @(*)
begin
   ex_rn = 1'b0; 
   ex_rf = 1'b0;   
   rd = 0;

    case (reg_forward)
        REG_FORWARD_REG_FILE:
           if (rn < NUM_REGISTERS)
              rd = rfile_data;
           else 
              ex_rn = 1'b1;
            
        REG_FORWARD_WB:
           rd = wrd;

        REG_FORWARD_R0:
           rd = r0d;

        default:
           ex_rf = 1'b1;

    endcase
end

endmodule
