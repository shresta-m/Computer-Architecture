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

// wire [2:0] w_tag_r,w_tag_w;
// wire [9:0] temp_line,w_line_w;
// wire [3:0] w_blkoff_r,w_blkoff_w;

// assign w_tag_r = read_addr[16:14];
// assign temp_line = read_addr[13:4];
// assign w_blkoff_r = read_addr[3:0];

// assign w_tag_w = write_addr[16:14];
// assign w_line_w = write_addr[13:4];
// assign w_blkoff_w = write_addr[3:0];

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
}
*/
reg match,w1, x2, x3;
reg [2:0] temp_tag;
reg [9:0] temp_line;
reg [3:0] temp_offset;
reg [12:0] copy;
always@(posedge clk)
begin
    temp_line = read_addr[13:4];
    temp_offset = read_addr[3:0];
    if(valid[temp_line] == 1'b1)
    begin
        temp_tag = cache_tag[temp_line];
        w1 = read_addr[16]^temp_tag[2];
        x2 = read_addr[15]^temp_tag[1];
        x3 = read_addr[14]^temp_tag[0];
        match = w1&x2&x3;
        hit = match;
        if(hit == 1'b1)
        begin
            if(read_en == 1'b1)
            begin
                read_data = cache[temp_line][temp_offset];
            end
        end
        else
        begin
            copy[12:10] = read_addr[16:14];
            copy[9:0] = read_addr[13:4];
            cache_tag[temp_line] = read_addr[16:14];
            cache[temp_line][0] = main_memory[copy][0];
            cache[temp_line][1] = main_memory[copy][1];
            cache[temp_line][2] = main_memory[copy][2];
            cache[temp_line][3] = main_memory[copy][3];
            cache[temp_line][4] = main_memory[copy][4];
            cache[temp_line][5] = main_memory[copy][5];
            cache[temp_line][6] = main_memory[copy][6];
            cache[temp_line][7] = main_memory[copy][7];
            cache[temp_line][8] = main_memory[copy][8];
            cache[temp_line][9] = main_memory[copy][9];
            cache[temp_line][10] = main_memory[copy][10];
            cache[temp_line][11] = main_memory[copy][11];
            cache[temp_line][12] = main_memory[copy][12];
            cache[temp_line][13] = main_memory[copy][13];
            cache[temp_line][14] = main_memory[copy][14];
            cache[temp_line][15] = main_memory[copy][15];
            if(read_en == 1'b1)
            begin
                read_data = cache[temp_line][temp_offset];
            end
            
        end
    end
    else
    begin
        copy[12:10] = read_addr[16:14];
        copy[9:0] = read_addr[13:4];
        cache_tag[temp_line] = read_addr[16:14];
        cache[temp_line][0] = main_memory[copy][0];
        cache[temp_line][1] = main_memory[copy][1];
        cache[temp_line][2] = main_memory[copy][2];
        cache[temp_line][3] = main_memory[copy][3];
        cache[temp_line][4] = main_memory[copy][4];
        cache[temp_line][5] = main_memory[copy][5];
        cache[temp_line][6] = main_memory[copy][6];
        cache[temp_line][7] = main_memory[copy][7];
        cache[temp_line][8] = main_memory[copy][8];
        cache[temp_line][9] = main_memory[copy][9];
        cache[temp_line][10] = main_memory[copy][10];
        cache[temp_line][11] = main_memory[copy][11];
        cache[temp_line][12] = main_memory[copy][12];
        cache[temp_line][13] = main_memory[copy][13];
        cache[temp_line][14] = main_memory[copy][14];
        cache[temp_line][15] = main_memory[copy][15];
        valid[temp_line] = 1'b1;
        if(read_en == 1'b1)
        begin
            read_data = cache[temp_line][temp_offset];
        end     
    end
    if(write_en == 1'b1)
    begin
        temp_line = write_addr[13:4];
        temp_offset = write_addr[3:0];
        cache[temp_line][temp_offset] = write_data;
        valid[temp_line] = 1'b1;
        cache_tag[temp_line] = write_addr[16:14];

        copy[12:10]=write_addr[16:14];
        copy[9:0]=write_addr[13:4];
        main_memory[copy][temp_offset]=write_data;
       
    end
end
endmodule