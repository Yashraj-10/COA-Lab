`timescale 1ns/1ps

module upCounter(clk, count, reset);
    input clk, reset;
    output [3:0] count;
    wire[3:0] count;
    wire [3:0] toStore;
    wire carryOutput;
    
    dff instance1(.clk(clk), .reset(reset), .d(toStore), .q(count));

    // RCA4 rca(.a(count), .b(4'b0000), .carryInput(1'b1), .sum(toStore), .carryOutput(carryOutput));
    RCA4opti rca(.a(count), .sum(toStore), .carryOutput(carryOutput));

endmodule

// module test();

//     reg clk = 0, reset = 0;
//     wire[3:0] out;
    
//     upCounter c(.clk(clk), .count(out), .reset(reset));

//     always begin
//         clk = ~clk;
//         #10;
//     end

//     initial begin
//         $monitor("count = %b%b%b%b", out[3],out[2],out[1],out[0]);
//         reset = 0;
//         #5;
//         reset = 1;
//         #200
        
//         $finish;
//     end

// endmodule