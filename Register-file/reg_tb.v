`include "register_file.v"
module top;
reg [4:0] read_addr1,read_addr2,write_addr;
reg [31:0] data;
wire [31:0] read_out1,read_out2;
reg clk,reset, write_en;

reg_file reg1(read_addr1,read_addr2,write_addr,data,read_out1,read_out2,clk,reset,write_en);
always #1 clk = ~clk;
    initial
    begin
        clk =0; reset=1'b1; 
        #1  reset=1'b0; data=32'd101010; write_addr=5'd15;; read_addr1=5'd15; read_addr2=5'd28; write_en=1'b0; 

        #2 write_en=1'b1; 
        #2 write_addr=5'd28; data=32'd5400;
        // #1 reset = 1'b1;
        // #1 reset = 1'b0;
        #2 read_addr1=5'd1; read_addr2=5'd20;data = 32'd34567;write_addr = 5'd1;
        #2 write_en=1'b1; 
        #2 write_addr=5'd20; data=32'd265;
       // #2 reset = 1'b1;

        #1 $finish;
    end


    initial
    begin
        $monitor($time,"\nread_addr1 = %d\nread_addr2 = %d\nwrite_addr = %d\ndata = %d\nread_out1 = %d\nread_out2 = %d\nclk,reset,write enable = %d,%d,%d\n",read_addr1,read_addr2,write_addr,data,read_out1,read_out2,clk,reset,write_en);
    end
endmodule