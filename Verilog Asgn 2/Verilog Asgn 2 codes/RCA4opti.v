`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:52 08/31/2022 
// Design Name: 
// Module Name:    RCA4opti
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
module RCA4opti(
    input [3:0] a,
    output [3:0] sum,
    output [0:0] carryOutput
    );
	 
	 
	wire [2:0] w;					//wire of 3 bit length to store intermediate values
	
	// Cascading all the 4 Full Adders to make a 4-bit Ripple Carry Adder
	
	FullAdder fa1(.a(a[0]), .carryInput(1'b1), .sum(sum[0]), .carryOutput(w[0]));
   FullAdder fa2(.a(a[1]), .carryInput(w[0]), .sum(sum[1]), .carryOutput(w[1]));
   FullAdder fa3(.a(a[2]), .carryInput(w[1]), .sum(sum[2]), .carryOutput(w[2]));
   FullAdder fa4(.a(a[3]), .carryInput(w[2]), .sum(sum[3]), .carryOutput(carryOutput));

endmodule
