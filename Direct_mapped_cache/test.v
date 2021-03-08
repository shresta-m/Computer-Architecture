module cache(read_addr,write_addr,read_en,write_en,write_data,clk,hit,read_data);
input [16:0] read_addr,write_addr;
input [31:0] write_data;
input clk,read_en ,write_en ;
output reg hit;
output reg [31:0] read_data;

reg [31:0] cache [1023:0][15:0];
reg [2:0] cache_tag[1023:0];
reg [31:0] main_memory[8191:0][15:0];
reg valid [1023:0] ;

// Cache has 1024 blocks, where each block has 16 words and each word size is 32 bit
// index is 10 bit = 2^10 blocks
// word offset is 4 bit = 2^4 words
// tag is 3 bit
// 1024*8*16 means 17 bit address
wire [2:0] w_tag_r,w_tag_w;
wire [9:0] w_index_r , w_index_w;
wire [3:0] w_offset_r , w_offset_w;

integer i;
initial begin
    for(i=0;i<1024;i=i+1)begin
        valid[i] = 1'b0;
    end
end

integer j;
initial begin
    for(i=0;i<8192;i=i+1)begin
        for(j=0;j<16;j=j+1)begin
            main_memory[i][j] = i+j;
        end
    end
end

assign w_tag_r = read_addr[16:14];
assign w_index_r = read_addr[13:4];
assign w_offset_r = read_addr[3:0];

assign w_tag_w = write_addr[16:14];
assign w_index_w = write_addr[13:4];
assign w_offset_w = write_addr[3:0];

reg [12:0] copy;
reg a1,a2,a3,match;
reg [3:0] temp_tags;
always@(posedge clk)
begin
    if(valid[w_index_r] == 1'b1)
    begin
        temp_tags = cache_tag[w_index_r];
        a1 = ~(w_tag_r[2]^temp_tags[2]);
        a2 = ~(w_tag_r[1]^temp_tags[1]);
        a3 = ~(w_tag_r[0]^temp_tags[0]);
        match = a1&a2&a3;
        hit = match;
        if(hit ==1'b1)
        begin
            if(read_en == 1'b1)
            begin
                read_data = cache[w_index_r][w_offset_r];
            end
        end
        else
        begin
            copy[12:10] = read_addr[16:14];
            copy[9:0] = read_addr[13:4];
            cache[w_index_r][0] = main_memory[copy][0];
            cache[w_index_r][1] = main_memory[copy][1];
            cache[w_index_r][2] = main_memory[copy][2];
            cache[w_index_r][3] = main_memory[copy][3];
            cache[w_index_r][4] = main_memory[copy][4];
            cache[w_index_r][5] = main_memory[copy][5];
            cache[w_index_r][6] = main_memory[copy][6];
            cache[w_index_r][7] = main_memory[copy][7];
            cache[w_index_r][8] = main_memory[copy][8];
            cache[w_index_r][9] = main_memory[copy][9];
            cache[w_index_r][10] = main_memory[copy][10];
            cache[w_index_r][11] = main_memory[copy][11];
            cache[w_index_r][12] = main_memory[copy][12];
            cache[w_index_r][13] = main_memory[copy][13];
            cache[w_index_r][14] = main_memory[copy][14];
            cache[w_index_r][15] = main_memory[copy][15];
            if(read_en == 1'b1)
            begin
                read_data = cache[w_index_r][w_offset_r];  
            end
        end   
    end
    else
    begin
        copy[12:10] = read_addr[16:14];
        copy[9:0] = read_addr[13:4];
        cache[w_index_r][0] = main_memory[copy][0];
        cache[w_index_r][1] = main_memory[copy][1];
        cache[w_index_r][2] = main_memory[copy][2];
        cache[w_index_r][3] = main_memory[copy][3];
        cache[w_index_r][4] = main_memory[copy][4];
        cache[w_index_r][5] = main_memory[copy][5];
        cache[w_index_r][6] = main_memory[copy][6];
        cache[w_index_r][7] = main_memory[copy][7];
        cache[w_index_r][8] = main_memory[copy][8];
        cache[w_index_r][9] = main_memory[copy][9];
        cache[w_index_r][10] = main_memory[copy][10];
        cache[w_index_r][11] = main_memory[copy][11];
        cache[w_index_r][12] = main_memory[copy][12];
        cache[w_index_r][13] = main_memory[copy][13];
        cache[w_index_r][14] = main_memory[copy][14];
        cache[w_index_r][15] = main_memory[copy][15];
        if(read_en == 1'b1)
        begin
            read_data = cache[w_index_r][w_offset_r];  
        end
    end 
    if(write_en == 1'b1)
    begin
        cache[w_index_w][w_offset_w] = write_data;
        valid[w_index_w] = 1'b1;
        cache_tag[w_index_r] = w_tag_w;
        copy[12:10]= w_tag_w;
        copy[9:0]= w_index_w;
        main_memory[copy][w_offset_w]= write_data;
    end  
end

endmodule