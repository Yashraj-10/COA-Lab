`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:53:10 08/26/2022 
// Design Name: 
// Module Name:    RCA64TB 
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

module RCA64TB(
    );
	reg [63:0] a = 64'd0;								//Initializing first input variable as 0
	reg [63:0] b = 64'd0;								//Initializing second input variable as 0
	reg [0:0] carryInput = 1'd0;						//Initializing carry-in variable as 0
	
	wire [63:0] sum;										//Output variable(64-bit) to store sum
	wire carryOutput;										//Output variable(1-bit) for storing carry-out
	
	// Instantiating the 64-bit Ripple Carry Adder unit for testing
	RCA64 rca(.a(a), .b(b), .carryInput(carryInput), .sum(sum), .carryOutput(carryOutput));
	
	initial begin
		
		$monitor("A = %b, B = %b, carry-in = %b, sum = %b, carry-out = %b", a, b, carryInput, sum, carryOutput);		//Monitoring the changes
		
		//Changing the inputs so as to verify output for different set of inputs
		#5 a = 64'd45622127699800; b = 64'd39879961242700;
		#5 a = 64'd123450967890; b = 64'd987456765432190;
		#5 a = 64'd135792462378801; b = 64'd246809823135792; carryInput = 1'd1;
		#5 a = 64'd191542756779004; b = 64'd953884934268; carryInput = 1'd0;
		#5 a = 64'd744073706477489551; b = 64'd1257488446744071615;
		#5 a = 64'd18446744073709551615; b = 64'd18446744073709551615;
		
		#5 $finish;
	end

endmodule
