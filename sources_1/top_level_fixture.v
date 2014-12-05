/* alu_src.v
 * Muxes register data with immediate operand data for ALU operands
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