`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:54 08/31/2022 
// Design Name: 
// Module Name:    cla16TB 
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

module cla16TB(
    );

	 reg [15:0] a = 16'd0;
	 reg [15:0] b = 16'd0;
    reg carryInput = 1'b0;

    wire [15:0] sum;
    wire [0:0] carryOutput;
	 wire [0:0] prop;
	 wire [0:0] gene;

    cla16 cla1(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput), .prop(prop), .gene(gene));

    initial begin
	 
        $monitor("a = %b, b = %b, carry-input = %b, sum = %b, carry-output = %b, propogate block = %b, generate block = %b", a, b, carryInput, sum, carryOutput, prop, gene,);
        
        #5 a = 16'd414; b = 16'd1036;
        #5 a = 16'd5045; b = 16'd45042;
        #5 a = 16'd32768; b = 16'd32768;
        #5 a = 16'd65535; b = 16'd65535;
        #5 $finish;
    end

endmodule
