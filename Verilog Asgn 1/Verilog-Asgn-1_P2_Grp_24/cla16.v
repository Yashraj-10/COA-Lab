`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:32:56 08/31/2022 
// Design Name: 
// Module Name:    cla16 
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

module cla16(
    input [15:0] a,
    input [15:0] b,
    input [0:0] carryInput,
    output [15:0] sum,
    output [0:0] carryOutput,
    output [0:0] prop,
    output [0:0] gene
    );
	
	// wires for stoting intermediate values of propogates, generates and carries
	wire [3:0] p;
	wire [3:0] g;
	wire [3:0] c;
	
	// using four cascaded 4-bit augmented carry look-ahead adder and a look-ahead carry unit to calculate sum of two 16-bit numbers
	cla4aug cla1(.a(a[3:0]), .b(b[3:0]), .carryInput(carryInput), .sum(sum[3:0]), .carryOutput(), .prop(p[0]), .gene(g[0]));
   cla4aug cla2(.a(a[7:4]), .b(b[7:4]), .carryInput(c[1]), .sum(sum[7:4]), .carryOutput(), .prop(p[1]), .gene(g[1]));
   cla4aug cla3(.a(a[11:8]), .b(b[11:8]), .carryInput(c[2]), .sum(sum[11:8]), .carryOutput(), .prop(p[2]), .gene(g[2]));
   cla4aug cla4(.a(a[15:12]), .b(b[15:12]), .carryInput(c[3]), .sum(sum[15:12]), .carryOutput(), .prop(p[3]), .gene(g[3]));
	
	lcu l(.p(p), .g(g), .carryInput(carryInput), .carryOutput(carryOutput), .prop(prop), .gene(gene), .c(c));

endmodule

module wrapper(
	 input clk,
	 input rst,
    input [15:0] a,
    input [15:0] b,
    input [0:0] carryInput,
    output reg [15:0] sum,
    output reg [0:0] carryOutput,
    output reg [0:0] prop,
    output reg [0:0] gene
	);
	
	reg [15:0] a_reg;
	reg [15:0] b_reg;
	reg [0:0] carryInput_reg;
	wire [15:0] sum_net;
	wire [0:0] carryOutput_net;
	wire [0:0] prop_net;
	wire [0:0] gene_net;
	
	always@(posedge clk)
		begin
			if(rst)
				begin
					a_reg<=16'd0;
					b_reg<=16'd0;
					carryInput_reg<=1'd0;
					sum<=16'd0;
					carryOutput<=1'd0;
					prop<=1'd0;
					gene<=1'd0;
				end
			else
				begin
					a_reg<=a;
					b_reg<=b;
					carryInput_reg<=carryInput;
					sum<=sum_net;
					carryOutput<=carryOutput_net;
					prop<=prop_net;
					gene<=gene_net;
				end
		end
		
	cla16ripple cla(a_reg, b_reg, carryInput_reg, sum_net, carryOutput_net, prop_net, gene_net);
	
endmodule
	
				
				