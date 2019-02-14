module ALU (
    input [15:0]a,
    input [15:0]b,
    input [3:0]ctrl,
    output [15:0]out,
    output ovfl
);
    wire ovfl_temp;
    reg [15:0]out_temp;
    wire sub;
    wire [15:0]out_addsub;
    wire [15:0]out_paddsb;
    wire [15:0]out_xor;
    wire [15:0]out_sll;
    wire [15:0]out_sra;
    wire [15:0]out_ror;
    wire [15:0]out_red;
    wire [15:0]out_llb;
    wire [15:0]out_lhb;

    assign out = out_temp;
    assign sub = (ctrl == 4'h1) ? 1'b1 : 1'b0;

    always@(*) begin
        case (ctrl)
            4'h0: out_temp = out_addsub;
            4'h1: out_temp = out_addsub;
            4'h2: out_temp = out_red;
            4'h3: out_temp = out_xor;
            4'h4: out_temp = out_sll;
            4'h5: out_temp = out_sra;
            4'h6: out_temp = out_ror;
            4'h7: out_temp = out_paddsb;
            4'h8: out_temp = out_lhb;
            4'h9: out_temp = out_llb;
            default : out_temp = 16'b0;
        endcase
    end

    ADDSUB U_ADDSUB(
        .a(a),
        .b(b),
        .sub(sub),
        .sum(out_addsub),
        .ovfl(ovfl_temp)
        );

    PADDSB U_PADDSB(
        .a(a),
        .b(b),
        .sum(out_paddsb)
        );

    RED U_RED(
        .a(a),
        .b(b),
        .sum(out_red)
        );

    XOR U_XOR(
        .a(a),
        .b(b),
        .out(out_xor)
        );

    SLL U_SLL(
        .a(a),
        .shift(b[3:0]),
        .out(out_sll)
        );

    SRA U_SRA(
        .a(a),
        .shift(b[3:0]),
        .out(out_sra)
        );

    ROR U_ROR(
        .a(a),
        .shift(b[3:0]),
        .out(out_ror)
        );

    assign out_llb = {a[15:8], b[7:0]};
    assign out_lhb = {b[7:0], a[7:0]};
    assign ovfl = (ctrl == 0 | ctrl == 1) & ovfl_temp;
    
endmodule