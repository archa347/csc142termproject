/* control.v
 * The central control unit for the cpu design
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module control(rst, op_code, func_code, exc_inst_memory, exc_alu, exc_data_memory, exc_reg_file, jump, 
                halt, write_reg, write_r0, branch_control, mem_wrt, alu_control, alu_a_src, alu_b_src, reg_wr_src
            	);

//Parameters
parameter FUNCTION_CODE_WIDTH = 4;
parameter OP_CODE_WIDTH = 4;
parameter BRANCH_CONTROL_WIDTH = 2;
parameter ALU_CONTROL_WIDTH = 4;

//Op codes
parameter ALU = 4'b0;
parameter LW = 4'b1000;
parameter SW = 4'b1011;
parameter BLT = 4'b0100;
parameter BGT = 4'b0101;
parameter BEQ = 4'b0110;
parameter JMP = 4'b1100;
parameter HALT = 4'b1111;

//Function codes
parameter ADD = 4'b1111;
parameter SUB = 4'b1110;
parameter AND = 4'b1101;
parameter OR = 4'b1100;
parameter MUL = 4'b0001;
parameter DIV = 4'b0010;
parameter SLL = 4'b1010;
parameter SLR = 4'b1011;
parameter ROL = 4'b1001;
parameter ROR = 4'b1000;
	
//I/O ports		 	
input rst;
input [OP_CODE_WIDTH-1:0] op_code;
input [FUNCTION_CODE_WIDTH-1:0] func_code;
input exc_inst_memory, exc_alu, exc_data_memory, exc_reg_file;

//Outputs defined as registers
output reg jump, halt, write_reg, write_r0;
output reg [BRANCH_CONTROL_WIDTH-1:0] branch_control;
output reg mem_wrt;
output reg [ALU_CONTROL_WIDTH-1:0] alu_control;
output reg alu_a_src, alu_b_src, reg_wr_src;

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        jump = 0;       
        halt = 0;
        write_reg = 0;
        write_r0 = 0;    
        branch_control = 0;
        mem_wrt = 0;
        alu_control = 0;
        alu_a_src = 0;
        alu_b_src = 0;
        reg_wr_src = 0;
    end
    else
    begin
        //zero out the control signals
        jump = 0;    
        write_reg = 0;
        write_r0 = 0;
        branch_control = 0;
        mem_wrt = 0;
        alu_control = 0;
        alu_a_src = 0;
        alu_b_src = 0;
        reg_wr_src = 0;

        //check for exceptions
        if (exc_inst_memory ||  exc_data_memory || exc_alu)
        begin
            halt = 1;
            $display("Exception signal received %b", {exc_inst_memory,exc_data_memory,exc_alu});
        end	
        else //check opcodes
         begin
            case (op_code)
                ALU:
                    begin
                    case (func_code)
                        MUL: 
                            write_r0 = 1;
                        
                        DIV: 
                            write_r0 = 1;

                        SLL: 
                            alu_b_src = 1;

                        SLR: 
                            alu_b_src = 1;

                        ROL:
                            alu_b_src = 1;

                        ROR: 
                            alu_b_src = 1;
                    endcase

                    write_reg = 1;
                    alu_control = func_code;
                end

                LW:
                begin
                    alu_a_src = 1;
                    write_reg = 1;
                    reg_wr_src = 1;
                    alu_control = ADD;
                end

                SW:
                    begin
                    alu_a_src = 1;
                    mem_wrt = 1;
                    alu_control = ADD;
                end

                BLT:
                    branch_control = 2'b11;

                BGT:
                    branch_control = 2'b10;
            
                BEQ:
                    branch_control = 2'b01;
            
                JMP:
                    jump = 1;
                
                HALT:
                    halt = 1;

                default: 
                begin
                    halt = 1;
                    $display("Invalid opcode received = %d", op_code);
                end
            endcase
        end
    end
end

endmodule	

//-----------------------------END OF FILE------------------------------------- 
