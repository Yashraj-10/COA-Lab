`timescale 1ns/1ps

module UpCounter(clk,reset,q);
    input clk, reset;
    output reg [3:0] q;

    // reg[3:0] cnt;

    always @ (posedge clk or negedge reset)
        begin   
            if(!reset)
                q<=1'b0;
            else if(q==4'd15)
                q<=1'b0;
            else 
                q = q+1;
        end

endmodule

module test();
    reg CLK = 0, reset = 0;
    wire[3:0] out;
    UpCounter c(CLK, reset, out);

    always begin
        CLK = ~CLK;
        #10;
    end

    initial begin
        $monitor("count = %b%b%b%b", out[3],out[2],out[1],out[0]);
        reset = 0;
        #5
        reset = 1;
        #200;

        $finish;
    end
endmodule