`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:40 08/26/2022 
// Design Name: 
// Module Name:    RCA64 
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

module RCA64(
    input [63:0] a,
    input [63:0] b,
    input [0:0] carryInput,
    output [63:0] sum,
    output [0:0] carryOutput
    );

	wire [0:0] w1;				//wire of 1 bit length to store intermediate value
	
	// Cascading 2 32-bit Ripple Carry Adders to make a single 64-bit Ripple Carry Adder
	// we store the carry-out of the first 32-bits(leftmost 32 bits) in w and pass it carry-in for the next 32-bits(rightmost 32 bits)
	RCA32 rca1(.a(a[31:0]), .b(b[31:0]), .carryInput(carryInput[0:0]), .sum(sum[31:0]), .carryOutput(w1[0:0]));
	RCA32 rca2(.a(a[63:32]), .b(b[63:32]), .carryInput(w1[0:0]), .sum(sum[63:32]), .carryOutput(carryOutput[0:0]));

endmodule
