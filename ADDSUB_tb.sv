`timescale 1ns/1ns
module ADDSUB_tb ();

    reg [31:0]stim;
    reg stim2;
    wire [15:0]sum;
    wire ovfl;

    ADDSUB U_ADDSUB(
        .a(stim[15:0]),
        .b(stim[31:16]),
        .sub(stim2),
        .sum(sum),
        .ovfl(ovfl)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("ADDSUB.fsdb");
            $fsdbDumpvars(0,"+all");
        end
    `endif

    initial begin
        stim = 0;
        repeat(100) begin
            #20 stim = $random;
            stim2 = $random;
        end
        #10;
        $finish;
    end

endmodule