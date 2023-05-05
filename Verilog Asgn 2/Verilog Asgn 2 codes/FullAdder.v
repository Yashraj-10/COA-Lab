`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:19 08/26/2022 
// Design Name: 
// Module Name:    FullAdder 
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

module FullAdder(
    input [0:0] a,
    input [0:0] carryInput,
    output [0:0] sum,
    output [0:0] carryOutput
    );

	// wire w1, w2, w3;								//wires for intermediate step variables
	
	// xor g1(sum,a,b,carryInput);				// calculating XOR of a,b and carryInput and storing in sum
	// and g2(w1,a,b);								// calculating AND of a and b and storing in w1
	// xor g3(w2,a,b);								// calculating XOR of a and b and storing in w2
	// and g4(w3,w2,carryInput);					// calculating AND of carryInput and w2 and storing in w3
	// or  g5(carryOutput,w1,w3);					// calculating OR of w1 and w3 and storing in carryOutput

    xor x1(sum, a, carryInput);
    and a1(carryOutput, a, carryInput);

endmodule
