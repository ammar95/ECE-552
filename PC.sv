module PC (
    input clk,    // Clock
    input rst,  // Asynchronous reset active low
    input hlt,
	input stall,
    input [15:0]pc_in,
    output [15:0]pc_out
);

    wire wen;
    assign wen = ~hlt & ~stall;

    dff U_dff0(.q(pc_out[0]), .d(pc_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff1(.q(pc_out[1]), .d(pc_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff2(.q(pc_out[2]), .d(pc_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff3(.q(pc_out[3]), .d(pc_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff4(.q(pc_out[4]), .d(pc_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff5(.q(pc_out[5]), .d(pc_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff6(.q(pc_out[6]), .d(pc_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff7(.q(pc_out[7]), .d(pc_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff8(.q(pc_out[8]), .d(pc_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff9(.q(pc_out[9]), .d(pc_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff10(.q(pc_out[10]), .d(pc_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff11(.q(pc_out[11]), .d(pc_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff12(.q(pc_out[12]), .d(pc_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff13(.q(pc_out[13]), .d(pc_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff14(.q(pc_out[14]), .d(pc_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff U_dff15(.q(pc_out[15]), .d(pc_in[15]), .wen(wen), .clk(clk), .rst(rst));

endmodule