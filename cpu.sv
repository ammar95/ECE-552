module cpu (
    input clk,    // Clock
    input rst_n,  // Asynchronous reset active low
    output hlt,
    output [15:0]pc
);

    wire rst;

    // pc
    wire [15:0]pc_next;
    wire [15:0]pc_plus2;
	wire [15:0]pc_branch;
	wire flush, stop_pc, if_hlt, conditional, combined_stall;

    // inst mem signals
    wire [15:0]instaddr; // this is pc
    wire [15:0]inst;
	
    // reg signals
    wire [3:0]regrdaddr1;
    wire [3:0]regrdaddr2;
    wire [15:0]regout1;
    wire [15:0]regout2;

    //wire regwr;
    wire [3:0]regwraddr;
    wire [15:0]regwrdata;

    // alu signals
    wire [15:0]aluin1;
    wire [15:0]aluin2sel, aluin2;
    wire [3:0]aluctrl;
    wire [15:0]aluout;
    wire aluovfl;

    // data mem signals
    wire [15:0]dataout;
    //wire [15:0]datain;
    //wire [15:0]dataaddr;
   // wire [15:0] PC_plus2;
	wire dataena;
    //wire datawr;

    // control signals
    wire regdst;
    wire branch;
    wire memread;
    wire [1:0]memtoreg;
    wire [3:0]aluop;
    wire memwrite;
    wire alusrc;
    wire regwrite;
	wire regwrite_temp;
	
    // branch signals
    wire [2:0]flag;
    wire [15:0]signeximm;
    wire [2:0]ctrlcode;

    assign rst = ~rst_n;
    
	// IF/ID wires
	wire [15:0] inst_IF_ID;
	wire [15:0] pc_IF_ID;
	
	// ID/EX Wires
	wire [15:0] ex_rs_data,ex_rt_data,ex_imm,ex_rt_data_new;
	wire [3:0] ex_rs_addr, ex_rt_addr, ex_rd_addr;
	wire [4:0] ex_control;
	wire [2:0] ex_wb_control;
	wire [1:0]  ex_mem_control;
	wire [3:0] ex_opcode;
	wire [15:0] pc_ex;
	
	// EXMEM Wires
	wire [15:0] mem_alu_result, mem_write_data;
	wire [15:0] pc_mem;
	wire [3:0] mem_rd_addr,mem_rt_addr;
	wire [2:0] mem_wb_control;
	wire [1:0] mem_control;
	wire [3:0] mem_opcode;
	wire dataena_mem;
	
	wire [5:0] addr_for_mem;
	
	//MEMWB wires
	wire [15:0] wb_alu_result, wb_datamem;
	wire [15:0] pc_wb;
	wire [3:0] wb_rd_addr;
	wire [2:0] wb_control;
	wire [3:0] wb_opcode;
	
	//Forwarding wires
	wire [1:0] ForwardA,ForwardB;
	wire ForwardM;
	
	//Hazard unit wire
	wire Enable_stall;
	
	wire [9:0]control_sigs; //stall logic
	
	
	// I-FSM declarations
	
	wire i_fsm_busy, i_data_wr, i_tag_wr;
	wire [7:0] i_cache_addr;
	wire i_miss, read_con;
	wire [15:0] i_addr_out, i_mem_addr;
	//Multicycle memory declarations
	wire data_valid;
	wire [15:0] mem_data_out;
	// Arbitration Module
	wire i_miss_out;
	// D-Cache declarations
	wire [15:0] data_in, d_addr_out;
	wire d_miss;
	wire [15:0] d_data_in,d_mem_addr;
		//D-FSM
	wire d_fsm_busy,d_data_wr,d_tag_wr;
	wire [7:0] d_cache_addr;
	
	/////D cache stall;
	wire stall_dcache;
	
	assign control_sigs= (combined_stall)? 10'h0: ({memread,memtoreg,aluop,memwrite,alusrc,regwrite});
	//ex_mem_control[0] | 
	//ex_wb_control[2]&
	assign pre_n = (((ex_opcode == 4'b0000) | (ex_opcode == 4'b0001) | (ex_opcode == 4'b0010) | (ex_opcode == 4'b0100)|(ex_opcode == 4'b0101)|(ex_opcode == 4'b0110)));
	assign conditional = ((ctrlcode != 3'b111) ) ? 1'b1:1'b0;
	assign combined_stall = ((Enable_stall | (branch & conditional & pre_n)));
	assign fsm_busy = (i_fsm_busy | d_fsm_busy);
	
	//assign stall_dcache=d_fsm_busy;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Pipeline Registers
	//IF/ID pipeline registers
	IF_ID IF_ID1 (.clk(clk),.rst(rst),.hlt(hlt),.stall(combined_stall | fsm_busy),.pc_in(pc_plus2),.ins_in(inst),.flush(flush),		//input
	.pc_out(pc_IF_ID),.ins_out(inst_IF_ID));														//output
	
		
	//ID/EX Pipeline registers
	ID_EX ID_EX1 ( .clk(clk),.rst(rst),.hlt(hlt),
	.rs_data_in(regout1),.rt_data_in(regout2),.imm_in(signeximm),
	.rs_addr_in(regrdaddr1),.rt_addr_in(regrdaddr2),.rd_addr_in(regwraddr),
	.ex_control_in({control_sigs[6:3],control_sigs[1]}),
	.mem_control_in({control_sigs[9],control_sigs[2]}),
	.wb_control_in({control_sigs[0],control_sigs[8:7]}),
	.opcode_in(inst_IF_ID[15:12]),
	.pc_in(pc_IF_ID), .stall_dcache(fsm_busy & ~combined_stall), 													//input
	.rs_data_out(ex_rs_data),.rt_data_out(ex_rt_data),.imm_out(ex_imm), 							//output
	.rs_addr_out(ex_rs_addr),.rt_addr_out(ex_rt_addr),.rd_addr_out(ex_rd_addr),
	.ex_control_out(ex_control),.mem_control_out(ex_mem_control),.wb_control_out(ex_wb_control),
	.opcode_out(ex_opcode),
	.pc_out(pc_ex)
	);
	//  EX/MEM Pipeline registers
	assign ex_rt_data_new = (ForwardB[0] & ex_mem_control[0]) ? regwrdata:ex_rt_data;
	EX_MEM EX_MEM1( .clk(clk),.rst(rst),.hlt(hlt),
	.ALU_out_in(aluout),
	.write_data_in(ex_rt_data_new),
	.rd_addr_in(ex_rd_addr),
	.mem_control_in(ex_mem_control),.wb_control_in(ex_wb_control),
	.rt_addr_in(ex_rt_addr),
	.dataenaexmem_in(dataena),
	.pc_in(pc_ex),	 .stall_dcache(fsm_busy & ~combined_stall),																				
	.opcode_in(ex_opcode),																			//input
	.ALU_out_out(mem_alu_result),																	//output
	.write_data_out(mem_write_data),
	.rd_addr_out(mem_rd_addr),
	.mem_control_out(mem_control),
	.wb_control_out(mem_wb_control),
	.rt_addr_out(mem_rt_addr),
	.dataenaexmem_out(dataena_mem),
	.pc_out(pc_mem),
	.opcode_out(mem_opcode)
	);

	// MEM WB pipeline registers
	MEM_WB MEM_WB1 ( .clk(clk),.rst(rst),.hlt(hlt),
	.ALU_out_in(mem_alu_result),
	.mem_out_in(dataout),
	.rd_addr_in(mem_rd_addr),
	.wb_control_in(mem_wb_control),
	.pc_in(pc_mem),	 .stall_dcache(fsm_busy & ~combined_stall),																			
	.opcode_in(mem_opcode),																			//input
	.ALU_out_out(wb_alu_result),																	//output
	.mem_out_out(wb_datamem),
	.rd_addr_out(wb_rd_addr),
	.wb_control_out(wb_control),
	.pc_out(pc_wb),
	.opcode_out(wb_opcode)
	);
	assign hlt = (wb_opcode == 4'hf);
	assign if_hlt=(inst[15:12] == 4'hf);
	assign stop_pc = if_hlt & ~flush;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Forwardingunit
	
	Forwarding_unit fw (
	.EX_MEM_RegWrite(mem_wb_control[2]),
	.MEM_WB_RegWrite(wb_control[2]), 
	.EX_MEM_MemWrite(mem_control[0]), 
	.EX_MEM_Rd(mem_rd_addr), 
	.MEM_WB_Rd(wb_rd_addr), 
	.ID_EX_Rs(ex_rs_addr), 
	.ID_EX_Rt(ex_rt_addr), 
	.EX_MEM_Rt(mem_rt_addr),
	.ForwardA(ForwardA), .ForwardB(ForwardB), .ForwardM(ForwardM));

	//Hazard Unit
	hazard_detection hd (
	.ID_EX_MemRead(ex_mem_control[1]),
	.IF_ID_MemWrite(memwrite), 
	.ID_EX_RegisterRt(ex_rd_addr),
	.IF_ID_RegisterRs(regrdaddr1),
	.IF_ID_RegisterRt(regrdaddr2),
	.Enable_stall(Enable_stall)
	);
 
	// PC selection mux
	assign pc_next = (flush) ? pc_branch : pc_plus2;
	
    // verified
    PC U_PC(
        .clk(clk),
        .rst(rst),
        .hlt(stop_pc),
		.stall(combined_stall | fsm_busy),
        .pc_in(pc_next),
        .pc_out(pc)
        );

	//PCplus2 
	    ADDSUB U_ADDSUB_0(
        .a(pc),
        .b(16'h2),
        .sub(1'b0),
        .sum(pc_plus2),
        .ovfl()
        );

    // verified
    PC_control U_PC_control(
        .C(ctrlcode),
        .I(signeximm[8:0]),
        .F(flag),
        .opcode(inst_IF_ID[15:12]),
        .PC_BR_in(regout1),
		 .PC_plus2(pc),
	   .PC_out(pc_branch),
       .flush(flush)
        );

    // verified
    REGADDRGEN U_REGADDRGEN (
        .inst(inst_IF_ID),
        .regrdaddr1(regrdaddr1),
        .regrdaddr2(regrdaddr2),
        .regwraddr(regwraddr),
        .signeximm(signeximm),
        .ctrl(ctrlcode)
    );


    // verified
    RegisterFile U_RegisterFile(
        .clk(clk),  
        .rst(rst), 
        .SrcReg1(regrdaddr1), 
        .SrcReg2(regrdaddr2), 
        .DstReg(wb_rd_addr), 
        .WriteReg(wb_control[2]), 
        .DstData(regwrdata), 
        .SrcData1(regout1), 
        .SrcData2(regout2)
        );

    assign regwrdata = (wb_control[1:0] == 0) ? wb_alu_result : ((wb_control[1:0] == 1) ? wb_datamem : ((wb_control[1:0] == 2) ? pc_wb : 16'b0));
	
    // verified, except PC
    ALU U_ALU(
        .a(aluin1),
        .b(aluin2),
        .ctrl(aluctrl),
        .out(aluout),
        .ovfl(aluovfl)
        );
	// mux input from forwarding module output && ID/EX 
    assign aluin1 = (ForwardA[1])? mem_alu_result:( (ForwardA[0])? regwrdata:ex_rs_data);
    assign aluin2sel = ex_control[0] ? ex_imm : ex_rt_data;
    assign aluin2=( ~ex_control[0] & ForwardB[1])? mem_alu_result:( ( ~ex_control[0] & ForwardB[0])? regwrdata:aluin2sel);
	assign aluctrl = ex_control[4:1];
	wire [15:0] writedata ;//MEM to MEM forwarding
	assign writedata= (ForwardM)? regwrdata: mem_write_data;
	assign read_con= i_miss | d_miss | ((instaddr[15:12]==4'h9) ? 1'b1: 1'b0);
	
	
	//////////////////////////////D FSM///////////////////////////////////
	
	cache_fill_FSM D_FSM(.clk(clk), .rst(rst),.miss_detected(d_miss),.miss_address(d_addr_out),
	.fsm_busy(d_fsm_busy), .write_data_array(d_data_wr),.write_tag_array(d_tag_wr),
	.memory_address(d_mem_addr),.cache_address(d_cache_addr), .memory_data_valid(data_valid),
	.memory_enable(D_mem_en) );
	
	
	/*//////////////////////////////I-cache/////////////////////////////////////////////////
	
	cache i_cache(.clk(clk),.rst(rst),.data_in(mem_data_out),.addr_in(instaddr),.write_en(i_data_wr), 
	.write_tag_array(i_tag_wr), .write_data_array(i_data_wr),.read_con(read_con),.cache_address(i_cache_addr),
	.cache_en(1'b1),.data_out(inst),.addr_out(i_addr_out),.miss_detected(i_miss));
	
	///////////////////////////// D-cache////////////////////////////////////////////////////////
	
	assign d_data_in= (d_data_wr)? mem_data_out:writedata;
	
	cache d_cache(.clk(clk),.rst(rst),.data_in(d_data_in),.addr_in(mem_alu_result),
	.write_en( d_data_wr | mem_control[0]),.write_tag_array(d_tag_wr), .write_data_array(d_data_wr),
	.read_con(read_con),.cache_address(d_cache_addr),
	.cache_en(dataena_mem),.data_out(dataout),.addr_out(d_addr_out),.miss_detected(d_miss));
   */
	////////////////////////// Arbitration Module //////////////////////////////////////////////////
	
	Arbitration d_priority(.I_miss_in(i_miss), .I_miss_out(i_miss_out), .D_busy (d_fsm_busy),
	.D_write_tag(d_tag_wr));
	
	///////////////////////////////// I-FSM ///////////////////////////////////////////////////////////
	
	cache_fill_FSM I_FSM(.clk(clk), .rst(rst),.miss_detected(i_miss_out),.miss_address(i_addr_out),
	.fsm_busy(i_fsm_busy), .write_data_array(i_data_wr),.write_tag_array(i_tag_wr),
	.memory_address(i_mem_addr), .cache_address(i_cache_addr), .memory_data_valid(data_valid),
	.memory_enable(I_mem_en));
	
	/*////////////////////////// Multicycle memory///////////////////////////////////////////
	assign addr_for_mem = (mem_control[0] & dataena_mem & ~fsm_busy) ? mem_alu_result : (d_mem_addr|i_mem_addr);
	
	memory4c multicycle_mem(.data_out(mem_data_out), .data_in(writedata), .addr(
), 
	.enable(I_mem_en | D_mem_en | (dataena_mem&(~i_fsm_busy)&(~d_fsm_busy))), .wr(mem_control[0]&~fsm_busy), 
	.clk(clk), .rst(rst), .data_valid(data_valid));
	
	*/
	
   /*// copy from TA
    memory1cinst u_memory1c_inst(
        .data_out(inst), 
        .data_in(16'b0), 
        .addr(instaddr), 
        .enable(1'b1), 
        .wr(1'b0), 
        .clk(clk), 
        .rst(rst)
        );*/ 
    assign instaddr = pc;

    // copy from TA
    /*memory1cdata u_memory1c_data(
        .data_out(dataout), 
        .data_in(writedata), 
        .addr(mem_alu_result), 
        .enable(dataena_mem), 
        .wr(mem_control[0]), 
        .clk(clk), 
        .rst(rst)
        ); */
		

   // assign datain = regout2;
    //assign dataaddr = aluout;
	

   assign dataena = (ex_opcode== 4'h8) | (ex_opcode== 4'h9);
   
  //assign datawr = memwrite;


    // verified
    CONTROL U_CONTROL(
        .opcode(inst_IF_ID[15:12]),
        .regdst(regdst),
        .branch(branch),
        .memread(memread),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite_temp)
        );
	
	assign regwrite = (regwraddr == 4'b0000) ? 1'b0 : regwrite_temp;

    // verified
    FLAG U_FLAG(
        .clk(clk),
        .rst(rst),
        .opcode(ex_opcode),
        .aluout(aluout),
        .aluovfl(aluovfl),
        .flag(flag)
        );

endmodule
