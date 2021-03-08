`include "wallace.v"
module wallace_tb;
    reg [31:0] a, b;
    reg clk;
    wire [63:0] out;
    //wire cout;

    initial begin
		clk=0;
	end

	always 
		#1 clk=~clk;

    wallace wallace0( a, b, out,clk);
    initial begin
		//cin=1'b0;
        a = 32'd40;
        b = 32'd95;
    #17 $finish();
    end
		always@( clk)
        $display($time," A = %d, B = %d, Product = %b(%d)", a, b, out,out);

    // initial 
    //     $monitor($time," A = %d, B = %d, Product = %b", a, b, out);
endmodule