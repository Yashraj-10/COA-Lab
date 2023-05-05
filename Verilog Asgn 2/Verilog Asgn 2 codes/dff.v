module dff(clk, reset, d, q);
    input clk, reset;
    input [3:0] d;
    output reg [3:0] q ;
    
    always@(posedge clk or negedge reset)
        begin
            if(!reset)
                q = 4'b0000;
            else    
                q = d;
        end
endmodule