module ID_EX ( 
input clk,
input rst,
input hlt,
input [15:0] rs_data_in,
input [15:0] rt_data_in,
input [15:0] imm_in,
input  [3:0] rs_addr_in,
input  [3:0] rt_addr_in,
input  [3:0] rd_addr_in,
input [4:0] ex_control_in,
input [1:0] mem_control_in,
input [2:0] wb_control_in,
input [3:0] opcode_in,
input [15:0] pc_in,
input stall_dcache,
output [15:0] rs_data_out,
output [15:0] rt_data_out,
output [15:0] imm_out,
output  [3:0] rs_addr_out,
output [3:0] rt_addr_out,
output  [3:0] rd_addr_out,
output [4:0] ex_control_out,
output [1:0] mem_control_out,
output [2:0] wb_control_out,
output [3:0] opcode_out,
output [15:0] pc_out
);

	wire wen;
    assign wen = ~hlt & ~stall_dcache;

    dff rs_dff0(.q(rs_data_out[0]), .d(rs_data_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff1(.q(rs_data_out[1]), .d(rs_data_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff2(.q(rs_data_out[2]), .d(rs_data_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff3(.q(rs_data_out[3]), .d(rs_data_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff4(.q(rs_data_out[4]), .d(rs_data_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff5(.q(rs_data_out[5]), .d(rs_data_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff6(.q(rs_data_out[6]), .d(rs_data_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff7(.q(rs_data_out[7]), .d(rs_data_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff8(.q(rs_data_out[8]), .d(rs_data_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff9(.q(rs_data_out[9]), .d(rs_data_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff10(.q(rs_data_out[10]), .d(rs_data_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff11(.q(rs_data_out[11]), .d(rs_data_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff12(.q(rs_data_out[12]), .d(rs_data_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff13(.q(rs_data_out[13]), .d(rs_data_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff14(.q(rs_data_out[14]), .d(rs_data_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_dff15(.q(rs_data_out[15]), .d(rs_data_in[15]), .wen(wen), .clk(clk), .rst(rst));

	
    dff rt_dff0(.q(rt_data_out[0]), .d(rt_data_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff1(.q(rt_data_out[1]), .d(rt_data_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff2(.q(rt_data_out[2]), .d(rt_data_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff3(.q(rt_data_out[3]), .d(rt_data_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff4(.q(rt_data_out[4]), .d(rt_data_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff5(.q(rt_data_out[5]), .d(rt_data_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff6(.q(rt_data_out[6]), .d(rt_data_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff7(.q(rt_data_out[7]), .d(rt_data_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff8(.q(rt_data_out[8]), .d(rt_data_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff9(.q(rt_data_out[9]), .d(rt_data_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff10(.q(rt_data_out[10]), .d(rt_data_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff11(.q(rt_data_out[11]), .d(rt_data_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff12(.q(rt_data_out[12]), .d(rt_data_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff13(.q(rt_data_out[13]), .d(rt_data_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff14(.q(rt_data_out[14]), .d(rt_data_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_dff15(.q(rt_data_out[15]), .d(rt_data_in[15]), .wen(wen), .clk(clk), .rst(rst));

	
	
	dff imm_dff0(.q(imm_out[0]), .d(imm_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff1(.q(imm_out[1]), .d(imm_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff2(.q(imm_out[2]), .d(imm_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff3(.q(imm_out[3]), .d(imm_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff4(.q(imm_out[4]), .d(imm_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff5(.q(imm_out[5]), .d(imm_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff6(.q(imm_out[6]), .d(imm_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff7(.q(imm_out[7]), .d(imm_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff8(.q(imm_out[8]), .d(imm_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff9(.q(imm_out[9]), .d(imm_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff10(.q(imm_out[10]), .d(imm_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff11(.q(imm_out[11]), .d(imm_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff12(.q(imm_out[12]), .d(imm_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff13(.q(imm_out[13]), .d(imm_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff14(.q(imm_out[14]), .d(imm_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff imm_dff15(.q(imm_out[15]), .d(imm_in[15]), .wen(wen), .clk(clk), .rst(rst));

	dff expc_dff0(.q(pc_out[0]), .d(pc_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff1(.q(pc_out[1]), .d(pc_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff2(.q(pc_out[2]), .d(pc_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff3(.q(pc_out[3]), .d(pc_in[3]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff4(.q(pc_out[4]), .d(pc_in[4]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff5(.q(pc_out[5]), .d(pc_in[5]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff6(.q(pc_out[6]), .d(pc_in[6]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff7(.q(pc_out[7]), .d(pc_in[7]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff8(.q(pc_out[8]), .d(pc_in[8]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff9(.q(pc_out[9]), .d(pc_in[9]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff10(.q(pc_out[10]), .d(pc_in[10]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff11(.q(pc_out[11]), .d(pc_in[11]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff12(.q(pc_out[12]), .d(pc_in[12]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff13(.q(pc_out[13]), .d(pc_in[13]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff14(.q(pc_out[14]), .d(pc_in[14]), .wen(wen), .clk(clk), .rst(rst));
    dff expc_dff15(.q(pc_out[15]), .d(pc_in[15]), .wen(wen), .clk(clk), .rst(rst));
	
	dff rs_addr_dff0(.q(rs_addr_out[0]), .d(rs_addr_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_addr_dff1(.q(rs_addr_out[1]), .d(rs_addr_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_addr_dff2(.q(rs_addr_out[2]), .d(rs_addr_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rs_addr_dff3(.q(rs_addr_out[3]), .d(rs_addr_in[3]), .wen(wen), .clk(clk), .rst(rst));
	
	dff rt_addr_dff0(.q(rt_addr_out[0]), .d(rt_addr_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_addr_dff1(.q(rt_addr_out[1]), .d(rt_addr_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_addr_dff2(.q(rt_addr_out[2]), .d(rt_addr_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rt_addr_dff3(.q(rt_addr_out[3]), .d(rt_addr_in[3]), .wen(wen), .clk(clk), .rst(rst));
	
	dff rd_addr_dff0(.q(rd_addr_out[0]), .d(rd_addr_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff1(.q(rd_addr_out[1]), .d(rd_addr_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff2(.q(rd_addr_out[2]), .d(rd_addr_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff rd_addr_dff3(.q(rd_addr_out[3]), .d(rd_addr_in[3]), .wen(wen), .clk(clk), .rst(rst));
	
	dff ex_control_dff0(.q(ex_control_out[0]), .d(ex_control_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff ex_control_dff1(.q(ex_control_out[1]), .d(ex_control_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff ex_control_dff2(.q(ex_control_out[2]), .d(ex_control_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff ex_control_dff3(.q(ex_control_out[3]), .d(ex_control_in[3]), .wen(wen), .clk(clk), .rst(rst));
	dff ex_control_dff4(.q(ex_control_out[4]), .d(ex_control_in[4]), .wen(wen), .clk(clk), .rst(rst));
	
	dff mem_control_dff0(.q(mem_control_out[0]), .d(mem_control_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff mem_control_dff1(.q(mem_control_out[1]), .d(mem_control_in[1]), .wen(wen), .clk(clk), .rst(rst));
   
	dff wb_control_dff0(.q(wb_control_out[0]), .d(wb_control_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff wb_control_dff1(.q(wb_control_out[1]), .d(wb_control_in[1]), .wen(wen), .clk(clk), .rst(rst));
	dff wb_control_dff2(.q(wb_control_out[2]), .d(wb_control_in[2]), .wen(wen), .clk(clk), .rst(rst));
  
	dff op_dff0(.q(opcode_out[0]), .d(opcode_in[0]), .wen(wen), .clk(clk), .rst(rst));
    dff op_dff1(.q(opcode_out[1]), .d(opcode_in[1]), .wen(wen), .clk(clk), .rst(rst));
    dff op_dff2(.q(opcode_out[2]), .d(opcode_in[2]), .wen(wen), .clk(clk), .rst(rst));
    dff op_dff3(.q(opcode_out[3]), .d(opcode_in[3]), .wen(wen), .clk(clk), .rst(rst));
 
 endmodule