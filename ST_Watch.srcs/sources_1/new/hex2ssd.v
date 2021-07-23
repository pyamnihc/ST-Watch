`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2018 23:19:08
// Design Name: 
// Module Name: hex2ssd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hex2ssd(
input [5:0] hex,
output reg [6:0] segment // 7 segment output
    );

//active low logic to turn on the segment
//use case statement to represent each hexadecimal number
always @ (*)
   case (hex) 
		0: segment = 7'b1000000;
		1: segment = 7'b1111001;
		2: segment = 7'b0100100;
		3: segment = 7'b0110000;
		4: segment = 7'b0011001;
		5: segment = 7'b0010010;
		6: segment = 7'b0000010;
		7: segment = 7'b1011000;
		8: segment = 7'b0000000;
		9: segment = 7'b0010000;
	    10: segment = 7'b1111111; //
		11: segment = 7'b0001000; //A
		12: segment = 7'b0000011; //b
		13: segment = 7'b1000110; //C
		14: segment = 7'b0100001; //d
		15: segment = 7'b0000110; //E
		16: segment = 7'b0001110; //F
		17: segment = 7'b1000010; //G
		18: segment = 7'b0001011; //h
		19: segment = 7'b1111011; //i
		20: segment = 7'b1100001; //J
		21: segment = 7'b1001001; //K
		22: segment = 7'b1000111; //L
		23: segment = 7'b0101010; //m
		24: segment = 7'b0101011; //n
		25: segment = 7'b0100011; //o
		26: segment = 7'b0001100; //P
		27: segment = 7'b0011000; //q
		28: segment = 7'b0101111; //r
		29: segment = 7'b0010010; //S
		30: segment = 7'b0000111; //t
		31: segment = 7'b1100011; //u
		32: segment = 7'b1100010; //V
		33: segment = 7'b0010101; //w
		34: segment = 7'b0001001; //X
		35: segment = 7'b0010001; //y
		36: segment = 7'b0100100; //Z
      default: segment = 7'b0111111; //default is - 
   endcase	
    
endmodule