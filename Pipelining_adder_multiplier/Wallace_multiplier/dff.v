module DFF(clk,d,reset,q);
input d;
input clk,reset;
output reg q;
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    q <= 1'b0;
    else
    q <= d;
end
endmodule