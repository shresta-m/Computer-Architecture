module reg_file(read_addr1,read_addr2,write_addr,data,read_out1,read_out2,clk,reset,read_en,write_en,enable);
input [4:0] read_addr1,read_addr2,write_addr;
input [31:0] data;
output [31:0] read_out1,read_out2;
input clk,reset, read_en, write_en, enable;
integer i;
reg [31:0] register[31:0];

// initially assigning zero to the register file
initial begin
    for(i=0;i<32;i=i+1)
    register[i] = 32'h00000000;
end

always@(posedge clk)
begin
    // if the reset option is enabled , then the whole register is reset to start the new simulation
    if(reset == 1'b1)
    begin
        for(i=0;i<32;i=i+1)
        register[i] = 32'h00000000;
    end
    // if enable is 1 , then either read or write operation may take place
    if(enable == 1'b1)
    begin
        if(reset == 1'b0)// if enable is 1,then reset should be 0
        begin
            if(read_en == 1'b1)//if read mode is enabled
            begin
                read_out1 = register[read_addr1];//since the register file has 2 read ports 
                read_out2 = register[read_addr2];// 2 datas at the specified address is read and stored in output port
            end
            if(write_en == 1'b1)// if write is enabled
            begin
                register[write_addr] = data;// new data is written at the specified address
            end
        end
    end
end
endmodule
























