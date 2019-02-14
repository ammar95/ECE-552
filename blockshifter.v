module shifter(block_en,index);

output [63:0] block_en;
input [5:0] index;

assign block_en=1<<index;
//assign block_en2=1<<index<<1;

endmodule