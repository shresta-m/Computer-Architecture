module cla32bit(a ,b, cin, sum, cout);
input [31:0] a, b;
input cin;
output reg [31:0] sum;
output reg cout;

wire [32:0] ca_0,ca_1;// carry0 and carry1

wire [32:0] ca0_1, ca1_1, ca0_2, ca1_2, ca0_4, ca1_4, ca0_8, ca1_8, ca0_16, ca1_16;

integer i,j;

assign ca_0[0] = cin;
assign ca_1[0] = cin;

always@(*)
begin
	sum = a ^ b;//xor_sum
	sum = sum[31:0] ^ ca0_16[31:0];
	cout = ca0_16[32];
end

kpg_initial init [32:1] ( a[31:0],b[31:0], ca_1[32:1], ca_0[32:1]);


assign ca1_1[0] = cin;
assign ca0_1[0] = cin;
assign ca1_2[1:0] = ca1_1[1:0];
assign ca0_2[1:0] = ca0_1[1:0];
assign ca1_4[3:0] = ca1_2[3:0];
assign ca0_4[3:0] = ca0_2[3:0];
assign ca1_8[7:0] = ca1_4[7:0];
assign ca0_8[7:0] = ca0_4[7:0];
assign ca1_16[15:0] = ca1_8[15:0];
assign ca0_16[15:0] = ca0_8[15:0];

kpg step_1 [32:1] (ca_1[32:1], ca_0[32:1], ca_1[31:0], ca_0[31:0],ca1_1[32:1],ca0_1[32:1]);
kpg step_2 [32:2] (ca1_1[32:2], ca0_1[32:2], ca1_1[30:0], ca0_1[30:0] , ca1_2[32:2], ca0_2[32:2]);
kpg step_4 [32:4] (ca1_2[32:4], ca0_2[32:4], ca1_2[28:0], ca0_2[28:0] , ca1_4[32:4], ca0_4[32:4]);
kpg step_8 [32:8] (ca1_4[32:8], ca0_4[32:8], ca1_4[24:0], ca0_4[24:0], ca1_8[32:8], ca0_8[32:8]);
kpg step_16 [32:16] (ca1_8[32:16], ca0_8[32:16] , ca1_8[16:0], ca0_8[16:0], ca1_16[32:16], ca0_16[32:16]);

endmodule


module kpg_initial(input a,b, output reg out1,out0);
always@(*)
	case({a,b})
		2'b00: begin
			out0 = 1'b0; out1 = 1'b0;
		end
		2'b11: begin
			out0 = 1'b1; out1 = 1'b1;
		end
		default: begin
			out0 = 1'b0 ; out1 = 1'b1;
		end
	endcase
	endmodule

	module kpg (input currbit_1, currbit_0, prevbit_1, prevbit_0, output reg outbit_1,outbit_0);
	always@(*)
	begin
		if({currbit_1, currbit_0} == 2'b00)
			{outbit_1,outbit_0} = 2'b00;
		if({currbit_1, currbit_0} == 2'b11)
			{outbit_1, outbit_0} = 2'b11;
		if({currbit_1, currbit_0}== 2'b10)
			{outbit_1,outbit_0} = {prevbit_1, prevbit_0};
	end
	endmodule


