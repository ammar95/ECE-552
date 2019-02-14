module cache_fill_FSM(clk, rst, miss_detected, miss_address, fsm_busy, write_data_array, write_tag_array,
memory_address, cache_address, memory_data_valid, memory_enable);

	input clk, rst; 
	input miss_detected; // active high when tag match logic detects a miss 
	input [15:0] miss_address; // address that missed the cache 
	input memory_data_valid; // active high indicates valid data returning on memory bus 
	output fsm_busy; // asserted while FSM is busy handling the miss (can be used as pipeline stall signal) 
	output write_data_array; // write enable to cache data array to signal when filling with memory_data 
	output write_tag_array; // write enable to cache tag array to signal when all words are filled in to data array 
	output [15:0] memory_address; // address to read from memory 
	output [7:0] cache_address;
	output memory_enable;
	
	wire counter_rst, adder_rst;
	wire[3:0] count1, count2;
	wire new_fsm_busy;
	
	assign counter_rst = (count1 == 4'b1100)|rst;
	assign adder_rst = miss_detected|(count1[3]);
	assign memory_address= (fsm_busy) ? ({miss_address[15:4],count1<<1}):16'b0;
	assign cache_address=1<<count2;
	assign fsm_busy = rst?0:((miss_detected|write_tag_array)); //& (count1 < 4'b1100));//((~count1[3])|((~count1[1])&(~count1[0]))|(count1[3]&(~count1[2])));
	assign write_data_array = memory_data_valid & fsm_busy;//(count1[3]|count1[2])&~write_tag_array;
	assign write_tag_array = count1[3]&count1[2];
	assign memory_enable = fsm_busy & ~count1[3];
	
	up_counter_4bit c1(clk, fsm_busy, counter_rst, count1);
//	up_counter_4bit c2(clk, memory_data_valid, counter_rst, count2);
	up_counter_4bit c2(clk, write_data_array, counter_rst, count2);
	
endmodule

/* module up_counter_4bit(clk, wen, rst, q);
	input clk,wen,rst;
	output [3:0] q;
	reg [3:0] val;
	always@(posedge clk) begin
	if (rst)
		val <= 0;
	else if (wen)
		val <= val + 4'b0001;
	end
assign q = val;
	
endmodule */

module up_counter_4bit(clk, wen, rst, q);

	input clk, wen, rst;
	output[3:0] q;
	
	wire wen;
	
	wire in0,q0,q_n0;
	wire in1,q1,q_n1;
	wire in2,q2,q_n2;
	wire in3,q3,q_n3;
	
	df dff0(.q(q0), .q_n(q_n0), .d(in0), .wen(wen), .clk(clk), .rst(rst));
	assign in0=q_n0;
	
	
	df dff1(.q(q1), .q_n(q_n1), .d(in1), .wen(wen), .clk(clk), .rst(rst));
	assign in1=(q0 & q_n1)|(q_n0 & q1)|(q0 & q2 & q3)|(q1 & q2 & q3);//q1^q0;
	
	
	df dff2(.q(q2), .q_n(q_n2), .d(in2), .wen(wen), .clk(clk), .rst(rst));
	assign in2=(q0& q1 & q_n2)|(q_n0 & q1 & q2)|(q_n1 & q2 & q_n3);//(q2&q_n0)|(q2&q_n1)|(q_n2&q1&q0);
	
	
	df dff3(.q(q3), .q_n(q_n3), .d(in3), .wen(wen), .clk(clk), .rst(rst));
	assign in3=(q0 & q1 & q2)|(q0 & q3)|(q_n2 & q3);//(q3&q_n2)|(q3&q_n1)|(q3&q_n0)|(q_n3);
	
	assign q = {q3,q2,q1,q0};
endmodule

module df (q, q_n, d, wen, clk, rst);

    output         q,q_n; //DFF output
    input          d; //DFF input
    input    wen; //Write Enable
    input          clk; //Clock
    input          rst; //Reset (used synchronously)

    reg            state;

    assign q = state;
assign q_n=~q;

    always @(posedge clk) begin
      state <= rst ? 0 : (wen ? d : state);
    end


endmodule


module dff (q, d, wen, clk, rst);

    output         q; //DFF output
    input          d; //DFF input
    input 	   wen; //Write Enable
    input          clk; //Clock
    input          rst; //Reset (used synchronously)

    reg            state;

    assign q = state;

    always @(posedge clk) begin
      state = rst ? 0 : (wen ? d : state);
    end

endmodule
