//Data Array of 128 cache blocks
//Each block will have 8 words
//BlockEnable and WordEnable are one-hot
//WriteEnable is one on writes and zero on reads

module DataArray(input clk, input rst, input [15:0] DataIn, input Write, input Write2, 
input [63:0] BlockEnable, input [63:0] BlockEnable2, input [7:0] WordEnable, output [15:0] DataOut);
	wire [15:0] dataout1,dataout2;
	assign DataOut= (|BlockEnable)? dataout1:(|BlockEnable2)?dataout2:16'b0;
	Block blk[63:0]( .clk(clk), .rst(rst), .Din(DataIn), .WriteEnable(Write), .Enable(BlockEnable), .WordEnable(WordEnable), .Dout(dataout1));
	Block blk2[63:0]( .clk(clk), .rst(rst), .Din(DataIn), .WriteEnable(Write2), .Enable(BlockEnable2), .WordEnable(WordEnable), .Dout(dataout2));
endmodule

//64 byte (8 word) cache block
module Block( input clk,  input rst, input [15:0] Din, input WriteEnable, input Enable, input [7:0] WordEnable, output [15:0] Dout);
	wire [7:0] WordEnable_real;
	assign WordEnable_real = {8{Enable}} & WordEnable; //Only for the enabled cache block, you enable the specific word
	DWord dw[7:0]( .clk(clk), .rst(rst), .Din(Din), .WriteEnable(WriteEnable), .Enable(WordEnable_real), .Dout(Dout));
endmodule


//Each word has 16 bits
module DWord( input clk,  input rst, input [15:0] Din, input WriteEnable, input Enable, output [15:0] Dout);
	DCell dc[15:0]( .clk(clk), .rst(rst), .Din(Din[15:0]), .WriteEnable(WriteEnable), .Enable(Enable), .Dout(Dout[15:0]));
endmodule


module DCell( input clk,  input rst, input Din, input WriteEnable, input Enable, output Dout);
	wire q;
	assign Dout = (Enable & ~WriteEnable) ? q:'bz;
	dff dffd(.q(q), .d(Din), .wen(Enable & WriteEnable), .clk(clk), .rst(rst));
endmodule

