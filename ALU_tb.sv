`timescale 1ns/1ns
module ALU_tb ();

    reg [31:0]stim;
    reg [3:0]stim2;
    wire [15:0]sum;
    wire ovfl;

    ALU U_ALU(
        .a(stim[31:16]),
        .b(stim[15:0]),
        .ctrl(stim2),
        .out(sum),
        .ovfl(ovfl)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("ALU.fsdb");
            $fsdbDumpvars(0,"+all");
        end
    `endif

    initial begin
        stim = 0;
        stim2 = 0;
        repeat(200) begin
            #20 stim = $random;
            stim2 = $random;
        end
        #10;
        $finish;
    end

endmodule