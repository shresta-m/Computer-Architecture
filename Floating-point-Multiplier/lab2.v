`include "split.v"
`include "wallace.v"
`include "rdcla.v"
module ieee_mult(a,b,out);
input [31:0] a, b;
output [31:0] out;

wire w_sign1,w_sign2,w_sign3,w_shift;
wire [7:0] w_exp1,w_exp2,w_expr;
wire [7:0] w_expx,w_expy;
wire [22:0] w_mant1,w_mant2, w_mantr;
wire [63:0] w_wall_out;
wire [47:0] w_prod, w_prod1;
wire w_zero_a,w_zero_b , w_inf_a,w_inf_b,w_zero,w_inf;

// splitting the 2 numbers as sign ,exponent and mantissa part
split a1(a,w_sign1,w_exp1,w_mant1);
split b1(b,w_sign2,w_exp2,w_mant2);

//calculating the resultant sign by xoring the both signs
xor(w_sign3,w_sign1,w_sign2);

//multiplying the mantissa values using wallace multiplier
wallace mul({9'b000000001,w_mant1},{9'b000000001,w_mant2},w_wall_out);
// assigning the product
assign w_prod = w_wall_out[47:0];
assign w_shift = w_wall_out[47];// based on the 47th bit value, the mantissa part needs to shifted so consider that as shift

// basically the product mantissa is of type xx.xxxxx...(23)
// if the 47th bit is 1, then shift 1 
// if not ,anyway 46th bit will be 1 , so no shift(shift =0)

// E3=E1+E2-bias +1
// this is done using recursive doubling adder
rdcla_8bit exp1(w_expx,w_shift,w_exp1,w_exp2);// E1+E2+shift
rdcla_8bit exp2(w_expy,1'b0,w_expx,8'b10000001);// here 2's complement of 127 is taken +1

assign w_prod1 = w_prod >> w_shift; // shifting the mantissa acc to the shift value (0 or 1)

// checking each nos ,if they are zero
nor a_1(w_zero_a,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30]);
nor b_1(w_zero_b,b[0],b[1],b[2],b[3],b[4],b[5],b[6],b[7],b[8],b[9],b[10],b[11],b[12],b[13],b[14],b[15],b[16],b[17],b[18],b[19],b[20],b[21],b[22],b[23],b[24],b[25],b[26],b[27],b[28],b[29],b[30]);

// checking each nos , if they are infinity
and a_inf(w_inf_a,a[30],a[29],a[28],a[27],a[26],a[25],a[24],a[23]);
and b_inf(w_inf_b,b[30],b[29],b[28],b[27],b[26],b[25],b[24],b[23]);

or check(w_zero,w_zero_a,w_zero_b);
or check1(w_inf,w_inf_a,w_inf_b);

assign w_mantr = w_prod1[45:23];
assign out[31] = w_sign3;
final_output mux1(w_mantr,w_expy,w_zero,w_inf,out[30:0]);

endmodule

module mux(i0,i1,i2,i3,s1,s0,ans);
input i0,i1,i2,i3,s0,s1;
output ans;
wire w_x1,w_x2,w_x3,w_x4;

and y1(w_x1,i0,~s0,~s1);
and y2(w_x2,i1,s0,~s1);
and y3(w_x3,i2,~s0,s1);
and y4(w_x4,i3,s0,s1);

or y5(ans,w_x1,w_x2,w_x3,w_x4);

endmodule

module final_output(mant,exp,zero,inf,result);
input [22:0] mant;
input [7:0] exp;
input zero,inf;
output [30:0] result;

wire [30:0] w_final;
assign w_final[22:0] = mant;
assign w_final[30:23] = exp;

wire [30:0] w_inf_out,w_zero_out,w_nan;
assign w_inf_out =  31'b1111111100000000000000000000000;
assign w_zero_out = 31'b0000000000000000000000000000000;
assign w_nan =      31'b1111111100000000000000000000001;
 
// zero,inf are select lines
//  0    0  - final product is selected as o/p
//  0    1  - infinity value is selected as o/p
//  1    0  - zero value is selected as o/p
//  1    1  - not a number is selected as o/p
genvar i;
generate
	for(i=0;i<=30;i=i+1)
	begin
		mux select_ans(w_final[i],w_inf_out[i],w_zero_out[i],w_nan[i],zero,inf,result[i]);
	end
	endgenerate

endmodule

