module CONTROL (
    input [3:0]opcode,
    output regdst, // always 1'b0
    output branch,
    output memread,
    output [1:0]memtoreg,
    output [3:0]aluop,
    output memwrite,
    output alusrc,
    output regwrite
);

    reg [9:0]dec;

    assign branch = (opcode == 4'hc) | (opcode == 4'hd); //0 no branch, 1 branch

    assign regdst = 1'b0;//0 write destination come from first oprand, 1 from second operand (rd).
    assign memread = dec[9];//0 no read. 1 read
    assign memtoreg = dec[8:7];//0 value to be written to reg from alu, 1 from mem, 2 from pc
    assign aluop = dec[6:3];//10 different operations (llb, lhb)
    assign memwrite = dec[2];//0 no write, 1 write
    assign alusrc = dec[1];//0 from reg. 1 from sign-extended imm
    assign regwrite = dec[0];//0 no write, 1 wirte

    // always@(*) begin
    //     case (opcode)
    //         4'h0: dec = 10'b0000000001;//add
    //         4'h1: dec = 10'b0000001001;//sub
    //         4'h2: dec = 10'b0000010001;//red
    //         4'h3: dec = 10'b0000011001;//xor
    //         4'h4: dec = 10'b0000100011;//sll
    //         4'h5: dec = 10'b0000101011;//sra
    //         4'h6: dec = 10'b0000110011;//ror
    //         4'h7: dec = 10'b0000111001;//paddsb
    //         4'h8: dec = 10'b1010000011;//lw
    //         4'h9: dec = 10'b0000000110;//sw
    //         4'ha: dec = 10'b0001000011;//lhb
    //         4'hb: dec = 10'b0001001011;//llb
    //         4'hc: dec = 10'b0000000000;//b
    //         4'hd: dec = 10'b0000000000;//br
    //         4'he: dec = 10'b0100000001;//pcs
    //         4'hf: dec = 10'b0000000000;//hlt
    //         default : dec = 10'b0000000000;
    //     endcase
    // end


    always@(*) begin
        case (opcode)
            4'h0: dec = 10'b0000000001;//add
            4'h1: dec = 10'b0000001001;//sub
            4'h2: dec = 10'b0000011001;//xor
            4'h3: dec = 10'b0000010001;//red
            4'h4: dec = 10'b0000100011;//sll
            4'h5: dec = 10'b0000101011;//sra
            4'h6: dec = 10'b0000110011;//ror
            4'h7: dec = 10'b0000111001;//paddsb
            4'h8: dec = 10'b1010000011;//lw
            4'h9: dec = 10'b0000000110;//sw
            4'ha: dec = 10'b0001001011;//llb
            4'hb: dec = 10'b0001000011;//lhb
            4'hc: dec = 10'b0000000000;//b
            4'hd: dec = 10'b0000000000;//br
            4'he: dec = 10'b0100000001;//pcs
            4'hf: dec = 10'b0000000000;//hlt
            default : dec = 10'b0000000000;
        endcase
    end

endmodule