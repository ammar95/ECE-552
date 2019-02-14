`timescale 1ns/1ns
module PADDSB_tb ();

    reg [31:0]stim;
    wire [15:0]sum;

    PADDSB U_PADDSB(
        .a(stim[15:0]),
        .b(stim[31:16]),
        .sum(sum)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("PADDSB.fsdb");
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