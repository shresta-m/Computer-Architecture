`include "32bit_rdcla.v"
module rdcla32_tb;
    reg [31:0] a, b;
    reg cin,clk;
    wire [31:0] sum;
    wire cout;

    initial begin
		clk=0;
	end

	always 
		#1 clk=~clk;

   cla32bit adder1(a ,b, cin, sum, cout,clk);
    initial begin
		cin=1'b0;
        a = 32'd35;
        b = 32'd88;
    #100 $finish();
    end
    initial 
        $monitor($time,"A = %d, B = %d,cin= %b, Sum = %b(%d), cout = %b", a, b,cin, sum,sum, cout);
endmodule