`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:40:39 08/26/2022 
// Design Name: 
// Module Name:    RCA8 
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

module RCA8(
    input [7:0] a,
    input [7:0] b,
    input [0:0] carryInput,
    output [7:0] sum,
    output [0:0] carryOutput
    );	
	 
	wire [6:0] w;					//wire of 7 bit length to store intermediate values
	
	// Cascading all the 8 Full Adders to make a 8-bit Ripple Carry Adder
	
	FullAdder fa1(.a(a[0]), .b(b[0]), .carryInput(carryInput), .sum(sum[0]), .carryOutput(w[0]));
   FullAdder fa2(.a(a[1]), .b(b[1]), .carryInput(w[0]), .sum(sum[1]), .carryOutput(w[1]));
   FullAdder fa3(.a(a[2]), .b(b[2]), .carryInput(w[1]), .sum(sum[2]), .carryOutput(w[2]));
   FullAdder fa4(.a(a[3]), .b(b[3]), .carryInput(w[2]), .sum(sum[3]), .carryOutput(w[3]));
   FullAdder fa5(.a(a[4]), .b(b[4]), .carryInput(w[3]), .sum(sum[4]), .carryOutput(w[4]));
   FullAdder fa6(.a(a[5]), .b(b[5]), .carryInput(w[4]), .sum(sum[5]), .carryOutput(w[5]));
   FullAdder fa7(.a(a[6]), .b(b[6]), .carryInput(w[5]), .sum(sum[6]), .carryOutput(w[6]));
   FullAdder fa8(.a(a[7]), .b(b[7]), .carryInput(w[6]), .sum(sum[7]), .carryOutput(carryOutput));

endmodule
