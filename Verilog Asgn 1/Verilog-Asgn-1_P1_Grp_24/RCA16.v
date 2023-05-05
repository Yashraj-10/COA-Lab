`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:27 08/26/2022 
// Design Name: 
// Module Name:    RCA16 
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

module RCA16(
    input [15:0] a,
    input [15:0] b,
    input [0:0] carryInput,
    output [15:0] sum,
    output [0:0] carryOutput
    );

	wire [0:0] w1;				//wire of 1 bit length to store intermediate value
	
	// Cascading 2 8-bit Ripple Carry Adders to make a single 16-bit Ripple Carry Adder
	// we store the carry-out of the first 8-bits(leftmost 8 bits) in w and pass it carry-in for the next 8-bits(rightmost 8 bits)
	RCA8 rca1(.a(a[7:0]), .b(b[7:0]), .carryInput(carryInput[0:0]), .sum(sum[7:0]), .carryOutput(w1[0:0]));
	RCA8 rca2(.a(a[15:8]), .b(b[15:8]), .carryInput(w1[0:0]), .sum(sum[15:8]), .carryOutput(carryOutput[0:0]));

endmodule
