module cache(read_addr,write_addr,write_data,clk,read_en,write_en,hit ,read_data);
input [16:0] read_addr,write_addr;
input [31:0] write_data;
input clk ,read_en , write_en;
output reg [31:0] read_data;
output reg hit;
/*
Cache has 1024 blocks, with block size of 16 words and each word is 32 bit in size
So , For Main memory we will take 8 times of cache
Word offset is 4 bits
index is 10 bits
tag is 3 bits 
So , 1024*8*16 means 17 bit address
*/
reg [31:0] cache [1023:0][15:0];
reg [2:0] cache_tag [1023:0];
reg [31:0] main_memory [8191:0][15:0];
reg valid [1023:0]; 

wire [2:0] w_tag_r,w_tag_w;
wire [9:0] w_line_r,w_line_w;
wire [3:0] w_blkoff_r,w_blkoff_w;

assign w_tag_r = read_addr[16:14];
assign w_line_r = read_addr[13:4];
assign w_blkoff_r = read_addr[3:0];

assign w_tag_w = write_addr[16:14];
assign w_line_w = write_addr[13:4];
assign w_blkoff_w = write_addr[3:0];

// initially setting all valid bits as 0
integer  i;
initial begin
    for(i=0;i<1024;i=i+1)
    begin
        valid[i] = 1'b0;
    end
end

integer j;
initial begin
    for(i =0;i<8192;i=i+1)begin
        for(j=0;j<16;j=j+1)begin
            main_memory[i][j] = i+j;
        end
    end
end
/*
if valid 
{
if hit
    read data
else
    load and read // cache miss
}
else
{
    load and read
    make valid as 1
}
*/
reg match,w1, x2, x3;
reg [2:0] temp;
reg [12:0] temp1;
always@(posedge clk)
begin
    if(valid[w_line_r] == 1'b1)
    begin
        temp = cache_tag[w_line_r];
        w1 = ~(w_tag_r[2]^temp[2]);
        x2 = ~(w_tag_r[1]^temp[1]);
        x3 = ~(w_tag_r[0]^temp[0]);
        match = w1 & x2 & x3;
        hit = match;
        if(hit == 1'b1)
        begin
            if(read_en == 1'b1)
            begin
                read_data = cache[w_line_r][w_blkoff_r];
            end
        end
        else
        begin
            temp1[12:10] = w_tag_r;
            temp1[9:0] = w_line_r;
            cache_tag[w_line_r] = w_tag_r;
            cache[w_line_r][0] = main_memory[temp1][0];
            cache[w_line_r][1] = main_memory[temp1][1];
            cache[w_line_r][2] = main_memory[temp1][2];
            cache[w_line_r][3] = main_memory[temp1][3];
            cache[w_line_r][4] = main_memory[temp1][4];
            cache[w_line_r][5] = main_memory[temp1][5];
            cache[w_line_r][6] = main_memory[temp1][6];
            cache[w_line_r][7] = main_memory[temp1][7];
            cache[w_line_r][8] = main_memory[temp1][8];
            cache[w_line_r][9] = main_memory[temp1][9];
            cache[w_line_r][10] = main_memory[temp1][10];
            cache[w_line_r][11] = main_memory[temp1][11];
            cache[w_line_r][12] = main_memory[temp1][12];
            cache[w_line_r][13] = main_memory[temp1][13];
            cache[w_line_r][14] = main_memory[temp1][14];
            cache[w_line_r][15] = main_memory[temp1][15];
            if(read_en == 1'b1)
            begin
                read_data = cache[w_line_r][w_blkoff_r];
            end
            
        end
    end
    else
    begin
        temp1[12:10] = w_tag_r;
        temp1[9:0] = w_line_r;
        cache_tag[w_line_r] = w_tag_r;
        cache[w_line_r][0] = main_memory[temp1][0];
        cache[w_line_r][1] = main_memory[temp1][1];
        cache[w_line_r][2] = main_memory[temp1][2];
        cache[w_line_r][3] = main_memory[temp1][3];
        cache[w_line_r][4] = main_memory[temp1][4];
        cache[w_line_r][5] = main_memory[temp1][5];
        cache[w_line_r][6] = main_memory[temp1][6];
        cache[w_line_r][7] = main_memory[temp1][7];
        cache[w_line_r][8] = main_memory[temp1][8];
        cache[w_line_r][9] = main_memory[temp1][9];
        cache[w_line_r][10] = main_memory[temp1][10];
        cache[w_line_r][11] = main_memory[temp1][11];
        cache[w_line_r][12] = main_memory[temp1][12];
        cache[w_line_r][13] = main_memory[temp1][13];
        cache[w_line_r][14] = main_memory[temp1][14];
        cache[w_line_r][15] = main_memory[temp1][15];
        valid[w_line_r] = 1'b1;
        if(read_en == 1'b1)
        begin
            read_data = cache[w_line_r][w_blkoff_r];
        end     
    end
    if(write_en == 1'b1)
    begin
        cache[w_line_w][w_blkoff_w] = write_data;
        valid[w_line_w] = 1'b1;
        temp1[12:10] = w_tag_w;
        temp1[9:0] = w_line_w;
        cache_tag[w_line_w] = w_tag_w;
        main_memory[temp1][w_blkoff_w] = write_data;
    end
end
endmodule