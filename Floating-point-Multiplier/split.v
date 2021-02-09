module split(a,s,e,m);
input [31:0] a;
output s;
output [7:0] e;
output [22:0] m;

assign s = a[31];
assign e = a[30:23];
assign m = a[22:0];

endmodule