module IF_ID ( 
input clk,
input rst,
input hlt,
input stall,
input [15:0] pc_in,
input [15:0] ins_in,
input flush,
output [15:0] pc_out,
output [15:0] ins_out
);

	wire wen;
	wire [15:0] ins_o;
    assign wen = ~hlt & ~stall;

    dff pc_dff0(.q(pc_out[0]), .d(pc_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff1(.q(pc_out[1]), .d(pc_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff2(.q(pc_out[2]), .d(pc_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff3(.q(pc_out[3]), .d(pc_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff4(.q(pc_out[4]), .d(pc_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff5(.q(pc_out[5]), .d(pc_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff6(.q(pc_out[6]), .d(pc_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff7(.q(pc_out[7]), .d(pc_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff8(.q(pc_out[8]), .d(pc_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff9(.q(pc_out[9]), .d(pc_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff10(.q(pc_out[10]), .d(pc_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff11(.q(pc_out[11]), .d(pc_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff12(.q(pc_out[12]), .d(pc_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff13(.q(pc_out[13]), .d(pc_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff14(.q(pc_out[14]), .d(pc_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff pc_dff15(.q(pc_out[15]), .d(pc_in[15]), .wen(wen), .clk(clk), .rst(rst));

	assign ins_o=(flush) ? 16'h4000: ins_in;
    dff ins_dff0(.q(ins_out[0]), .d(ins_o[0]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff1(.q(ins_out[1]), .d(ins_o[1]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff2(.q(ins_out[2]), .d(ins_o[2]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff3(.q(ins_out[3]), .d(ins_o[3]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff4(.q(ins_out[4]), .d(ins_o[4]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff5(.q(ins_out[5]), .d(ins_o[5]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff6(.q(ins_out[6]), .d(ins_o[6]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff7(.q(ins_out[7]), .d(ins_o[7]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff8(.q(ins_out[8]), .d(ins_o[8]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff9(.q(ins_out[9]), .d(ins_o[9]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff10(.q(ins_out[10]), .d(ins_o[10]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff11(.q(ins_out[11]), .d(ins_o[11]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff12(.q(ins_out[12]), .d(ins_o[12]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff13(.q(ins_out[13]), .d(ins_o[13]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff14(.q(ins_out[14]), .d(ins_o[14]), .wen(wen), .clk(clk), .rst(rst));
    dff ins_dff15(.q(ins_out[15]), .d(ins_o[15]), .wen(wen), .clk(clk), .rst(rst));



 endmodule