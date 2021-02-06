`include "32rdcla.v"
`include "2scomp.v"

module ieee_adder(a,b,out);
input [31:0] a, b;
output reg [31:0] out;

reg sign_1 , sign_2 , sign_3, S4;
reg [7:0] exp_1, exp_2 , exp_3 , diff1 , diff2;
reg [23:0] mant_1,mant_2,mant_3,mant_x,mant_y, MY1;
reg [24:0] MXY;
wire [24:0] Temp;
reg [24:0] result;
wire [23:0] Mshift1,Mshift2;
wire [24:0] MXYshift;
integer q;
reg cin;
wire [6:0]dummy;
wire [7:0] dummy1;
wire [23:0] comp_a;

rdcla a1({dummy,Temp}, ,{8'b0,mant_x},{8'b0,MY1},1'b0);
comp b1({8'b0,mant_y},{dummy1,comp_a});


always@(*)
begin
    sign_1 = a[31];
    sign_2 = b[31];
    exp_1[7:0] = a[30:23];
    exp_2[7:0] = b[30:23];
    mant_1[23] = 1'b1;
    mant_2[23] = 1'b1;
    mant_1[22:0] = a[22:0];
    mant_2[22:0] = b[22:0];

    if(exp_1 == exp_2)
    begin
        mant_x = mant_1;
        mant_y = mant_2;
        exp_3 = exp_1 + 1'b1;
    end
    else if( exp_1 > exp_2)
    begin
        diff1 = exp_1 - exp_2;
        if(diff1 > 32'd24)
        begin
            diff1 = 32'd24;
        end
        mant_x = mant_1;
        mant_y = mant_2 >> diff1;
        exp_3 = exp_1 + 1'b1;
        sign_3 = exp_1;
    end
    else
    begin
        diff2 = exp_2 - exp_1;
        if(diff2 > 32'd24)
        begin
            diff2 = 32'd24;
        end
        mant_x = mant_2;
        mant_y = mant_1 >> diff2;
        exp_3 = exp_2 + 1'b1;
        sign_3 = sign_2;
    end

    if ( sign_1 == sign_2)
    begin
        MY1 = mant_y;
        MXY = Temp;
        sign_3 = sign_1;
    end
    else
    begin
        //MY1 = comp_a;
        //MXY = Temp;
        MXY = mant_x-mant_y;
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
    		//Normalising the result
		q = 24;
		while (q>=0 && MXY[q] == 0) begin
			exp_3-=1;
			q -= 1;
		end

		q = 24-q;
		result = MXY << q;
		
		if(&exp_1 == 1 || &exp_2 == 1) begin //infinity case
			out = 32'b0_11111111_11111111111111111111111;
		end
		else if((|exp_1==0)&&(|mant_1[22:0]==0)) begin //input is zero
			out={sign_2,exp_2,mant_2[22:0]};
		end
		else if((|exp_2==0)&&(|mant_2[22:0]==0)) begin //input is zero
			out={sign_1,exp_1,mant_1[22:0]};
		end
		else if(result[24] == 0) begin //output is zero
			out = 32'b0;
		end
		else begin
			out = {sign_3, exp_3, result[23:1]};
		end
	end

endmodule
