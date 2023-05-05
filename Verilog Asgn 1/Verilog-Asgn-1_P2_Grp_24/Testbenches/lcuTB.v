`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:49 08/31/2022 
// Design Name: 
// Module Name:    lcuTB 
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
module lcuTB(
    );
	 reg [3:0] p = 4'b0000;
	 reg [3:0] g = 4'b0000;
    reg carryInput = 1'b0;

    wire [0:0] carryOutput;
	 wire [0:0] prop; 
	 wire [0:0] gene;
    wire [3:0] c;
	 
    lcu l(.p(p), .g(g), .carryInput(carryInput), .carryOutput(carryOutput), .prop(prop), .gene(gene), .c(c));

    initial begin
        // Monitor the changes
        $monitor("input propagates = %b, input generates = %b, carry-input = %b, carry(s) = %b, carry-output = %b, LCU propagate = %b, LCU generate = %b", p, g, carryInput, c, carryOutput, prop, gene);
        
        // Stimulus to verify the working of the look-ahead carry unit
        #5 p = 4'b1111; g = 4'b0110;
        #5 p = 4'b1101; g = 4'b0010;
        #5 p = 4'b1100; g = 4'b1001;
        #5 $finish;
    end

endmodule
