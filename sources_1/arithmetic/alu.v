/* alu.v
 * Main ALU for the CPU system
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module alu (rst, a, b, alu_control, r, s, exc_alu);

//Parameters
parameter REG_DATA_WIDTH = 16;
parameter ALU_CONTROL_WIDTH = 4;

//Function Codes
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
input [REG_DATA_WIDTH-1:0] a, b;
input [ALU_CONTROL_WIDTH-1:0] alu_control;

//Output defined as register
output reg [REG_DATA_WIDTH-1:0] r;
output reg [REG_DATA_WIDTH-1:0] s;
output reg exc_alu;

//Registers
reg [REG_DATA_WIDTH*2-1:0] ovf_result; 	// ALU result upper and lower half

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        r = 0;
        s = 0;
        exc_alu = 0;
        ovf_result = 0;
    end
    else
    begin
        exc_alu = 0;   //combinatorial logic

        case (alu_control)
            ADD: 
            begin 
                ovf_result = a + b;

                if ( (a[REG_DATA_WIDTH-1] == b[REG_DATA_WIDTH-1]) && 
                     (a[REG_DATA_WIDTH-1] != ovf_result[REG_DATA_WIDTH-1])
                ) begin
                    // Overflow occurs when (-) + (-) = (+) or (+) + (+) = (-)
                    $display("Arithmetic overflow!");
                    exc_alu = 1;
                end
            end
            
            SUB: 
            begin
                ovf_result = a - b;
            
                if ( (a[REG_DATA_WIDTH-1] != b[REG_DATA_WIDTH-1]) && 
                     (a[REG_DATA_WIDTH-1] != ovf_result[REG_DATA_WIDTH-1])
                    ) 
                begin
                    // Overflow occurs when (-) - (+) = (+) or (+) - (-) = (-)
                    $display("Arithmetic overflow!");
                    exc_alu = 1;
                end
            end
            
            AND: 
                ovf_result = a & b;

            OR:  
                ovf_result = a | b;

            MUL: 
                ovf_result = a * b;  //Upper half will automatically be in ovf_result

            DIV: 
            begin
                ovf_result = a / b;	//integer division result
                ovf_result[REG_DATA_WIDTH*2-1:REG_DATA_WIDTH] = a % b; //Remainder result
            end
        
            SLL: 
                ovf_result = a << b;  

            SLR: 
                ovf_result = a >> b;

            ROL: 
            begin 
                ovf_result = a; 
                ovf_result = ovf_result << b;   //Shift bits
                //Then copy shifted bits from upper half to lower
                ovf_result[REG_DATA_WIDTH-1:0] = ovf_result[REG_DATA_WIDTH*2-1:REG_DATA_WIDTH] | ovf_result[REG_DATA_WIDTH-1:0];  
            end

            ROR: 
            begin
                ovf_result = 0;  // Takes care of lower half
                ovf_result[REG_DATA_WIDTH*2-1:REG_DATA_WIDTH] = a;	   //Put operand a in upper half
                ovf_result = ovf_result >> b;   //shift bits left
                //move lower portion of upper half to low portion of lower half
                //Then copy shifted bits from upper half to lower
                ovf_result[REG_DATA_WIDTH-1:0] = ovf_result[REG_DATA_WIDTH*2-1:REG_DATA_WIDTH] | ovf_result[REG_DATA_WIDTH-1:0];  
            end
        
            0:  
                ovf_result = 0;  //No operation requested
          
            default: 
            begin
                $display("Invalid function code");
                exc_alu = 1;
            end
        endcase

        // Assign to result output signals
        r = ovf_result[REG_DATA_WIDTH-1:0];
        s = ovf_result[REG_DATA_WIDTH*2-1:REG_DATA_WIDTH];
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------