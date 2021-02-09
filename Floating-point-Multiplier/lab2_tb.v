`include "ieee_mult.v"

module top;

	reg [31:0]a, b;
	wire [31:0]out;

	ieee_mult FP1 (a, b, out);

	initial
	begin

		a=32'b0_10000011_10011111101011100001010;	// 25.98
		b=32'b0_10000101_00111110010000011000101;	// 79.564
		// 0_10001010_00000010011000100101010
		#5 $display("\na =      %b %b %b,\nb =      %b %b %b,\noutput = %b %b %b",a[31],a[30:23],a[22:0],b[31],b[30:23],b[22:0],out[31],out[30:23],out[22:0]);


	end

endmodule