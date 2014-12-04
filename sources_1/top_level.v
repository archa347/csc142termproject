/* top_level.v
 * Top level for the CPU system
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

`include "arithmetic/alu.v"
`include "arithmetic/alu_src.v"
`include "arithmetic/sign_extend_shifter.v"
`include "control/branch_adder.v"
`include "control/branch_comp.v"
`include "control/control.v"
`include "control/pc.v"
`include "control/pc_adder.v"
`include "control/register_forward.v"
`include "memory/buffer_memory.v"
`include "memory/data_memory.v"
`include "memory/inst_memory.v"
`include "memory/reg_file.v"

module top_level(clk, rst);

//Parameters
parameter NUM_BYTES_IN_INST = 2;
parameter INST_ADDR_WIDTH = 16;
parameter INST_DATA_BIT_WIDTH = 16;
parameter INST_MEM_SIZE = 26;
parameter NUM_REG = 16;
parameter REG_DATA_WIDTH = 16;
parameter REG_NUM_WIDTH = 4;
parameter BRANCH_CONTROL_WIDTH = 2;
parameter ALU_CONTROL_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;
parameter IF_BUFFER_WIDTH = 32;
parameter EX_BUFFER_WIDTH = 54;
parameter ALU_SRC_DATA_2_WIDTH = 4;
parameter INST_SHIFT_MAX_WIDTH = 12;
parameter INST_SHIFT_MIN_WIDTH = 8;
parameter INST_SHIFT_AMOUNT = 1;
parameter DATA_MEM_ADDR_WIDTH = 16;
parameter DATA_MEM_SIZE = 3;

//I/O ports
input clk, rst;

//Wires
wire [INST_ADDR_WIDTH-1:0] pc_in, pc_out, pc_decode;
wire [INST_ADDR_WIDTH-1:0] inst_fetch, inst_decode;
wire [INST_ADDR_WIDTH-1:0] branch_addr;
wire [INST_ADDR_WIDTH-1:0] inst_1, inst_2;
wire [BRANCH_CONTROL_WIDTH-1:0] branch_control;
wire [REG_DATA_WIDTH-1:0] rd1_decode, rd2_decode, rd0_decode;
wire [REG_DATA_WIDTH-1:0] rd1_execute, rd2_execute;
wire [REG_DATA_WIDTH-1:0] wrd_execute, r0d_execute, r, data_memory_data_out;
wire [REG_DATA_WIDTH-1:0] alu_a, alu_b;
wire [REG_NUM_WIDTH-1:0] rn1_ex, rn2_ex, offset_ex;

wire [REG_FORWARD_WIDTH-1:0] reg_forward_1, reg_forward_2;

wire flush, halt, branch, jump;
wire exc_inst_memory, exc_alu, exc_data_memory, exc_reg_file;

wire write_reg_decode, write_r0_decode, mem_wrt_decode;
wire alu_a_src_decode, alu_b_src_decode, reg_wr_src_decode;

wire [ALU_CONTROL_WIDTH-1:0] alu_control_decode, alu_control_execute;

wire write_reg_execute, write_r0_execute, mem_wrt_execute;
wire alu_a_src_execute, alu_b_src_execute, reg_wr_src_execute;
wire pc_src;

assign wrd_execute = reg_wr_src_execute ? data_memory_data_out : r;
assign flush = halt | branch;
assign pc_src = branch | jump;

//Instantiations
pc #(
        .INST_ADDR_WIDTH(INST_ADDR_WIDTH)
    ) 
    pc1(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

pc_adder #(
        .INST_ADDR_WIDTH(INST_ADDR_WIDTH),
        .NUM_BYTES_IN_INST(NUM_BYTES_IN_INST)
    ) 
    pc_adder1(
        .rst(rst),
        .pc_in(pc_out),
        .branch_addr(branch_addr),
        .halt(halt),
        .pc_src(pc_src),
        .pc_added(pc_in)        
    );
    
inst_memory #(
        .INST_ADDR_WIDTH(INST_ADDR_WIDTH),
        .INST_DATA_BIT_WIDTH(INST_DATA_BIT_WIDTH),
        .INST_MEM_SIZE(INST_MEM_SIZE)
    ) 
    inst_memory1(
        .rst(rst),
        .addr(pc_out),
        .data(inst_fetch),
        .exc(exc_inst_memory)
    );
    
buffer_memory #(
        .DATA_WIDTH(IF_BUFFER_WIDTH)
    ) 
    buffer_memory_if(
        .clk(clk),
        .rst(rst),
        .flush(flush),
        .data_in({pc_out, inst_fetch}),
        .data_out({pc_decode, inst_decode})
    );

sign_extend_shifter #(
        .DATA_IN_MAX_WIDTH(INST_SHIFT_MAX_WIDTH),
        .DATA_IN_MIN_WIDTH(INST_SHIFT_MIN_WIDTH),
        .DATA_OUT_WIDTH(INST_ADDR_WIDTH),
        .SHIFT_AMOUNT(INST_SHIFT_AMOUNT)
    ) 
    sign_extend_shifter1(
        .rst(rst),
        .data_in(inst_decode[11:0]),        
        .data_out_1(inst_1),
        .data_out_2(inst_2)
    );
    
branch_adder #(
        .INST_1_WIDTH(IF_BUFFER_WIDTH),
        .INST_2_WIDTH(IF_BUFFER_WIDTH),
        .INST_ADDR_WIDTH(INST_ADDR_WIDTH),
        .NUM_BYTES_IN_INST(NUM_BYTES_IN_INST)
    ) 
    branch_adder1(
        .rst(rst),
        .inst_1(inst_1),
        .inst_2(inst_2),
        .pc(pc_decode),
        .jump(jump),
        .branch_addr(branch_addr)
    );
    
control #(
        .BRANCH_CONTROL_WIDTH(BRANCH_CONTROL_WIDTH),
        .ALU_CONTROL_WIDTH(ALU_CONTROL_WIDTH)
    ) 
    control1(
        .rst(rst),
        .op_code(inst_decode[15:12]),
        .func_code(inst_decode[3:0]),
        .exc_inst_memory(exc_inst_memory),
        .exc_alu(exc_alu),
        .exc_data_memory(exc_data_memory),
        .exc_reg_file(exc_reg_file),
        .jump(jump),
        .halt(halt),
        .write_reg(write_reg_decode),
        .write_r0(write_r0_decode),
        .branch_control(branch_control),
        .alu_control(alu_control_decode),
        .mem_wrt(mem_wrt_decode),
        .alu_a_src(alu_a_src_decode),
        .alu_b_src(alu_b_src_decode),
        .reg_wr_src(reg_wr_src_decode)
    );    
   
reg_file #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .REG_NUM_WIDTH(REG_NUM_WIDTH),
        .REG_FORWARD_WIDTH(REG_FORWARD_WIDTH),
        .NUM_REG(NUM_REG)
    ) 
    reg_file1(    
        .rst(rst),
        .rn_1(inst_decode[11:8]),
        .rn_2(inst_decode[7:4]),
        .wrn(rn1_ex),
        .wrd(wrd_execute),
        .r0d(r0d_execute),
        .wr0(write_r0_execute),
        .wr(write_reg_execute),
        .reg_forward_1(reg_forward_1),
        .reg_forward_2(reg_forward_2),
        .rd_1(rd1_decode),
        .rd_2(rd2_decode),
        .rd0(rd0_decode),
        .exception(exc_reg_file)      
    );  

branch_comp #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .BRANCH_CONTROL_WIDTH(BRANCH_CONTROL_WIDTH)
    ) 
    branch_comp1(
        .rst(rst),
        .data_1(rd1_decode),
        .data_2(rd2_decode),
        .branch_control(branch_control),
        .branch(branch)
    );    

register_forward #(
        .REG_NUM_WIDTH(REG_NUM_WIDTH),
        .REG_FORWARD_WIDTH(REG_FORWARD_WIDTH)
    ) 
    register_forward1(
        .rst(rst),
        .rn_1(inst_decode[11:8]),
        .rn_2(inst_decode[7:4]),
        .rn1_ex(rn1_ex),
        .write_reg(write_reg_execute),
        .write_r0(write_r0_execute),
        .reg_forward_1(reg_forward_1),
        .reg_forward_2(reg_forward_2)
    );    


wire [EX_BUFFER_WIDTH-1:0] buffer_data_ex_in;
wire [EX_BUFFER_WIDTH-1:0] buffer_data_ex_out;

assign buffer_data_ex_in = {    mem_wrt_decode,
                                write_reg_decode,
                                write_r0_decode,
                                reg_wr_src_decode,
                                alu_control_decode,
                                alu_a_src_decode,
                                alu_b_src_decode,
                                inst_decode[3:0],
                                inst_decode[7:4],
                                inst_decode[11:8],
                                rd1_decode,
                                rd2_decode
                            }; 

assign mem_wrt_execute = buffer_data_ex_out[53];
assign write_reg_execute = buffer_data_ex_out[52];
assign write_r0_execute = buffer_data_ex_out[51];
assign reg_wr_src_execute = buffer_data_ex_out[50];
assign alu_control_execute = buffer_data_ex_out[49:46];
assign alu_a_src_execute = buffer_data_ex_out[45];
assign alu_b_src_execute = buffer_data_ex_out[44];
assign offset_ex = buffer_data_ex_out[43:40];
assign rn2_ex = buffer_data_ex_out[39:36];
assign rn1_ex = buffer_data_ex_out[35:32];
assign rd1_execute = buffer_data_ex_out[31:16];
assign rd2_execute = buffer_data_ex_out[15:0];
                            
buffer_memory #(
        .DATA_WIDTH(EX_BUFFER_WIDTH)
    ) 
    buffer_memory_ex(
        .clk(clk),
        .rst(rst),        
        .data_in(buffer_data_ex_in),
        .data_out(buffer_data_ex_out)
    );
   
alu_src #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .DATA_2_WIDTH(ALU_SRC_DATA_2_WIDTH)
    ) 
    alu_src_a(
        .rst(rst),
        .data_1(rd1_execute),
        .data_2(offset_ex),        
        .alu_src(alu_a_src_execute),
        .data_out(alu_a)
    );    
    
alu_src #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .DATA_2_WIDTH(ALU_SRC_DATA_2_WIDTH)
    ) 
    alu_src_b(
        .rst(rst),
        .data_1(rd2_execute),
        .data_2(rn2_ex),        
        .alu_src(alu_b_src_execute),
        .data_out(alu_b)
    ); 
    
alu #(
        .REG_DATA_WIDTH(REG_DATA_WIDTH),
        .ALU_CONTROL_WIDTH(ALU_CONTROL_WIDTH)
    ) 
    alu1(
        .rst(rst),
        .a(alu_a),
        .b(alu_b),        
        .alu_control(alu_control_execute),
        .r(r),
        .s(r0d_execute),
        .exc_alu(exc_alu)
    ); 
    
data_memory #(
        .DATA_MEM_ADDR_WIDTH(DATA_MEM_ADDR_WIDTH),
        .DATA_MEM_WIDTH(REG_DATA_WIDTH),
        .DATA_MEM_SIZE(DATA_MEM_SIZE)
    ) 
    data_memory1(
        .rst(rst),
        .addr(r),
        .data_in(rd1_execute),        
        .write(mem_wrt_execute),
        .data_out(data_memory_data_out),
        .exception(exc_data_memory)        
    );      

endmodule

//-----------------------------END OF FILE-------------------------------------