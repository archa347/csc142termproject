/* top_level_fixture.v
 * Top level fixture for the CPU system
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

`include "top_level.v"

module top_level_fixture;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	top_level uut (
		.clk(clk), 
		.rst(rst)
	);

	initial $vcdpluson;

	initial begin
		$monitor($time, "\n********IF****************|**************ID********************|*************EX***************| \
\npc_out: %x                inst_decode:  %x                                   \
\npc_in:  %x                rd1_decode:  %x                      rd1_execute: %x   \
\ninst_fetch : %x           rd2_decode:  %x                      rd2_execute: %x   \
\nbranch_addr : %x                                               alu_a: %x        \
\n                                                                   alu_b: %x        \
\n    \
\n *******************************Control Signals*********************************************** *********************************\
\n halt : %x   branch : %x   jump: %x  alu_control_decode: %x  mem_wrt_decode : %x  \
\n write_reg_decode %x write_r0_decode: %x  alu_a_src_decode : %x   \
\n reg_wr_src_decode : %x    \
\n *******************************Registers***************************************************************************************\
\n R0:%x\nR1:%x\nR2:%x\nR3:%x\nR4:%x\nR5:%x\nR6:%x\nR7:%x\nR8:%x\
\n R9:%x\nR10:%x\nR11:%x\nR12:%x\nR13:%x\nR14:%x\nR15:%x\
\n -------------------------------------------------------------------------------------------------------------------------------\
\n *******************************************************************************************************************************",
uut.pc_out, uut.inst_decode,
uut.pc_in,uut.rd1_decode,uut.rd1_execute,
uut.inst_fetch, uut.rd2_decode,uut.rd2_execute,
uut.branch_addr,  uut.alu_a,
uut.alu_b,
uut.halt, uut.branch, uut.jump,uut.alu_control_decode, uut.mem_wrt_decode,
uut.write_reg_decode, uut.write_r0_decode, uut.alu_a_src_decode,
uut.reg_wr_src_decode,
uut.reg_file1.rfile[0],uut.reg_file1.rfile[1],uut.reg_file1.rfile[2],uut.reg_file1.rfile[3],uut.reg_file1.rfile[4],uut.reg_file1.rfile[5],
uut.reg_file1.rfile[6],uut.reg_file1.rfile[7],uut.reg_file1.rfile[8],uut.reg_file1.rfile[9],uut.reg_file1.rfile[10],uut.reg_file1.rfile[11],
uut.reg_file1.rfile[12],uut.reg_file1.rfile[13],uut.reg_file1.rfile[14],uut.reg_file1.rfile[15]
);
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        rst = 1;
        
		// Add stimulus here
        #1000;
        
        $finish;
	end
    
    //Setup the clock to toggle every 10 time units
    initial
    begin
       clk = 1'b0;
       forever #10 clk = ~clk;
    end

    

      
endmodule
