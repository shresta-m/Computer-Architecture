`include "direct_map.v"
module top;

reg [16:0]read_addr,write_addr;
reg [31:0]write_data;
reg clk,read_en,write_en;
wire [31:0]read_data;
wire hit;

cache l1(read_addr,write_addr,write_data,clk,read_en,write_en,hit ,read_data);

initial begin
  clk=0;
     forever #5 clk = ~clk;  
end 
initial 
begin
read_en=1'b1;
write_en=1'b0;
read_addr=17'b00000000000000001;
#10;
read_en=1'b1;
write_en=1'b1;
read_addr=17'b00000000000000011;
write_addr=17'b00000000000000011;
write_data=32'b00000000000000000000000000111111;
#10;
read_en=1'b1;
write_en=1'b1;
read_addr=17'b00000000000000011;
write_addr=17'b00000000000110011;
write_data=32'b00000000000000000011110000111100;
#10;
read_en=1'b1;
write_en=1'b1;
read_addr=17'b00000000000110011;
write_addr=17'b11100000000110011;
write_data=32'b00000001111111100011110000111100;
#10;
read_en=1'b1;
write_en=1'b0;
read_addr=17'b11100000000110011;
#10;

end

initial
$monitor($time,"\nread_addr =%d\nread_en=%d\nwrite_addr=%d\nwrite_en=%d\nwrite_data=%d\nclk=%d\nhit=%d\nread_val=%d\n",read_addr,read_en,write_addr,write_en,write_data,clk,hit,read_data);
initial 
#50 $stop;
endmodule

