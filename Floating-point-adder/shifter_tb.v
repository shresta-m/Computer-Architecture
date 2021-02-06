`include "shifter.v"

module top;

reg [24:0] a;
reg [4:0] sm;
wire [24:0] out;

barrelshift_left shift(a,sm,out);
//barrelshift_right shift1(a,sm,out);

initial
begin
	a = 25'b0101111111101010111111101;sm = 5'b00010;
end
initial 
begin
	$monitor($time,"\na = %b,out = %b",a,out);
	// $dumpfile("32bit_fadder.vcd");
    //     	$dumpvars;
end
endmodule

// # for a in range(1,9):
// #     #print("mux d%d(1'b0,l4_%d,sm[4],out[%d]);"%(a,a,a))
// #     print("mux f%d(l4_%d,l4_%d,sm[4],out[%d]);"%(a,a+16,a,a-1))

