module fullAdder (a, b, cin, sum, ca);
input a, b, cin;
output sum, ca;

reg sum, ca;

always @(a or b or cin)
begin
	sum = a ^ b ^ cin;
	ca = (a & b) | (a & cin) | (b & cin);
end
endmodule
