module p_products(input [31:0]a,input [31:0]b,output reg [31:0][63:0]p_prod);

integer i;

always@(a or b)
begin
	for(i=0;i<32;i=i+1)begin
		p_prod = 64'h00000000;
		if(b[i] == 1)begin
			p_prod[i] <= a <<i;
			
		end
		else
			p_prod[i] = 64'h00000000;
	end
end
endmodule


