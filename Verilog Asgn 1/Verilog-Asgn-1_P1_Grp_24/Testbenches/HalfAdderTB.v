`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:52 08/26/2022 
// Design Name: 
// Module Name:    HalfAdderTB 
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

module HalfAdderTB(
    );

	reg a = 1'b0;				//Initializing first input variable as 0
	reg b = 1'b0;				//Initializing second input variable as 0
	
	wire sum;					//Output varibale(1-bit) for storing sum
	wire carryOutput;			//Output variable(1-bit) for storing carry-out
	
	// Instantiating the HalfAdder unit for testing
	HalfAdder HA(.a(a), .b(b), .sum(sum), .carryOutput(carryOutput));
	
	initial begin
		
		$monitor("A = %b, B = %b, sum = %b, carry = %b", a, b, sum, carryOutput);		//Monitoring the changes
		
		//Changing the inputs so as to verify output for different set of inputs
		#5 a = 1'b0; b = 1'b1;
		#5 a = 1'b1; b = 1'b0;
		#5 a = 1'b1; b = 1'b1;
		#5 $finish;
	end

endmodule
