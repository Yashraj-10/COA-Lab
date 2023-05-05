`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:55:16 08/26/2022 
// Design Name: 
// Module Name:    RCA32 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//--------------------------------------------------------------------------------
// Assignment - 3
// Computer Oraganisation and Architecture Lab
// Semester - Autumn 2022-23
// Group No 24
// Yashraj Singh - 20CS10079
// Vikas Vijaykumar Bastewad - 20CS10073
//--------------------------------------------------------------------------------

module RCA32(
    input [31:0] a,
    input [31:0] b,
    input [0:0] carryInput,
    output [31:0] sum,
    output [0:0] carryOutput
    );

	wire [0:0] w1;				//wire of 1 bit length to store intermediate value
	
	// Cascading 2 16-bit Ripple Carry Adders to make a single 32-bit Ripple Carry Adder
	// we store the carry-out of the first 16-bits(leftmost 16 bits) in w and pass it carry-in for the next 16-bits(rightmost 16 bits)
	RCA16 rca1(.a(a[15:0]), .b(b[15:0]), .carryInput(carryInput[0:0]), .sum(sum[15:0]), .carryOutput(w1[0:0]));
	RCA16 rca2(.a(a[31:16]), .b(b[31:16]), .carryInput(w1[0:0]), .sum(sum[31:16]), .carryOutput(carryOutput[0:0]));

endmodule
