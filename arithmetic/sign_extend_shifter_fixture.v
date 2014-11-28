`include "sign_extend_shifter.v"


module sign_extend_shifter_fixture;

reg [11:0] data_in;
wire [15:0] data_out;
reg jump;

sign_extend_shifter #(12,8,16,1) ext_shift (data_in,jump,data_out);

initial
	$vcdpluson;

initial
begin
	$monitor($time," data_in: %x \t jump: %x | data_out %x", data_in, jump, data_out);
end

always
begin
	data_in = 12'b0000_0000_0000;
	#1 data_in = 12'b0000_0000_0001;
	#1 data_in = 12'b0000_1000_0001;
	#1 data_in = 12'b1000_0000_0000;
	#1 data_in = 12'b1000_0000_0001;
	#1 data_in = 12'b1000_1000_0001;
end

initial
begin
	jump = 0;
	#5 jump =1;
	#5 $finish;
end

endmodule 


