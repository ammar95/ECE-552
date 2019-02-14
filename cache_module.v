module cache (clk,rst,data_in,addr_in,write_en,write_tag_array, write_data_array, read_con, 
cache_address, cache_en, data_out,addr_out,miss_detected);

input [15:0] data_in,addr_in;
input clk,rst,write_en, write_tag_array, cache_en, write_data_array,read_con ;
input [7:0] cache_address;
output [15:0] data_out,addr_out;
output miss_detected;
wire [15:0] temp_data_out;
wire [63:0] block_en,block_en1,block_en2; 
wire [7:0] DataOut,DataOut2, write_data_in, word_en;
wire lru,write_en1,write_en2;
shifter set_en(.block_en(block_en),.index(addr_in[9:4]));
wire lru_new;
wire miss_detected_temp;

wire DWE1,DWE2,DRE1,DRE2,hit1,hit2;

//assign write_en1=()? write_en:1'b0;
//assign write_en2=(|data_en2)? write_en:1'b0;

assign write_en1= ((cache_en)? ((lru_new)? 1'b0:write_tag_array): 1'b0);
assign write_en2= ((cache_en) ? ((~lru_new)? 1'b0:write_tag_array): 1'b0);
assign addr_out=(cache_en)?addr_in: 16'b0;
assign data_out= (~write_data_array & cache_en)? temp_data_out: 16'b0;


//assign lru_new=((|block_en1) & write_tag_array)? 1'b1: (((|block_en2) & write_tag_array)?1'b0:lru);
//assign lru_new = ~lru;
// always@(posedge clk) begin
	// if (rst)
		// lru_new <= 1'b0;
	// else if (~write_en1 & ~write_en2)
		// lru_new <= lru;
	// else if (hit1|hit2)
		// lru_new <= hit1?1'b1:1'b0;
// end

assign lru_new = hit1?1'b1:1'b0;


//dff dfflru(.q(lru), .d(lru_new), .wen((|block_en1) | (|block_en2)), .clk(clk), .rst(rst));
//dff dfflru(.q(lru), .d(lru_new), .wen(1'b1), .clk(clk), .rst(rst));
// Block_en common???
MetaDataArray mda (.clk(clk), .rst(rst), .DataIn({addr_in[15:10], 1'b1,1'b0}),
.DataIn2({addr_in[15:10], 1'b1,1'b0}),.lru_in(lru_new),.Write(write_en1), .Write2(write_en2),
.BlockEnable(block_en),.BlockEnable2(block_en), .DataOut(DataOut), .DataOut2(DataOut2),.lru_out(lru),.lru_en(hit1|hit2));


assign miss_detected = (write_tag_array)? 1'b0:miss_detected_temp;
//assign block_en1= cache_en ? ((((addr_in[15:10]==DataOut[7:2])& (DataOut[1])) | write_data_array) ? block_en:0): 64'b0 ;
//assign block_en2= cache_en ? ((((addr_in[15:10]==DataOut2[7:2])& DataOut[1]) | write_data_array)? block_en:0): 64'b0; 
//assign block_en1= cache_en ? ((((addr_in[15:10]==DataOut[7:2])& (DataOut[1]))| write_data_array ) ? block_en:64'b0): 64'b0 ;
//assign block_en2= cache_en ? ((((addr_in[15:10]==DataOut2[7:2])& DataOut[1])| write_data_array )? block_en:64'b0): 64'b0;

//assign DWE1 = (write_data_array | write_en) block_en1 : 64'b0;
//assign DWE2 = (write_data_array | write_en) block_en2 : 64'b0;
//assign DRE1 = ~(write_data_array | write_en) block_en1 : 64'b0;
//assign DRE2 = ~(write_data_array | write_en) block_en2 : 64'b0;

//assign d_write= (|data_en1)? 1'b1:1'b0;
//assign d_write2=(|data_en2)? 1'b1:1'b0;

// ALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLENALLEN
assign DWE1 = ((write_data_array | write_en) & ((hit1)?1'b1:(~write_data_array)? 1'b0:~lru) & cache_en);
assign DWE2 = ((write_data_array | write_en) & ((hit2)?1'b1:(~write_data_array)? 1'b0:lru) & cache_en);

assign hit1 = ((addr_in[15:10]==DataOut[7:2])&DataOut[1])&cache_en&~write_tag_array&~rst;
assign hit2 = ((addr_in[15:10]==DataOut2[7:2])&DataOut2[1])&cache_en&~write_tag_array&~rst;

assign block_en1 = (hit1|DWE1) ? block_en: 64'b0;
assign block_en2 = (hit2|DWE2) ? block_en: 64'b0;

assign word_en=write_data_array ? cache_address : 1<<addr_in[3:1];

//assign miss_detected_temp=cache_en ? ((|((addr_in[15:10]==DataOut[7:2])& (DataOut[1])))?1'b0:((|((addr_in[15:10]==DataOut2[7:2])& DataOut[1]))?1'b0:1'b1)): 1'b0;
assign miss_detected_temp= cache_en & ~hit1 & ~hit2;
//DataArray
DataArray da(.clk(clk), .rst(rst), .DataIn(data_in),.Write(DWE1),.Write2(DWE2), 
.BlockEnable(block_en1), .BlockEnable2(block_en2), .WordEnable(word_en), .DataOut(temp_data_out));

endmodule
