`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:51:02 12/03/2014
// Design Name:   top_level
// Module Name:   /home/brandon/CPE142/sources_1/top_level_fixture.v
// Project Name:  CPE142
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_level
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_level_fixture;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	top_level uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

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

