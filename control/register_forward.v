/**register_forward.v******************************************************
* Checks register operands for data hazards and forwards data as necessary
* 
* Written by Daniel Gallegos, Brandon Ortiz
* CSC/CpE 142, Fall 2014, CSUS
***************************************************************************/


module regiser_forward #(REGISTER_NUMBER_BIT_WIDTH=4) (
	input [REGISTER_NUMBER_BIT_WIDTH-1:0] RN1,
	input [REGISTER_NUMBER_BIT_WIDTH-1:0] RN2,
	input [REGISTER_NUMBER_BIT_WIDTH-1:0] RN1_EX,
	input WriteReg_EX,
	input WriteR0_EX,
	output reg [1:0] Reg_Forwarding1,
	output reg [1:0] Reg_Forwarding2);

always @(*)
begin
	Reg_Forwarding1 = 2'b00;
	Reg_Forwarding2 = 2'b00;

	if (WriteReg_EX) 
		begin
			if (RN1 == RN1_EX)
				Reg_Forwarding1 = 2'b01;
			if (RN2 == RN1_EX)
				Reg_Forwarding2 = 2'b10;
		end

	if (WriteR0_EX)
		begin
			if (RN1 == 0)
				Reg_Forwarding1 = 2'b01;
			if (RN2 == 0)
				Reg_Forwarding2 = 2'b10;
		end
end

endmodule