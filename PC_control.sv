
module PC_control(
    input [2:0]C, 
    input [8:0]I, 
    input [2:0]F, 
    input [3:0] opcode,  
    input [15:0]PC_BR_in, 
    input [15:0]PC_plus2,
	output flush,
	output [15:0]PC_out
    
);
    // F bit functions
    // bit 0 -> sign bit, bit 1 -> overflow, bit 2 -> zero
    wire Z;
    wire V;
    wire N;
    wire [15:0]PC_b;
    wire [15:0]PC_target;
    wire [15:0]I_ls1;
    wire [15:0]I_ls1_unsigned;

    reg [15:0]PC_new;

    assign PC_out = PC_new;
    
    assign Z = F[2];
    assign V = F[1];
    assign N = F[0];
    assign I_ls1_unsigned = I << 1;
    assign I_ls1 = {{6{I_ls1_unsigned[9]}},I_ls1_unsigned[9:0]};



    ADDSUB U_ADDSUB_1(
        .a(PC_plus2),
        .b(I_ls1),
        .sub(1'b0),
        .sum(PC_b),
        .ovfl()
        );

    assign PC_target = (opcode == 4'hc) ? PC_b : ((opcode == 4'hd) ? PC_BR_in : PC_plus2);

    always @(*) begin
        case (C)
            3'b000 : PC_new = (Z == 0) ? PC_target : PC_plus2;
            3'b001 : PC_new = (Z == 1) ? PC_target : PC_plus2;
            3'b010 : PC_new = (Z == 0 & N == 0) ? PC_target : PC_plus2;
            3'b011 : PC_new = (N == 1) ? PC_target : PC_plus2;
            3'b100 : PC_new = (Z == 1 | (Z == 0 & N == 0)) ? PC_target : PC_plus2;
            3'b101 : PC_new = (Z == 1 | N == 1) ? PC_target : PC_plus2;
            3'b110 : PC_new = (V == 1) ? PC_target : PC_plus2;
            3'b111 : PC_new = PC_target;
            default : PC_new = PC_plus2;
        endcase
    end
	
	assign flush = (PC_new != PC_plus2) ? 1'b1:1'b0;
endmodule