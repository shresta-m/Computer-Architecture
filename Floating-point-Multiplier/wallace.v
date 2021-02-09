`include"p_prod.v"
`include"carry_save_adder.v"
`include"32bit_rdcla.v"

module wallace(a,b,out);
input [31:0]a,b;
output [63:0]out ;

wire [31:0][63:0]p_prod;
integer i;

p_products p (a , b , p_prod);

wire [63:0] xl1_1,yl1_1,xl1_2,yl1_2,xl1_3,yl1_3,xl1_4,yl1_4,xl1_5,yl1_5,xl1_6,yl1_6,xl1_7,yl1_7,xl1_8,yl1_8,xl1_9,yl1_9,xl1_10,yl1_10;

// this is first level i.e 32 --> 22
FA c1 (p_prod[0][63:0], p_prod[1][63:0], p_prod[2][63:0], xl1_1[63:0], yl1_1[63:0]);  
FA c2 (p_prod[3][63:0], p_prod[4][63:0], p_prod[5][63:0], xl1_2[63:0], yl1_2[63:0]);  
FA c3 (p_prod[6][63:0], p_prod[7][63:0], p_prod[8][63:0], xl1_3[63:0], yl1_3[63:0]);  
FA c4 (p_prod[9][63:0], p_prod[10][63:0], p_prod[11][63:0], xl1_4[63:0], yl1_4[63:0]);  
FA c5 (p_prod[12][63:0], p_prod[13][63:0], p_prod[14][63:0], xl1_5[63:0], yl1_5[63:0]);  
FA c6 (p_prod[15][63:0], p_prod[16][63:0], p_prod[17][63:0], xl1_6[63:0], yl1_6[63:0]);
FA c7 (p_prod[18][63:0], p_prod[19][63:0], p_prod[20][63:0], xl1_7[63:0], yl1_7[63:0]);
FA c8 (p_prod[21][63:0], p_prod[22][63:0], p_prod[23][63:0], xl1_8[63:0], yl1_8[63:0]);
FA c9 (p_prod[24][63:0], p_prod[25][63:0], p_prod[26][63:0], xl1_9[63:0], yl1_9[63:0]);
FA c10 (p_prod[27][63:0], p_prod[28][63:0], p_prod[29][63:0], xl1_10[63:0], yl1_10[63:0]);


//this is second level i.e 22 --> 15
wire [63:0] xl2_1,yl2_1,xl2_2,yl2_2,xl2_3,yl2_3,xl2_4,yl2_4,xl2_5,yl2_5,xl2_6,yl2_6,xl2_7,yl2_7;
FA c11(xl1_1[63:0], yl1_1[63:0], xl1_2[63:0], xl2_1[63:0], yl2_1[63:0]);
FA c12(yl1_2[63:0], xl1_3[63:0], yl1_3[63:0], xl2_2[63:0], yl2_2[63:0]);
FA c13(xl1_4[63:0], yl1_4[63:0], xl1_5[63:0], xl2_3[63:0], yl2_3[63:0]);
FA c14(yl1_5[63:0], xl1_6[63:0], yl1_6[63:0], xl2_4[63:0], yl2_4[63:0]);
FA C15(xl1_7[63:0], yl1_7[63:0], xl1_8[63:0], xl2_5[63:0], yl2_5[63:0]);
FA C16(yl1_8[63:0], xl1_9[63:0], yl1_9[63:0], xl2_6[63:0], yl2_6[63:0]);
FA C17(xl1_10[63:0], yl1_10[63:0], p_prod[30][63:0], xl2_7[63:0], yl2_7[63:0]);

// this is 3rd level i.e 15 --> 10
wire [63:0] xl3_1,yl3_1, xl3_2,yl3_2, xl3_3,yl3_3, xl3_4,yl3_4, xl3_5,yl3_5;

FA c18(xl2_1[63:0], yl2_1[63:0],xl2_2[63:0], xl3_1[63:0], yl3_1[63:0]);
FA c19(yl2_2[63:0], xl2_3[63:0],yl2_3[63:0], xl3_2[63:0], yl3_2[63:0]);
FA c20(xl2_4[63:0], yl2_4[63:0],xl2_5[63:0], xl3_3[63:0], yl3_3[63:0]);
FA c21(yl2_5[63:0], xl2_6[63:0],yl2_6[63:0], xl3_4[63:0], yl3_4[63:0]);
FA c22(xl2_7[63:0], yl2_7[63:0],p_prod[31][63:0], xl3_5[63:0], yl3_5[63:0]);

//this is 4th level i.e 10 --> 7
wire [63:0] xl4_1,yl4_1,xl4_2,yl4_2,xl4_3,yl4_3;
FA c23(xl3_1[63:0], yl3_1[63:0], xl3_2[63:0],xl4_1[63:0],yl4_1[63:0]);
FA c24(yl3_2[63:0], xl3_3[63:0], yl3_3[63:0],xl4_2[63:0],yl4_2[63:0]);
FA c25(xl3_4[63:0], yl3_4[63:0], xl3_5[63:0],xl4_3[63:0],yl4_3[63:0]);

//this is 5th level i.e 7 -->5
wire [63:0] xl5_1,yl5_1,xl5_2,yl5_2;
FA c26(xl4_1[63:0], yl4_1[63:0], xl4_2[63:0], xl5_1[63:0], yl5_1[63:0]);
FA c27(yl4_2[63:0], xl4_3[63:0], yl4_3[63:0], xl5_2[63:0], yl5_2[63:0]);

//this is 6th level i.e 5 -->4
wire [63:0] xl6_1,yl6_1,xl6_2,yl6_2;
FA c28(xl5_1[63:0], yl5_1[63:0], xl5_2[63:0], xl6_1[63:0], yl6_1[63:0]);
//FA c29(yl5_2[63:0], xl3_5[63:0], left yl3_5[63:0], xl6_2[63:0], yl6_2[63:0]);



// This is 7th level i.e 4 --> 3
wire [63:0] xl7_1, yl7_1;

FA c30 (xl6_1[63:0], yl6_1[63:0], yl5_2[63:0], xl7_1[63:0], yl7_1[63:0]);

// This is 8th level i.e 3--> 2
wire [63:0] xl8_1, yl8_1;

FA c31 (xl7_1[63:0], yl7_1[63:0], yl3_5[63:0], xl8_1[63:0], yl8_1[63:0]);

// The 9th level  ,where the final sum and carry is added by recursive doubling adder
wire c;
cla32bit c32 (xl8_1[31:0], yl8_1[31:0], 1'b0, out[31:0], c );
cla32bit c33 (xl8_1[63:32], yl8_1[63:32], c,out[63:32], );

//cla32bit(a ,b, cin, sum, cout);

endmodule 





