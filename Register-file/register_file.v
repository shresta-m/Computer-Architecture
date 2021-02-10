module reg_file(read_addr1,read_addr2,write_addr,data,read_out1,read_out2,clk,reset,write_en);
input [4:0] read_addr1,read_addr2,write_addr; // 2 read addresses and 1 write address where the new data should be wrtten
input [31:0] data; //  data to be written into the register at write address
output [31:0] read_out1,read_out2; // read data at 2 read_address is stored in read_out1 and 2
input clk,reset, write_en, enable;
integer i;
reg [31:0] register[31:0]; // 32 registers each of 32 bit size

// initially assigning zero to the register file
initial begin
    for(i=0;i<32;i=i+1)
    register[i] = 32'h00000000;
end
// read operation takes place always in the register file, as it is not clocked
// reading the register at the specified  2 read addresses
assign read_out1 = register[read_addr1];
assign read_out2 = register[read_addr2];

// write operation happens during the rising edge of clock signal
always@(posedge clk)
begin
    // if the reset option is enabled , then the whole register is cleared
    if(reset == 1'b1)
    begin
        for(i=0;i<32;i=i+1)
        register[i] <= 32'h00000000;
    end
    if(reset == 1'b0)// reset is 0 , so write operation takes place
    begin
        if(write_en == 1'b1)// if write operation is enabled
        begin
            register[write_addr] <= data;// input data is written at the specified address into the register
        end
    end
end
endmodule