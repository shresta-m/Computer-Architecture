`include "32rdcla.v"
`include "2scomp.v"
`include "shifter.v"

module ieee_adder(a,b,out);
input [31:0] a, b;
output reg [31:0] out;

reg sign_1 , sign_2 , sign_3, S4;
reg [7:0] exp_1, exp_2 , exp_3 , diff1 , diff2;
reg [23:0] mant_1,mant_2,mant_3,mant_x,mant_y, MY1;
reg [24:0] MXY;
wire [24:0] Temp;
reg [24:0] result;
wire [23:0] Mant_shift1,Mant_shift2;
wire [24:0] Mant_fshift;
integer i;
reg cin;
wire [6:0]temp1;
wire [7:0] temp2;
wire [23:0] comp_a, temp_m;

rdcla a1({temp1,Temp}, ,{8'b0,mant_x},{8'b0,MY1},1'b0);
comp b1({8'b0,mant_y},{temp2,comp_a});
barrelshift_right shift1(mant_2,diff1[4:0],Mant_shift1);
barrelshift_right shift2(mant_1,diff2[4:0],Mant_shift2);
barrelshift_left shift3(MXY,i[4:0],Mant_fshift);

// this block is sensitive to the change of arguments present inside the block
always@(*)
begin
    // assigning 1 bit sign values of 2 numbers
    sign_1 = a[31];
    sign_2 = b[31];
    //assigning 8 bit exponent values
    exp_1[7:0] = a[30:23];
    exp_2[7:0] = b[30:23];
    // assigning 22 bit mantissa values and 23rd bit is 1 ,since repn is 1.M
    mant_1[23] = 1'b1;
    mant_2[23] = 1'b1;
    mant_1[22:0] = a[22:0];
    mant_2[22:0] = b[22:0];

    // case 1 : if 1st exp is > 2nd exp
    if(exp_1 > exp_2)
    begin
        diff1 = exp_1 - exp_2; // calculating the difference between exponents 
        if(diff1 > 32'd24)// if the difference is more than 24 , then assign diff as 24 ,since we are handling 24 bit mantissa
        begin
            diff1 = 32'd24;
        end
        mant_x = mant_1;
        mant_y = Mant_shift1;//mant_2 >> diff1; // shift the smaller mantissa by diff
        exp_3 = exp_1 + 1'b1;
        sign_3 = sign_1;
    end
    // case 2 : if 1st exp is less than 2nd exp
    else if( exp_1 < exp_2)
    begin
        diff2 = exp_2 - exp_1;
        if(diff2 > 32'd24)
        begin
            diff2 = 32'd24;
        end
        mant_x = mant_2;
        mant_y = Mant_shift2;// mant_1 >> diff2;
        exp_3 = exp_2 + 1'b1;
        sign_3 = sign_2; 
    end
    // case 3 : if both the exponents are equal
    else
    begin
        mant_x = mant_1;
        mant_y = mant_2;
        exp_3 = exp_1 + 1'b1;    
    end
    // if both the signs are equal , then just add the mantissa
    if ( sign_1 == sign_2)
    begin
        //cin = 0;
        MY1 = mant_y;
        MXY = Temp;
        sign_3 = sign_1;
    end
    // if both the signs are different , then add mant_1 and 2's complement of mant_2
    else
    begin
        //cin = 0;
        MY1 = comp_a;//(mant_y^24'hffffff);
        MXY = {1'b0,Temp[23:0]};
        //MXY = mant_x-mant_y;
        if(exp_1 == exp_2)
        begin
            if(mant_1 > mant_2)
            begin
                sign_3 = sign_1;
            end
            else
            begin
                sign_3 = sign_2;
            end
        end
    end
    		//for Normalising the result
		i = 24;
		while (i>=0 && MXY[i] == 0) begin
			exp_3-=1;
			i -= 1;
		end

		i = 24-i;
		result = Mant_fshift;//MXY << i;

        if((|exp_1 == 0) && (|mant_1[22:0] == 0))//if 1st input is zero
        begin
            out = {sign_2,exp_2,mant_2[22:0]};
        end
        
        else if((|exp_2 == 0) && (|mant_2[22:0] == 0))// if 2nd input is zero
        begin
            out = {sign_1,exp_1,mant_1[22:0]};
        end
        else if(&exp_1 == 1 || &exp_2 == 1)// infinity case
        begin
            out = 32'b0_11111111_11111111111111111111111;
        end
        else if(result[24] == 0)// zero output
        begin
            out = 32'b0;
        end
        else
        begin
            out = {sign_3,exp_3,result[23:1]};
        end
	end
endmodule



// 0 10101010   1.10101010101010101010101
// 0 10101010   1.01010101010101010101010
//+
// 0 10101011  10.11111111111111111111111

// 0 10101010   1.10101010101010101010101
// 0 10101010   1.10101010101010101010101
//+
// 0 10101011  11.01010101010101010101010

//1 10101010 11111111101010101010100,
//0 10101001 11111111111111010101110,
//+
//1 10101001 11111111010101111111010


// 2's comp and after adding 
// (1)00.11111111101010111111101
