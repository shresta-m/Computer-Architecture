`include "2scomp.v"
module top;
reg [31:0] inp;

wire [31:0] out;

comp t1(inp,out);
initial
begin
#0 inp=32'b01000000111100000000000000000000; 
//#10 inp=32'b01010101010;
//#20 inp=32'b11111111110;
//#30 A=32'd656;B=32'd100;cin=1'b0;
//#40 A=32'd3333;B=32'd6666;cin=1'b1;

end
initial $monitor($time,"inp=%5b out=%5b ",inp,out);

endmodule