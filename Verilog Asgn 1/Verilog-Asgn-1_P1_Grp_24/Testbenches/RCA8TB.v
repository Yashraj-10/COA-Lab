`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:15 08/26/2022 
// Design Name: 
// Module Name:    RCA8TB 
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

module RCA8TB(
    );

	reg [7:0] a = 8'd0;								//Initializing first input variable as 0
	reg [7:0] b = 8'd0;								//Initializing second input variable as 0
	reg [0:0] carryInput = 1'd0;					//Initializing carry-in variable as 0
	
	wire [7:0] sum;									//Output variable(8-bit) to store sum
	wire carryOutput;									//Output variable(1-bit) for storing carry-out
	
	// Instantiating the 8-bit Ripple Carry Adder unit for testing
	RCA8 rca(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput));
	
	initial begin
		
		$monitor("A = %b, B = %b, carry-in = %b, sum = %b, carry-out = %b", a, b, carryInput, sum, carryOutput);		//Monitoring the changes
		
		//Changing the inputs so as to verify output for different set of inputs
		#5 a = 8'd10; b = 8'd24;
		#5 a = 8'd19; b = 8'd23; carryInput = 1'd1;
		#5 a = 8'd117; b = 8'd93; carryInput = 1'd0;
		#5 a = 8'd128; b = 8'd127;
		#5 a = 8'd234; b = 8'd243;
		#5 a = 8'd255; b = 8'd255;
		#5 $finish;
	end

endmodule
