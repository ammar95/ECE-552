module RegisterFile (
    input clk, 
    input rst, 
    input [3:0] SrcReg1, 
    input [3:0] SrcReg2, 
    input [3:0] DstReg, 
    input WriteReg, 
    input [15:0] DstData, 
    inout [15:0] SrcData1, 
    inout [15:0] SrcData2
);
    
    wire [15:0]ReadWordline1;
    wire [15:0]ReadWordline2;
    wire [15:0]WriteWordline;
    wire [15:0]Bitline1[15:0];
    wire [15:0]Bitline2[15:0];
    wire [15:0]BitlineAll1;
    wire [15:0]BitlineAll2;
	wire [15:0]temp_out1;
	wire [15:0]temp_out2;
    wire [1:0]zeroAddr;

    assign zeroAddr[0] = (SrcReg1 == 4'b0);
    assign zeroAddr[1] = (SrcReg2 == 4'b0);
    assign BitlineAll1 = Bitline1[0]|Bitline1[1]|Bitline1[2]|Bitline1[3]|Bitline1[4]|Bitline1[5]|Bitline1[6]|Bitline1[7]|Bitline1[8]|Bitline1[9]|Bitline1[10]|Bitline1[11]|Bitline1[12]|Bitline1[13]|Bitline1[14]|Bitline1[15];
    assign BitlineAll2 = Bitline2[0]|Bitline2[1]|Bitline2[2]|Bitline2[3]|Bitline2[4]|Bitline2[5]|Bitline2[6]|Bitline2[7]|Bitline2[8]|Bitline2[9]|Bitline2[10]|Bitline2[11]|Bitline2[12]|Bitline2[13]|Bitline2[14]|Bitline2[15];

    // no bypass logic
    assign temp_out1 = zeroAddr[0] ? 16'b0 : BitlineAll1;
    assign temp_out2 = zeroAddr[1] ? 16'b0 : BitlineAll2;
	
	// With bypass logic
	assign SrcData1 = (DstReg == SrcReg1)? ((WriteReg == 1'b1)? ((rst == 1'b0) ? DstData : temp_out1):temp_out1 ):temp_out1;
	assign SrcData2 = (DstReg == SrcReg2)? ((WriteReg == 1'b1)? ((rst == 1'b0) ? DstData : temp_out2):temp_out2 ):temp_out2;

    ReadDecoder_4_16 U_ReadDecoder_4_16_src1(
        .RegId(SrcReg1),
        .Wordline(ReadWordline1)
        );

    ReadDecoder_4_16 U_ReadDecoder_4_16_src2(
        .RegId(SrcReg2),
        .Wordline(ReadWordline2)
        );

    WriteDecoder_4_16 U_WriteDecoder_4_16(
        .RegId(DstReg),
        .WriteReg(WriteReg),
        .Wordline(WriteWordline)
        );

    Register U_Register0(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[0]),
        .ReadEnable1(ReadWordline1[0]), 
        .ReadEnable2(ReadWordline2[0]), 
        .Bitline1(Bitline1[0]), 
        .Bitline2(Bitline2[0])
        );
    Register U_Register1(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[1]),
        .ReadEnable1(ReadWordline1[1]), 
        .ReadEnable2(ReadWordline2[1]), 
        .Bitline1(Bitline1[1]), 
        .Bitline2(Bitline2[1])
        );
    Register U_Register2(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[2]),
        .ReadEnable1(ReadWordline1[2]), 
        .ReadEnable2(ReadWordline2[2]), 
        .Bitline1(Bitline1[2]), 
        .Bitline2(Bitline2[2])
        );
    Register U_Register3(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[3]),
        .ReadEnable1(ReadWordline1[3]), 
        .ReadEnable2(ReadWordline2[3]), 
        .Bitline1(Bitline1[3]), 
        .Bitline2(Bitline2[3])
        );
    Register U_Register4(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[4]),
        .ReadEnable1(ReadWordline1[4]), 
        .ReadEnable2(ReadWordline2[4]), 
        .Bitline1(Bitline1[4]), 
        .Bitline2(Bitline2[4])
        );
    Register U_Register5(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[5]),
        .ReadEnable1(ReadWordline1[5]), 
        .ReadEnable2(ReadWordline2[5]), 
        .Bitline1(Bitline1[5]), 
        .Bitline2(Bitline2[5])
        );
    Register U_Register6(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[6]),
        .ReadEnable1(ReadWordline1[6]), 
        .ReadEnable2(ReadWordline2[6]), 
        .Bitline1(Bitline1[6]), 
        .Bitline2(Bitline2[6])
        );
    Register U_Register7(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[7]),
        .ReadEnable1(ReadWordline1[7]), 
        .ReadEnable2(ReadWordline2[7]), 
        .Bitline1(Bitline1[7]), 
        .Bitline2(Bitline2[7])
        );
    Register U_Register8(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[8]),
        .ReadEnable1(ReadWordline1[8]), 
        .ReadEnable2(ReadWordline2[8]), 
        .Bitline1(Bitline1[8]), 
        .Bitline2(Bitline2[8])
        );
    Register U_Register9(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[9]),
        .ReadEnable1(ReadWordline1[9]), 
        .ReadEnable2(ReadWordline2[9]), 
        .Bitline1(Bitline1[9]), 
        .Bitline2(Bitline2[9])
        );
    Register U_Register10(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[10]),
        .ReadEnable1(ReadWordline1[10]), 
        .ReadEnable2(ReadWordline2[10]), 
        .Bitline1(Bitline1[10]), 
        .Bitline2(Bitline2[10])
        );
    Register U_Register11(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[11]),
        .ReadEnable1(ReadWordline1[11]), 
        .ReadEnable2(ReadWordline2[11]), 
        .Bitline1(Bitline1[11]), 
        .Bitline2(Bitline2[11])
        );
    Register U_Register12(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[12]),
        .ReadEnable1(ReadWordline1[12]), 
        .ReadEnable2(ReadWordline2[12]), 
        .Bitline1(Bitline1[12]), 
        .Bitline2(Bitline2[12])
        );
    Register U_Register13(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[13]),
        .ReadEnable1(ReadWordline1[13]), 
        .ReadEnable2(ReadWordline2[13]), 
        .Bitline1(Bitline1[13]), 
        .Bitline2(Bitline2[13])
        );
    Register U_Register14(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[14]),
        .ReadEnable1(ReadWordline1[14]), 
        .ReadEnable2(ReadWordline2[14]), 
        .Bitline1(Bitline1[14]), 
        .Bitline2(Bitline2[14])
        );
    Register U_Register15(
        .clk(clk),  
        .rst(rst), 
        .D(DstData), 
        .WriteReg(WriteWordline[15]),
        .ReadEnable1(ReadWordline1[15]), 
        .ReadEnable2(ReadWordline2[15]), 
        .Bitline1(Bitline1[15]), 
        .Bitline2(Bitline2[15])
        );

endmodule