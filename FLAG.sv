module FLAG (
    input clk,    // Clock
    input rst,  // Asynchronous reset active low
    input [3:0]opcode,
    input [15:0]aluout,
    input aluovfl,
    output [2:0]flag // z, v, n
);

    wire zeroflag;
	reg n_en,ovfl_en,zeroflag_en;

    assign zeroflag = (aluout == 16'b0) ? 1'b1 : 1'b0;

    dff flag0(.q(flag[0]), .d(aluout[15]), .wen(n_en), .clk(clk), .rst(rst));
    dff flag1(.q(flag[1]), .d(aluovfl), .wen(ovfl_en), .clk(clk), .rst(rst));
    dff flag2(.q(flag[2]), .d(zeroflag), .wen(zeroflag_en), .clk(clk), .rst(rst));
	
	always @(*) begin
		case (opcode)
			4'h0: zeroflag_en = 1'b1;
			4'h1: zeroflag_en = 1'b1;
			4'h3: zeroflag_en = 1'b1;
			4'h4: zeroflag_en = 1'b1;
			4'h5: zeroflag_en = 1'b1;
			4'h6: zeroflag_en = 1'b1;
			default : zeroflag_en = 1'b0;
		endcase
	end
	
	always @(*) begin
		case (opcode)
			4'h0: ovfl_en = 1'b1;
			4'h1: ovfl_en = 1'b1;
			default : ovfl_en = 1'b0;
		endcase
	end
	
	always @(*) begin
		case (opcode)
			4'h0: n_en = 1'b1;
			4'h1: n_en = 1'b1;
			default : n_en = 1'b0;
		endcase
	end
	
/*     always @(posedge clk or posedge rst) begin : proc_
        if(rst) begin
            flagreg <= 0;
        end else begin
            case (opcode)
                4'h0: flagreg[2] = zeroflag;
                4'h1: flagreg[2] = zeroflag;
                4'h3: flagreg[2] = zeroflag;
                4'h4: flagreg[2] = zeroflag;
                4'h5: flagreg[2] = zeroflag;
                4'h6: flagreg[2] = zeroflag;
                default : flagreg[2] = flagreg[2];
            endcase
            case (opcode)
                4'h0: flagreg[1] = aluovfl;
                4'h1: flagreg[1] = aluovfl;
                default : flagreg[1] = flagreg[1];
            endcase
            case (opcode)
                4'h0: flagreg[0] = aluout[15];
                4'h1: flagreg[0] = aluout[15];
                default : flagreg[0] = flagreg[0];
            endcase
            end
    end */

endmodule