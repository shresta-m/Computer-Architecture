`include "thirtytwoBitAdder.v"

module top;
reg[31:0] a,b;
reg cin;
wire [31:0]sum;
wire cout;

thirtytwoBitAdder add(a,b,cin,sum,ca);
initial
begin
	cin=1'b0;
	#5 a=32'd10;
	#5 b=32'd20;
	#5 a=32'd300;
	#5 b=32'd750;
	#5 a=32'd1234;
	#5 b=32'd5678;
end

initial
	$monitor($time,"a=%d,b=%d,cin=%d,sum=%d,ca=%d",a,b,cin,sum,ca);
endmodule
