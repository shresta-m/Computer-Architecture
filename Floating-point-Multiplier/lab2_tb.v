`include "lab2.v"

module top;

reg [31:0]a, b;
wire [31:0]out;

ieee_mult FP1 (a, b, out);
//00011100011100011100010
initial
begin
	a = 32'b01010101010101010101010101010101; b = 32'b01010101001010101010101010101010;
	#5 a= 32'b01010101010101010101010101010101;b=32'b01010101010101010101010101010101;
	#10 a = 32'b11010101011111111101010101010100 ; b= 32'b01010100111111111111111010101110 ;
	#15 a =32'b01000010111110111000000000000000; b= 32'b01000101101010011100011011110110;//125.75 ,5432.87
	// answer = 0  10010010  01001101100101011110110 -683183.4025
	#20 a=32'b01000100011000001001110011001101; b = 32'b11000101100011110000011111101100; //898.45,-4576.99

	// answer =  1	10010100	11110101111110100010011 - -4112196.6655
	
end
initial 
begin
	$monitor($time,"\na =      %b %b %b,\nb =      %b %b %b,\noutput = %b %b %b ",a[31],a[30:23],a[22:0],b[31],b[30:23],b[22:0],out[31],out[30:23],out[22:0]);
	// $dumpfile("32bit_fadder.vcd");
    //     	$dumpvars;
end
endmodule
