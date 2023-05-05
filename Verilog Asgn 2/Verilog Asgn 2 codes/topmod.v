`timescale 1ns/1ps
module topmod(clk, count, reset);
    input clk, reset;
    output [3:0] count;
    
    wire clk1;

    clockDiv cd(.clk(clk), .reset(reset), .clk1(clk1));

    upCounter up(.clk(clk1), .count(count), .reset(reset));

endmodule
