`timescale 1ns/1ns
module CONTROL_tb ();

    reg clk;
    reg rst;
    reg [3:0]stim;
    wire regdst;
    wire branch;
    wire memread;
    wire [1:0]memtoreg;
    wire [3:0]aluop;
    wire memwrite;
    wire alusrc;
    wire regwrite;

    CONTROL U_CONTROL(
        .opcode(stim),
        .regdst(regdst),
        .branch(branch),
        .memread(memread),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("CONTROL.fsdb");
            $fsdbDumpvars(0,"+all");
        end
    `endif

    // clk define
    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;

        #15;
        rst = 0;

        repeat(200) begin
            #20 stim = $random;
        end
        #10;
        $finish;
    end

endmodule