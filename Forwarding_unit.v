
module Forwarding_unit (EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_MemWrite, EX_MEM_Rd, MEM_WB_Rd, ID_EX_Rs, ID_EX_Rt,EX_MEM_Rt, ForwardA, ForwardB, ForwardM);
	input EX_MEM_RegWrite,MEM_WB_RegWrite, EX_MEM_MemWrite;
	input[3:0] EX_MEM_Rd, EX_MEM_Rt,MEM_WB_Rd, ID_EX_Rs, ID_EX_Rt;
	output[1:0]  ForwardA, ForwardB;
	output ForwardM;
	wire[1:0] tempA1,tempA2,tempB1,tempB2;
	assign tempA1 = (EX_MEM_RegWrite & ~(EX_MEM_Rd==0) & (EX_MEM_Rd==ID_EX_Rs)) ? 2'b10 : 2'b00;
	assign tempA2 = (MEM_WB_RegWrite & ~(MEM_WB_Rd==0) & ~(EX_MEM_RegWrite & ~(EX_MEM_Rd==0) & (EX_MEM_Rd==ID_EX_Rs)) & (MEM_WB_Rd==ID_EX_Rs)) ? 2'b01:2'b00;
	assign ForwardA=tempA1 | tempA2;
	assign ForwardB=tempB1 | tempB2;
	assign tempB1 = (EX_MEM_RegWrite & ~(EX_MEM_Rd==0) & (EX_MEM_Rd==ID_EX_Rt)) ? 2'b10 : 2'b00;
	assign tempB2 = (MEM_WB_RegWrite & ~(MEM_WB_Rd==0) & ~(EX_MEM_RegWrite & ~(EX_MEM_Rd==0) & (EX_MEM_Rd==ID_EX_Rt)) & (MEM_WB_Rd==ID_EX_Rt)) ? 2'b01:2'b00;
	assign ForwardM = (EX_MEM_MemWrite & MEM_WB_RegWrite & ~(MEM_WB_Rd==0) &(MEM_WB_Rd==EX_MEM_Rt)) ? 1'b1 : 1'b0;
	
	
endmodule