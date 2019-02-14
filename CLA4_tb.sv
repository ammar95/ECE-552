`timescale 1ns/1ns
module CLA4_tb ();

    reg [8:0]stim;
    wire [3:0]sum;
    wire cout;
    wire g;
    wire p;

    CLA4 U_CLA4(
        .a(stim[3:0]),
        .b(stim[7:4]),
        .cin(stim[8]),
        .sum(sum),
        .cout(cout),
        .tg(g),
        .tp(p)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("CLA4.fsdb");
            $fsdbDumpvars(0,"+all");
        end
    `endif

    initial begin
        stim = 0;
        repeat(100) begin
            #20 stim = $random;
        end
        #10;
        $finish;
    end

endmodule