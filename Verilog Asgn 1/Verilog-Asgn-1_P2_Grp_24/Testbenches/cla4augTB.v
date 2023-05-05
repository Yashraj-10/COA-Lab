`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:49:18 08/31/2022 
// Design Name: 
// Module Name:    cla4augTB 
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

module cla4augTB(
    );

	 reg [3:0] a = 4'b0000;
	 reg [3:0] b = 4'b0000;
    reg [0:0] carryInput = 1'b0;

    wire [3:0] sum;
    wire [0:0] carryOutput;
	 wire [0:0] prop;
	 wire [0:0] gene;

    cla4aug cla1(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput), .prop(prop), .gene(gene));

    initial begin
	 
        $monitor("a = %b, b = %b, carry-input = %b, sum = %b, carry-output = %b, propogate block = %b, generate block = %b", a, b, carryInput, sum, carryOutput, prop, gene);
        
        #5 a = 4'b0100; b = 4'b1001;
        #5 a = 4'b1001; b = 4'b1010;
        #5 a = 4'b1100; b = 4'b1001;
        #5 a = 4'b1111; b = 4'b1111;
        #5 $finish;
    end

endmodule
