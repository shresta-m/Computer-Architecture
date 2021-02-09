
`include "wallace.v"

module tbench;

reg [31:0] a, b;
wire [63:0]out;

wallace test (a, b, out);

initial
begin
	a = 32'd10;
	b = 32'd20;
	#5 a = 32'd259; b=32'd36;
	#10 a= 32'd351; b=32'd131;
	 
	

end

initial
begin	
	$monitor($time ," a=%d\tb=%d\tout=%d", a, b, out);
	//$dumpfile("wallace.vcd");
  //  $dumpvars;
   // #200 $finish;
end

endmodule
