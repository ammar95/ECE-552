module MEM_WB ( 
input clk,
input rst,
input hlt,
input [15:0] ALU_out_in,
input [15:0] mem_out_in,
input [3:0] rd_addr_in,
input [2:0] wb_control_in,
input [15:0] pc_in,
input [3:0] opcode_in,
input stall_dcache,
output [15:0] ALU_out_out,
output [15:0] mem_out_out,
output [3:0] rd_addr_out,
output [2:0] wb_control_out,
output [15:0] pc_out,
output [3:0] opcode_out
);

	wire wen;
    assign wen = ~hlt & ~stall_dcache;

    dff alu_out_dff0(.q(ALU_out_out[0]), .d(ALU_out_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff1(.q(ALU_out_out[1]), .d(ALU_out_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff2(.q(ALU_out_out[2]), .d(ALU_out_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff3(.q(ALU_out_out[3]), .d(ALU_out_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff4(.q(ALU_out_out[4]), .d(ALU_out_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff5(.q(ALU_out_out[5]), .d(ALU_out_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff6(.q(ALU_out_out[6]), .d(ALU_out_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff7(.q(ALU_out_out[7]), .d(ALU_out_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff8(.q(ALU_out_out[8]), .d(ALU_out_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff9(.q(ALU_out_out[9]), .d(ALU_out_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff10(.q(ALU_out_out[10]), .d(ALU_out_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff11(.q(ALU_out_out[11]), .d(ALU_out_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff12(.q(ALU_out_out[12]), .d(ALU_out_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff13(.q(ALU_out_out[13]), .d(ALU_out_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff14(.q(ALU_out_out[14]), .d(ALU_out_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff alu_out_dff15(.q(ALU_out_out[15]), .d(ALU_out_in[15]), .wen(wen), .clk(clk), .rst(rst));

    dff mem_out_dff0(.q(mem_out_out[0]), .d(mem_out_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff1(.q(mem_out_out[1]), .d(mem_out_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff2(.q(mem_out_out[2]), .d(mem_out_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff3(.q(mem_out_out[3]), .d(mem_out_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff4(.q(mem_out_out[4]), .d(mem_out_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff5(.q(mem_out_out[5]), .d(mem_out_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff6(.q(mem_out_out[6]), .d(mem_out_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff7(.q(mem_out_out[7]), .d(mem_out_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff8(.q(mem_out_out[8]), .d(mem_out_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff9(.q(mem_out_out[9]), .d(mem_out_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff10(.q(mem_out_out[10]), .d(mem_out_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff11(.q(mem_out_out[11]), .d(mem_out_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff12(.q(mem_out_out[12]), .d(mem_out_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff13(.q(mem_out_out[13]), .d(mem_out_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff14(.q(mem_out_out[14]), .d(mem_out_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_out_dff15(.q(mem_out_out[15]), .d(mem_out_in[15]), .wen(wen), .clk(clk), .rst(rst));

	dff wbpc_dff0(.q(pc_out[0]), .d(pc_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff1(.q(pc_out[1]), .d(pc_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff2(.q(pc_out[2]), .d(pc_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff3(.q(pc_out[3]), .d(pc_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff4(.q(pc_out[4]), .d(pc_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff5(.q(pc_out[5]), .d(pc_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff6(.q(pc_out[6]), .d(pc_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff7(.q(pc_out[7]), .d(pc_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff8(.q(pc_out[8]), .d(pc_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff9(.q(pc_out[9]), .d(pc_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff10(.q(pc_out[10]), .d(pc_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff11(.q(pc_out[11]), .d(pc_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff12(.q(pc_out[12]), .d(pc_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff13(.q(pc_out[13]), .d(pc_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff14(.q(pc_out[14]), .d(pc_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff wbpc_dff15(.q(pc_out[15]), .d(pc_in[15]), .wen(wen), .clk(clk), .rst(rst));
	
	dff rd_addr_dff0(.q(rd_addr_out[0]), .d(rd_addr_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff1(.q(rd_addr_out[1]), .d(rd_addr_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff2(.q(rd_addr_out[2]), .d(rd_addr_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff3(.q(rd_addr_out[3]), .d(rd_addr_in[3]), .wen(wen), .clk(clk), .rst(rst));
	
	dff wb_control_dff0(.q(wb_control_out[0]), .d(wb_control_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff wb_control_dff1(.q(wb_control_out[1]), .d(wb_control_in[1]), .wen(wen), .clk(clk), .rst(rst));
	dff wb_control_dff2(.q(wb_control_out[2]), .d(wb_control_in[2]), .wen(wen), .clk(clk), .rst(rst));
	
		dff wbop_dff0(.q(opcode_out[0]), .d(opcode_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff wbop_dff1(.q(opcode_out[1]), .d(opcode_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff wbop_dff2(.q(opcode_out[2]), .d(opcode_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff wbop_dff3(.q(opcode_out[3]), .d(opcode_in[3]), .wen(wen), .clk(clk), .rst(rst));

 endmodule