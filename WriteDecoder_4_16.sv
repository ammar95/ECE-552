module WriteDecoder_4_16 (
    input [3:0] RegId, 
    input WriteReg, 
    output [15:0] Wordline
);

    assign Wordline[0] = ~(RegId[3] | RegId[2] | RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[1] = ~(RegId[3] | RegId[2] | RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[2] = ~(RegId[3] | RegId[2] | ~RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[3] = ~(RegId[3] | RegId[2] | ~RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[4] = ~(RegId[3] | ~RegId[2] | RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[5] = ~(RegId[3] | ~RegId[2] | RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[6] = ~(RegId[3] | ~RegId[2] | ~RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[7] = ~(RegId[3] | ~RegId[2] | ~RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[8] = ~(~RegId[3] | RegId[2] | RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[9] = ~(~RegId[3] | RegId[2] | RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[10] = ~(~RegId[3] | RegId[2] | ~RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[11] = ~(~RegId[3] | RegId[2] | ~RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[12] = ~(~RegId[3] | ~RegId[2] | RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[13] = ~(~RegId[3] | ~RegId[2] | RegId[1] | ~RegId[0]) & WriteReg;
    assign Wordline[14] = ~(~RegId[3] | ~RegId[2] | ~RegId[1] | RegId[0]) & WriteReg;
    assign Wordline[15] = ~(~RegId[3] | ~RegId[2] | ~RegId[1] | ~RegId[0]) & WriteReg;

endmodule
