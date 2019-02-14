`timescale 1ns/1ns
module REGADDRGEN_tb ();

    reg clk;
    reg rst;
    reg [15:0]stim;
    wire [3:0]regrdaddr1;
    wire [3:0]regrdaddr2;
    wire [3:0]regwraddr;
    wire [15:0]signeximm;
    wire [2:0]ctrl;

    REGADDRGEN U_REGADDRGEN(
        .inst(stim),
        .regrdaddr1(regrdaddr1),
        .regrdaddr2(regrdaddr2),
        .regwraddr(regwraddr),
        .signeximm(signeximm),
        .ctrl(ctrl)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("REGADDRGEN.fsdb");
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