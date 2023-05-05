`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:25 08/31/2022 
// Design Name: 
// Module Name:    lcu 
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

module lcu(
    input [3:0] p,
    input [3:0] g,
    input [0:0] carryInput,
    output [0:0] carryOutput,
    output [0:0] prop,
    output [0:0] gene,
    output [3:0] c
    );
	
	// calculating the look-ahead carries using generate block and propogate block from the precceding level
	assign c[0] = carryInput;
	assign c[1] = g[0] | (p[0] & carryInput);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & carryInput);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & carryInput);

	assign carryOutput = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & carryInput);
	
	// calculating propogate block and generate block for the succeeding level
	assign prop = p[3] & p[2] & p[1] & p[0];
   assign gene = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule
