`timescale 1ns/1ps

module clockDiv(clk, reset, clk1);
    input clk, reset;
    output reg clk1;

    integer c;

    always@(negedge clk)
        begin
            if(!reset)
                c=0;
            c = c+1;
            if(c==100000)
            begin  
                clk1 = ~clk1;
                c=0;
            end
        end

endmodule