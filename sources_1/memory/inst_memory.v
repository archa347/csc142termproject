/* inst_memory.v
 * Memory for holding CPU instructions
 * Written by Daniel Gallegos and Brandon Ortiz
 * CSC142, Fall 2014, CSUS
*/

module inst_memory(rst, addr, data, exc);

//Parameters
parameter INST_ADDR_WIDTH = 16;
parameter INST_DATA_BIT_WIDTH = 16;
parameter INST_MEM_SIZE = 26;

//I/O ports
input rst;
input [INST_ADDR_WIDTH-1:0] addr;

//Outputs defined as registers
output reg [INST_DATA_BIT_WIDTH-1:0] data;
output reg exc;

//Registers
reg [INST_DATA_BIT_WIDTH-1:0] mem [INST_MEM_SIZE-1:0];

//Integers
integer i;

reg [INST_ADDR_WIDTH-1:0] instructions [INST_MEM_SIZE-1:0];

initial
begin
	data = 0;
    exc = 0;
    
    instructions[0] = 16'b0000_0001_0010_1111;  //00 ADD R1, R2
	instructions[1] = 16'b0000_0001_0010_1110; 	//02 SUB R1, R2
	instructions[2] = 16'b0000_0011_0100_1100;  //04 OR R3, R4
	instructions[3] = 16'b0000_0011_0010_1101;	//06 AND R3, R2
	instructions[4] = 16'b0000_0101_0110_0001;	//08 MUL R5, R6
	instructions[5] = 16'b0000_0001_0101_0010;	//0A DIV R1, R5
	instructions[6] = 16'b0000_0000_0000_1110;	//0C SUB R0, R0
	instructions[7] = 16'b0000_0100_0011_1010;	//0E SLL R4, 3
	instructions[8] = 16'b0000_0100_0010_1011;	//10 SLR R4, 2
	instructions[9] = 16'b0000_0110_0011_1000;	//12 ROR R6, 3
	instructions[10]= 16'b0000_0110_0010_1001;	//14 ROL R6, 2
	instructions[11]= 16'b0110_0111_0000_0100;	//16 BEQ R7, 4
	instructions[12]= 16'b0000_1011_0001_1111;	//18 ADD R11, R1
	instructions[13]= 16'b0100_0111_0000_0101;	//1A BLT R7, 5
	instructions[14]= 16'b0000_1011_0010_1111;	//1C ADD R11, R2
	instructions[15]= 16'b0101_0111_0000_0010;	//1E BGT R7, 2
	instructions[16]= 16'b0000_0001_0001_1111;	//20 ADD R1, R1
	instructions[17]= 16'b0000_0001_0001_1111;	//22 ADD R1, R1
	instructions[18]= 16'b1000_1000_1001_0000;	//24 LW R8, 0(R9)
	instructions[19]= 16'b0000_1000_1000_1111;	//26 ADD R8, R8
	instructions[20]= 16'b1011_1000_1001_0010;	//28 SW R8, 2 (R9)
	instructions[21]= 16'b1000_1010_1001_0010;	//2A LW R10, 2 (R9)
	instructions[22]= 16'b0000_1100_1100_1111;	//2C ADD R12, R12
	instructions[23]= 16'b0000_1101_1101_1110;	//2E SUB R13, R13
	instructions[24]= 16'b0000_1100_1101_1111;	//30 ADD R12, R13
	instructions[25]= 16'hEFFF;					//32 EFFF    	
end

//Procedural blocks
always @(*)
begin
    if (!rst)
    begin
        for (i = 0; i < INST_MEM_SIZE; i = i + 1)
            mem[i] = instructions[i];   
    end
    else
    begin
        if ((addr / 2) < INST_MEM_SIZE)
            data = mem[addr / 2];        
        else
            data = 0;
    end
end

endmodule

//-----------------------------END OF FILE-------------------------------------
	
