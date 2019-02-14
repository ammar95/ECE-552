module Arbitration(I_miss_in, I_miss_out, D_busy, D_write_tag);

	input I_miss_in, D_busy, D_write_tag;
	output I_miss_out;
	
	assign I_miss_out =  (D_busy & ~D_write_tag) ? 0 : I_miss_in;
	


endmodule
