/* register_forward.v
 * Checks register operands for data hazards and forwards data as necessary
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module register_forward(rst, rn_1, rn_2, rn1_ex, write_reg, write_r0, reg_forward_1, reg_forward_2);

//Parameters
parameter REG_NUM_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;

//I/O ports
input rst;
input [REG_NUM_WIDTH-1:0] rn_1;
input [REG_NUM_WIDTH-1:0] rn_2;
input [REG_NUM_WIDTH-1:0] rn1_ex;
input write_reg;
input write_r0;

//Outputs defined as registers
output reg [REG_FORWARD_WIDTH-1:0] reg_forward_1;
output reg [REG_FORWARD_WIDTH-1:0] reg_forward_2;

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        reg_forward_1 = 0;           
        reg_forward_2 = 0;  
    end
    else
    begin    
        reg_forward_1 = 2'b00;
        reg_forward_2 = 2'b00;

        if (write_reg) 
        begin
            if (rn_1 == rn1_ex)
                reg_forward_1 = 2'b01;
        
            if (rn_2 == rn1_ex)
                reg_forward_2 = 2'b01;
        end

        if (write_r0)
        begin
            if (rn_1 == 0)
                reg_forward_1 = 2'b10;

            if (rn_2 == 0)
                reg_forward_2 = 2'b10;
        end
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------