`include "split.v"
`include "wallace.v"
`include "rdcla.v"
module ieee_mult(a,b,out);
input [31:0] a, b;
output [31:0] out;

wire w_sign1,w_sign2,w_sign3,w_shift ,NaN,zero;
wire [7:0] w_exp1,w_exp2,w_expr;
wire [7:0] w_expx,w_expy;
wire [22:0] w_mant1,w_mant2, w_mantr;
wire [63:0] w_wall_out;
wire [47:0] w_prod;

split a1(a,w_sign1,w_exp1,w_mant1);
split b1(b,w_sign2,w_exp2,w_mant2);

xor(w_sign3,w_sign1,w_sign2);
wallace mul({9'b000000001,w_mant1},{9'b000000001,w_mant2},w_wall_out);
assign w_prod = w_wall_out[47:0];
assign w_shift = w_wall_out[47];

rdcla_8bit exp1(w_expx,w_shift,w_exp1,w_exp2);
rdcla_8bit exp2(w_expy,1'b0,w_expx,8'b10000001);

assign NaN=(&w_exp1 | &w_exp2);
assign zero=~(|w_exp1 & |w_exp2);

select_output final(w_sign3,w_expy,w_prod[46:23],NaN,zero,w_shift,out);
endmodule

module mux(
	input i0,i1,s,
	output o
);

	assign o = (i0 & ~s) | (i1 & s);

endmodule

module select_output(sign,exp_f,mant_temp,nan,zero,shift,fproduct);

	input sign,nan,zero,shift;
	input [7:0]exp_f;
	input [23:0]mant_temp;
	output [31:0]fproduct;

	wire [22:0]mant_temp_normalised;
	wire [7:0]nan_or_zero_exp;
	wire nan_or_zero;

	assign nan_or_zero=nan|zero;
	mux check_nan_or_zero_sign(sign,1'b0,nan_or_zero,fproduct[31]);

	genvar i;
	generate
		for(i=22;i>=0;i=i-1)
		begin
			mux normalise(mant_temp[i],mant_temp[i+1],shift,mant_temp_normalised[i]);
			mux check_nan_or_zero_mant_temp(mant_temp_normalised[i],1'b0,nan_or_zero,fproduct[i]);
		end
		for(i=30;i>=23;i=i-1)
		begin
			mux find_nan_or_zero_exp(1'b1,1'b0,zero,nan_or_zero_exp[i-23]);
			mux check_nan_or_zero_exp(exp_f[i-23],nan_or_zero_exp[i-23],nan_or_zero,fproduct[i]);
		end
	endgenerate

endmodule

