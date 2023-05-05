`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:21 08/26/2022 
// Design Name: 
// Module Name:    RCA16TB 
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

module RCA16TB(
    );
	reg [15:0] a = 16'd0;								//Initializing first input variable as 0
	reg [15:0] b = 16'd0;								//Initializing second input variable as 0
	reg [0:0] carryInput = 1'd0;						//Initializing carry-in variable as 0
	
	wire [15:0] sum;										//Output variable(16-bit) to store sum
	wire carryOutput;										//Output variable(1-bit) for storing carry-out
	
	// Instantiating the 16-bit Ripple Carry Adder unit for testing
	RCA16 rca(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput));
	
	initial begin
		
		$monitor("A = %b, B = %b, carry-in = %b, sum = %b, carry-out = %b", a, b, carryInput, sum, carryOutput);		//Monitoring the changes
		
		//Changing the inputs so as to verify output for different set of inputs
		#5 a = 16'd28; b = 16'd65;
		#5 a = 16'd4517; b = 16'd322; carryInput = 1'd1;
		#5 a = 16'd1917; b = 16'd9539; carryInput = 1'd0;
		#5 a = 16'd22128; b = 16'd36127;
		#5 a = 16'd23645; b = 16'd29943;
		#5 a = 16'd32768; b = 16'd32768;
		#5 a = 16'd4567; b = 16'd2234;
		#5 a = 16'd65535; b = 16'd65535;
		#5 $finish;
	end


endmodule
