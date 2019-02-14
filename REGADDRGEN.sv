module REGADDRGEN (
    input [15:0]inst,
    output [3:0]regrdaddr1,
    output [3:0]regrdaddr2,
    output [3:0]regwraddr,
    output [15:0]signeximm,
    output [2:0]ctrl
);
    
    reg [3:0]regrdaddr1_temp;
    reg [3:0]regrdaddr2_temp;
    reg [3:0]regwraddr_temp;
    reg [15:0]signeximm_temp;
    reg [2:0]ctrl_temp;

    // assign regwraddr = inst[11:8]; // this is ok
    // assign ctrl = inst[11:9]; // this is ok

    assign regrdaddr1 = regrdaddr1_temp;
    assign regrdaddr2 = regrdaddr2_temp;
    assign regwraddr = regwraddr_temp;
    assign signeximm = signeximm_temp;
    assign ctrl = ctrl_temp;

    always@(*) begin
        casex (inst[15:12])
            4'b0000: begin : add_0
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[3:0];
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b0001: begin : sub_1
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[3:0];
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b0010: begin : red_2
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[3:0];
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b0011: begin : xor_3
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[3:0];
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b0100: begin : sll_4
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = {{12{inst[3]}}, inst[3:0]};
                ctrl_temp = 3'h7;
            end
            4'b0101: begin : sra_5
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = {{12{inst[3]}}, inst[3:0]};
                ctrl_temp = 3'h7;
            end
            4'b0110: begin : ror_6
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = {{12{inst[3]}}, inst[3:0]};
                ctrl_temp = 3'h7;
            end
            4'b0111: begin : paddsb_7
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[3:0];
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b1000: begin : lw_8
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = {{11{inst[3]}}, inst[3:0], 1'b0};
                ctrl_temp = 3'h7;
            end
            4'b1001: begin : sw_9
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = inst[11:8];
                regwraddr_temp = 4'b0;
                signeximm_temp = {{11{inst[3]}}, inst[3:0], 1'b0};
                ctrl_temp = 3'h7;
            end
            4'b101x: begin : lhb_llb_10_11
                regrdaddr1_temp = inst[11:8];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = {{8{inst[7]}}, inst[7:0]};
                ctrl_temp = 3'h7;
            end
            4'b1100: begin : b_12
                regrdaddr1_temp = 4'b0;
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = 4'b0;
                signeximm_temp = {{7{inst[8]}}, inst[8:0]};
                ctrl_temp = inst[11:9];
            end
            4'b1101: begin : br_13
                regrdaddr1_temp = inst[7:4];
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = 4'b0;
                signeximm_temp = 16'b0;
                ctrl_temp = inst[11:9];
            end
            4'b1110: begin : pcs_14
                regrdaddr1_temp = 4'b0;
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = inst[11:8];
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            4'b1111: begin : hlt_15
                regrdaddr1_temp = 4'b0;
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = 4'b0;
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
            default : begin
                regrdaddr1_temp = 4'b0;
                regrdaddr2_temp = 4'b0;
                regwraddr_temp = 4'b0;
                signeximm_temp = 16'b0;
                ctrl_temp = 3'h7;
            end
        endcase
    end

endmodule