`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:37 08/31/2022 
// Design Name: 
// Module Name:    cla16ripple 
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

module cla16ripple(
    input [15:0] a,
    input [15:0] b,
    input [0:0] carryInput,
    output [15:0] sum,
    output [0:0] carryOutput
    );

	wire [2:0] c;				// wire of size 3-bit to store the intermediate values of carries which are used while rippling of four 4-bit carry look-ahead adders
	
	// using four 4-bit carry look-ahead adders in ripple form to find sum of two 16-bit numbers
	cla4 cla_1(.a(a[3:0]), .b(b[3:0]), .carryInput(carryInput), .sum(sum[3:0]), .carryOutput(c[0]));
	cla4 cla_2(.a(a[7:4]), .b(b[7:4]), .carryInput(c[0]), .sum(sum[7:4]), .carryOutput(c[1]));
	cla4 cla_3(.a(a[11:8]), .b(b[11:8]), .carryInput(c[1]), .sum(sum[11:8]), .carryOutput(c[2]));
	cla4 cla_4(.a(a[15:12]), .b(b[15:12]), .carryInput(c[2]), .sum(sum[15:12]), .carryOutput(carryOutput));
	
endmodule
