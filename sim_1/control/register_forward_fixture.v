`include "register_forward.v"

module register_forward_fixture;

reg [3:0] RN1;
reg [3:0] RN2;
reg [3:0] RN1_EX;
reg WriteReg_EX, WriteR0_EX;
wire [1:0] Reg_Forwarding1,Reg_Forwarding2;

initial
	$vcdpluson;


initial
begin
	$monitor($time, " RN1: %x  RN2: %x  RN1_EX: %x  WriteReg_EX: %x  WriteR0_EX: %x || Reg_Forwarding1: %b  Reg_Forwarding2: %b", 
	RN1, RN2, RN1_EX, WriteReg_EX, WriteR0_EX, Reg_Forwarding1, Reg_Forwarding2);
	#12 $finish;
end

register_forward reg_forw(RN1,RN2,RN1_EX,WriteReg_EX,WriteR0_EX,Reg_Forwarding1,Reg_Forwarding2);

always
begin
	#1 RN1 = 4'b1010;
	#1 RN1 = 4'b0101;
	#1 RN1 = 4'b0011;
	#1 RN1 = 0;
	#1 RN1 = 4'b0111;;
	#1 RN1 = 0;
end

always
begin
	#1 RN2 = 4'b1111;
	#1 RN2 = 4'b1100;
	#1 RN2 = 4'b0011;
	#1 RN2 = 4'b1001;;
	#1 RN2 = 0;
	#1 RN2 = 0;
end

always
begin
	#1 RN1_EX = 4'b1010;
	#1 RN1_EX = 4'b1100;
	#1 RN1_EX = 4'b0011;
end

initial
begin
	#1 WriteReg_EX = 1;
	#3 WriteReg_EX = 0;
end

initial
begin
 	#4 WriteR0_EX = 1;
 	#3 WriteR0_EX = 0;
end

endmodule

