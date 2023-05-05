`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:20 08/26/2022 
// Design Name: 
// Module Name:    RCA32TB 
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

module RCA32TB(
    );
	reg [31:0] a = 32'd0;								//Initializing first input variable as 0
	reg [31:0] b = 32'd0;								//Initializing second input variable as 0
	reg [0:0] carryInput = 1'd0;						//Initializing carry-in variable as 0
	
	wire [31:0] sum;										//Output variable(32-bit) to store sum
	wire carryOutput;										//Output variable(1-bit) for storing carry-out
	
	// Instantiating the 32-bit Ripple Carry Adder unit for testing
	RCA32 rca(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput));
	
	initial begin
		
		$monitor("A = %b, B = %b, carry-in = %b, sum = %b, carry-out = %b", a, b, carryInput, sum, carryOutput);		//Monitoring the changes
		
		//Changing the inputs so as to verify output for different set of inputs
		#5 a = 32'd2212768; b = 32'd3612427;
		#5 a = 32'd23632145; b = 32'd29946753;
		#5 a = 32'd4519087; b = 32'd326432; carryInput = 1'd1;
		#5 a = 32'd1915427; b = 32'd9538849; carryInput = 1'd0;
		#5 a = 32'd32768; b = 32'd32768;
		#5 a = 32'd45633827; b = 32'd22390374;
		#5 a = 32'd655355467; b = 32'd655354378;
		#5 a = 32'd4294967295; b = 32'd4294967295;
		#5 $finish;
	end


endmodule
