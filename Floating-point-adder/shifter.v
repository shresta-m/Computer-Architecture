module mux (a,b,s,result);
input a , b , s;
output result;
assign result = (s == 0)?b:a;
endmodule

module barrelshift_left (a,sm,out);
input [24:0] a; // 25 bit input value
input [4:0] sm;// shift magnitude value
output [24:0] out; // output value

wire l1_1,l1_2,l1_3,l1_4,l1_5,l1_6,l1_7,l1_8,l1_9,l1_10,l1_11,l1_12,l1_13,l1_14,l1_15,l1_16,l1_17,l1_18,l1_19,l1_20,l1_21,l1_22,l1_23,l1_24,l1_25;
wire l2_1,l2_2,l2_3,l2_4,l2_5,l2_6,l2_7,l2_8,l2_9,l2_10,l2_11,l2_12,l2_13,l2_14,l2_15,l2_16,l2_17,l2_18,l2_19,l2_20,l2_21,l2_22,l2_23,l2_24,l2_25;
wire l3_1,l3_2,l3_3,l3_4,l3_5,l3_6,l3_7,l3_8,l3_9,l3_10,l3_11,l3_12,l3_13,l3_14,l3_15,l3_16,l3_17,l3_18,l3_19,l3_20,l3_21,l3_22,l3_23,l3_24,l3_25;
wire l4_1,l4_2,l4_3,l4_4,l4_5,l4_6,l4_7,l4_8,l4_9,l4_10,l4_11,l4_12,l4_13,l4_14,l4_15,l4_16,l4_17,l4_18,l4_19,l4_20,l4_21,l4_22,l4_23,l4_24,l4_25;

mux s1(1'b0,a[0],sm[0],l1_1);
mux s2(a[0],a[1],sm[0],l1_2);
mux s3(a[1],a[2],sm[0],l1_3);
mux s4(a[2],a[3],sm[0],l1_4);
mux s5(a[3],a[4],sm[0],l1_5);
mux s6(a[4],a[5],sm[0],l1_6);
mux s7(a[5],a[6],sm[0],l1_7);
mux s8(a[6],a[7],sm[0],l1_8);
mux s9(a[7],a[8],sm[0],l1_9);
mux s10(a[8],a[9],sm[0],l1_10);
mux s11(a[9],a[10],sm[0],l1_11);
mux s12(a[10],a[11],sm[0],l1_12);
mux s13(a[11],a[12],sm[0],l1_13);
mux s14(a[12],a[13],sm[0],l1_14);
mux s15(a[13],a[14],sm[0],l1_15);
mux s16(a[14],a[15],sm[0],l1_16);
mux s17(a[15],a[16],sm[0],l1_17);
mux s18(a[16],a[17],sm[0],l1_18);
mux s19(a[17],a[18],sm[0],l1_19);
mux s20(a[18],a[19],sm[0],l1_20);
mux s21(a[19],a[20],sm[0],l1_21);
mux s22(a[20],a[21],sm[0],l1_22);
mux s23(a[21],a[22],sm[0],l1_23);
mux s24(a[22],a[23],sm[0],l1_24);
mux s25(a[23],a[24],sm[0],l1_25);

mux b1(1'b0,l1_1,sm[1],l2_1);
mux b2(1'b0,l1_2,sm[1],l2_2);
mux b3(l1_1,l1_3,sm[1],l2_3);
mux b4(l1_2,l1_4,sm[1],l2_4);
mux b5(l1_3,l1_5,sm[1],l2_5);
mux b6(l1_4,l1_6,sm[1],l2_6);
mux b7(l1_5,l1_7,sm[1],l2_7);
mux b8(l1_6,l1_8,sm[1],l2_8);
mux b9(l1_7,l1_9,sm[1],l2_9);
mux b10(l1_8,l1_10,sm[1],l2_10);
mux b11(l1_9,l1_11,sm[1],l2_11);
mux b12(l1_10,l1_12,sm[1],l2_12);
mux b13(l1_11,l1_13,sm[1],l2_13);
mux b14(l1_12,l1_14,sm[1],l2_14);
mux b15(l1_13,l1_15,sm[1],l2_15);
mux b16(l1_14,l1_16,sm[1],l2_16);
mux b17(l1_15,l1_17,sm[1],l2_17);
mux b18(l1_16,l1_18,sm[1],l2_18);
mux b19(l1_17,l1_19,sm[1],l2_19);
mux b20(l1_18,l1_20,sm[1],l2_20);
mux b21(l1_19,l1_21,sm[1],l2_21);
mux b22(l1_20,l1_22,sm[1],l2_22);
mux b23(l1_21,l1_23,sm[1],l2_23);
mux b24(l1_22,l1_24,sm[1],l2_24);
mux b25(l1_23,l1_25,sm[1],l2_25);


mux c1(1'b0,l2_1,sm[2],l3_1);
mux c2(1'b0,l2_2,sm[2],l3_2);
mux c3(1'b0,l2_3,sm[2],l3_3);
mux c4(1'b0,l2_4,sm[2],l3_4);
mux c5(l2_1,l2_5,sm[2],l3_5);
mux c6(l2_2,l2_6,sm[2],l3_6);
mux c7(l2_3,l2_7,sm[2],l3_7);
mux c8(l2_4,l2_8,sm[2],l3_8);
mux c9(l2_5,l2_9,sm[2],l3_9);
mux c10(l2_6,l2_10,sm[2],l3_10);
mux c11(l2_7,l2_11,sm[2],l3_11);
mux c12(l2_8,l2_12,sm[2],l3_12);
mux c13(l2_9,l2_13,sm[2],l3_13);
mux c14(l2_10,l2_14,sm[2],l3_14);
mux c15(l2_11,l2_15,sm[2],l3_15);
mux c16(l2_12,l2_16,sm[2],l3_16);
mux c17(l2_13,l2_17,sm[2],l3_17);
mux c18(l2_14,l2_18,sm[2],l3_18);
mux c19(l2_15,l2_19,sm[2],l3_19);
mux c20(l2_16,l2_20,sm[2],l3_20);
mux c21(l2_17,l2_21,sm[2],l3_21);
mux c22(l2_18,l2_22,sm[2],l3_22);
mux c23(l2_19,l2_23,sm[2],l3_23);
mux c24(l2_20,l2_24,sm[2],l3_24);
mux c25(l2_21,l2_25,sm[2],l3_25);

mux d1(1'b0,l3_1,sm[3],l4_1);
mux d2(1'b0,l3_2,sm[3],l4_2);
mux d3(1'b0,l3_3,sm[3],l4_3);
mux d4(1'b0,l3_4,sm[3],l4_4);
mux d5(1'b0,l3_5,sm[3],l4_5);
mux d6(1'b0,l3_6,sm[3],l4_6);
mux d7(1'b0,l3_7,sm[3],l4_7);
mux d8(1'b0,l3_8,sm[3],l4_8);
mux d9(l3_1,l3_9,sm[3],l4_9);
mux d10(l3_2,l3_10,sm[3],l4_10);
mux d11(l3_3,l3_11,sm[3],l4_11);
mux d12(l3_4,l3_12,sm[3],l4_12);
mux d13(l3_5,l3_13,sm[3],l4_13);
mux d14(l3_6,l3_14,sm[3],l4_14);
mux d15(l3_7,l3_15,sm[3],l4_15);
mux d16(l3_8,l3_16,sm[3],l4_16);
mux d17(l3_9,l3_17,sm[3],l4_17);
mux d18(l3_10,l3_18,sm[3],l4_18);
mux d19(l3_11,l3_19,sm[3],l4_19);
mux d20(l3_12,l3_20,sm[3],l4_20);
mux d21(l3_13,l3_21,sm[3],l4_21);
mux d22(l3_14,l3_22,sm[3],l4_22);
mux d23(l3_15,l3_23,sm[3],l4_23);
mux d24(l3_16,l3_24,sm[3],l4_24);
mux d25(l3_17,l3_25,sm[3],l4_25);

mux f1(1'b0,l4_1,sm[4],out[0]);
mux f2(1'b0,l4_2,sm[4],out[1]);
mux f3(1'b0,l4_3,sm[4],out[2]);
mux f4(1'b0,l4_4,sm[4],out[3]);
mux f5(1'b0,l4_5,sm[4],out[4]);
mux f6(1'b0,l4_6,sm[4],out[5]);
mux f7(1'b0,l4_7,sm[4],out[6]);
mux f8(1'b0,l4_8,sm[4],out[7]);
mux f9(1'b0,l4_9,sm[4],out[8]);
mux f10(1'b0,l4_10,sm[4],out[9]);
mux f11(1'b0,l4_11,sm[4],out[10]);
mux f12(1'b0,l4_12,sm[4],out[11]);
mux f13(1'b0,l4_13,sm[4],out[12]);
mux f14(1'b0,l4_14,sm[4],out[13]);
mux f15(1'b0,l4_15,sm[4],out[14]);
mux f16(1'b0,l4_16,sm[4],out[15]);
mux f17(l3_1,l3_17,sm[4],out[16]);
mux f18(l3_2,l3_18,sm[4],out[17]);
mux f19(l3_3,l3_19,sm[4],out[18]);
mux f20(l3_4,l3_20,sm[4],out[19]);
mux f21(l3_5,l3_21,sm[4],out[20]);
mux f22(l3_6,l3_22,sm[4],out[21]);
mux f23(l3_7,l3_23,sm[4],out[22]);
mux f24(l3_8,l3_24,sm[4],out[23]);
mux f25(l3_9,l3_25,sm[4],out[24]);


endmodule

module barrelshift_right(a,sm,out);   

input[23:0] a;//24-bit Input line 
input[4:0] sm; //5 bit Shift magnitude
output[23:0] out; //8-bit Output line 

wire l1_1, l1_2, l1_3, l1_4, l1_5, l1_6, l1_7, l1_8, l1_9, l1_10, l1_11, l1_12, l1_13, l1_14, l1_15, l1_16, l1_17, l1_18, l1_19, l1_20, l1_21, l1_22, l1_23, l1_24;
wire l2_1, l2_2, l2_3, l2_4, l2_5, l2_6, l2_7, l2_8, l2_9, l2_10, l2_11, l2_12, l2_13, l2_14, l2_15, l2_16, l2_17, l2_18, l2_19, l2_20, l2_21, l2_22, l2_23, l2_24;
wire l3_1, l3_2, l3_3, l3_4, l3_5, l3_6, l3_7, l3_8, l3_9, l3_10, l3_11, l3_12, l3_13, l3_14, l3_15, l3_16, l3_17, l3_18, l3_19, l3_20, l3_21, l3_22, l3_23, l3_24;
wire l4_1, l4_2, l4_3, l4_4, l4_5, l4_6, l4_7, l4_8, l4_9, l4_10, l4_11, l4_12, l4_13, l4_14, l4_15, l4_16, l4_17, l4_18, l4_19, l4_20, l4_21, l4_22, l4_23, l4_24;


mux m1(a[1], a[0], sm[0], l1_1);
mux m2(a[2], a[1], sm[0], l1_2);
mux m3(a[3], a[2], sm[0], l1_3);
mux m4(a[4], a[3], sm[0], l1_4);
mux m5(a[5], a[4], sm[0], l1_5);
mux m6(a[6], a[5], sm[0], l1_6);
mux m7(a[7], a[6], sm[0], l1_7);
mux m8(a[8], a[7], sm[0], l1_8);
mux m9(a[9], a[8], sm[0], l1_9);
mux m10(a[10], a[9], sm[0], l1_10);
mux m11(a[11], a[10], sm[0], l1_11);
mux m12(a[12], a[11], sm[0], l1_12);
mux m13(a[13], a[12], sm[0], l1_13);
mux m14(a[14], a[13], sm[0], l1_14);
mux m15(a[15], a[14], sm[0], l1_15);
mux m16(a[16], a[15], sm[0], l1_16);
mux m17(a[17], a[16], sm[0], l1_17);
mux m18(a[18], a[17], sm[0], l1_18);
mux m19(a[19], a[18], sm[0], l1_19);
mux m20(a[20], a[19], sm[0], l1_20);
mux m21(a[21], a[20], sm[0], l1_21);
mux m22(a[22], a[21], sm[0], l1_22);
mux m23(a[23], a[22], sm[0], l1_23);
mux m24(1'b0, a[23], sm[0], l1_24);

mux u1(l1_3, l1_1, sm[1], l2_1);
mux u2(l1_4, l1_2, sm[1], l2_2);
mux u3(l1_5, l1_3, sm[1], l2_3);
mux u4(l1_6, l1_4, sm[1], l2_4);
mux u5(l1_7, l1_5, sm[1], l2_5);
mux u6(l1_8, l1_6, sm[1], l2_6);
mux u7(l1_9, l1_7, sm[1], l2_7);
mux u8(l1_10, l1_8, sm[1], l2_8);
mux u9(l1_11, l1_9, sm[1], l2_9);
mux u10(l1_12, l1_10, sm[1], l2_10);
mux u11(l1_13, l1_11, sm[1], l2_11);
mux u12(l1_14, l1_12, sm[1], l2_12);
mux u13(l1_15, l1_13, sm[1], l2_13);
mux u14(l1_16, l1_14, sm[1], l2_14);
mux u15(l1_17, l1_15, sm[1], l2_15);
mux u16(l1_18, l1_16, sm[1], l2_16);
mux u17(l1_19, l1_17, sm[1], l2_17);
mux u18(l1_20, l1_18, sm[1], l2_18);
mux u19(l1_21, l1_19, sm[1], l2_19);
mux u20(l1_22, l1_20, sm[1], l2_20);
mux u21(l1_23, l1_21, sm[1], l2_21);
mux u22(l1_24, l1_22, sm[1], l2_22);
mux u23(1'b0, l1_23, sm[1], l2_23);
mux u24(1'b0, l1_24, sm[1], l2_24);

mux v1(l2_5, l2_1, sm[2], l3_1);
mux v2(l2_6, l2_2, sm[2], l3_2);
mux v3(l2_7, l2_3, sm[2], l3_3);
mux v4(l2_8, l2_4, sm[2], l3_4);
mux v5(l2_9, l2_5, sm[2], l3_5);
mux v6(l2_10, l2_6, sm[2], l3_6);
mux v7(l2_11, l2_7, sm[2], l3_7);
mux v8(l2_12, l2_8, sm[2], l3_8);
mux v9(l2_13, l2_9, sm[2], l3_9);
mux v10(l2_14, l2_10, sm[2], l3_10);
mux v11(l2_15, l2_11, sm[2], l3_11);
mux v12(l2_16, l2_12, sm[2], l3_12);
mux v13(l2_17, l2_13, sm[2], l3_13);
mux v14(l2_18, l2_14, sm[2], l3_14);
mux v15(l2_19, l2_15, sm[2], l3_15);
mux v16(l2_20, l2_16, sm[2], l3_16);
mux v17(l2_21, l2_17, sm[2], l3_17);
mux v18(l2_22, l2_18, sm[2], l3_18);
mux v19(l2_23, l2_19, sm[2], l3_19);
mux v20(l2_24, l2_20, sm[2], l3_20);
mux v21(1'b0, l2_21, sm[2], l3_21);
mux v22(1'b0, l2_22, sm[2], l3_22);
mux v23(1'b0, l2_23, sm[2], l3_23);
mux v24(1'b0, l2_24, sm[2], l3_24);

mux x1(l3_9, l3_1, sm[3], l4_1);
mux x2(l3_10, l3_2, sm[3], l4_2);
mux x3(l3_11, l3_3, sm[3], l4_3);
mux x4(l3_12, l3_4, sm[3], l4_4);
mux x5(l3_13, l3_5, sm[3], l4_5);
mux x6(l3_14, l3_6, sm[3], l4_6);
mux x7(l3_15, l3_7, sm[3], l4_7);
mux x8(l3_16, l3_8, sm[3], l4_8);
mux x9(l3_17, l3_9, sm[3], l4_9);
mux x10(l3_18, l3_10, sm[3], l4_10);
mux x11(l3_19, l3_11, sm[3], l4_11);
mux x12(l3_20, l3_12, sm[3], l4_12);
mux x13(l3_21, l3_13, sm[3], l4_13);
mux x14(l3_22, l3_14, sm[3], l4_14);
mux x15(l3_23, l3_15, sm[3], l4_15);
mux x16(l3_24, l3_16, sm[3], l4_16);
mux x17(1'b0, l3_17, sm[3], l4_17);
mux x18(1'b0, l3_18, sm[3], l4_18);
mux x19(1'b0, l3_19, sm[3], l4_19);
mux x20(1'b0, l3_20, sm[3], l4_20);
mux x21(1'b0, l3_21, sm[3], l4_21);
mux x22(1'b0, l3_22, sm[3], l4_22);
mux x23(1'b0, l3_23, sm[3], l4_23);
mux x24(1'b0, l3_24, sm[3], l4_24);

mux f1(l4_17,l4_1,sm[4],out[0]);
mux f2(l4_18,l4_2,sm[4],out[1]);
mux f3(l4_19,l4_3,sm[4],out[2]);
mux f4(l4_20,l4_4,sm[4],out[3]);
mux f5(l4_21,l4_5,sm[4],out[4]);
mux f6(l4_22,l4_6,sm[4],out[5]);
mux f7(l4_23,l4_7,sm[4],out[6]);
mux f8(l4_24,l4_8,sm[4],out[7]);
mux f9(1'b0,l4_9,sm[4],out[8]);
mux f10(1'b0,l4_10,sm[4],out[9]);
mux f11(1'b0,l4_11,sm[4],out[10]);
mux f12(1'b0,l4_12,sm[4],out[11]);
mux f13(1'b0,l4_13,sm[4],out[12]);
mux f14(1'b0,l4_14,sm[4],out[13]);
mux f15(1'b0,l4_15,sm[4],out[14]);
mux f16(1'b0,l4_16,sm[4],out[15]);
mux f17(1'b0,l4_17,sm[4],out[16]);
mux f18(1'b0,l4_18,sm[4],out[17]);
mux f19(1'b0,l4_19,sm[4],out[18]);
mux f20(1'b0,l4_20,sm[4],out[19]);
mux f21(1'b0,l4_21,sm[4],out[20]);
mux f22(1'b0,l4_22,sm[4],out[21]);
mux f23(1'b0,l4_23,sm[4],out[22]);
mux f24(1'b0,l4_24,sm[4],out[23]);

endmodule