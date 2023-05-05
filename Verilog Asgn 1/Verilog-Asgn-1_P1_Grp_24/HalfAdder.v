`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:07 08/26/2022 
// Design Name: 
// Module Name:    HalfAdder 
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

module HalfAdder(
    input [0:0] a,
    input [0:0] b,
    output [0:0] sum,
    output [0:0] carryOutput
    );
	
	xor g1(sum,a,b);						// calculating XOR of a and b and storing in sum
	and g2(carryOutput,a,b);			// calculating AND of a and b and storing in carryOutput

endmodule
