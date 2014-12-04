/* register_forward.v
 * Checks register operands for data hazards and forwards data as necessary
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module register_forward(rn_1, rn_2, rn_1_ex, write_reg, write_r0, reg_forwarding_1, reg_forwarding_2);

//Parameters
parameter REG_NUM_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;

//I/O ports
input [REG_NUM_WIDTH-1:0] rn_1;
input [REG_NUM_WIDTH-1:0] rn_2;
input [REG_NUM_WIDTH-1:0] rn_1_ex;
input write_reg;
input write_r0;

//Outputs defined as registers
output reg [REG_FORWARD_WIDTH-1:0] reg_forwarding_1;
output reg [REG_FORWARD_WIDTH-1:0] reg_forwarding_2;

//Procedural blocks
always @(*)
begin
    reg_forwarding_1 = 2'b00;
    reg_forwarding_2 = 2'b00;

    if (write_reg) 
    begin
        if (rn_1 == rn_1_ex)
            reg_forwarding_1 = 2'b01;
    
        if (rn_2 == rn_1_ex)
            reg_forwarding_2 = 2'b01;
    end

    if (write_r0)
    begin
        if (rn_1 == 0)
            reg_forwarding_1 = 2'b10;

        if (rn_2 == 0)
            reg_forwarding_2 = 2'b10;
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------
