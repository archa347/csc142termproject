/* register_forward.v
 * Checks register operands for data hazards and forwards data as necessary
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module (rn1, rn2, rn1_ex, WriteReg_EX, WriteR0_EX, Reg_Forwarding1, Reg_Forwarding2);

//Parameters
parameter REGISTER_NUMBER_BIT_WIDTH = 4;
parameter REG_FORWARD_WIDTH = 2;

//I/O ports
input [REGISTER_NUMBER_BIT_WIDTH-1:0] rn1;
input [REGISTER_NUMBER_BIT_WIDTH-1:0] rn2;
input [REGISTER_NUMBER_BIT_WIDTH-1:0] rn1_ex;
input WriteReg_EX;
input WriteR0_EX;

//Outputs defined as registers
output reg [REG_FORWARD_WIDTH-1:0] Reg_Forwarding1;
output reg [REG_FORWARD_WIDTH-1:0] Reg_Forwarding2;

//Procedural blocks
always @(*)
begin
    Reg_Forwarding1 = 2'b00;
    Reg_Forwarding2 = 2'b00;

    if (WriteReg_EX) 
    begin
        if (rn1 == rn1_ex)
            Reg_Forwarding1 = 2'b01;
    
        if (rn2 == rn1_ex)
            Reg_Forwarding2 = 2'b01;
    end

    if (WriteR0_EX)
    begin
        if (rn1 == 0)
            Reg_Forwarding1 = 2'b10;

        if (rn2 == 0)
            Reg_Forwarding2 = 2'b10;
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------
