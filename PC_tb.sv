`timescale 1ns/1ns
module PC_tb ();

    reg clk;
    reg rst;
    reg [16:0]stim;
    wire [15:0]out;

    PC U_PC(
        .clk(clk),
        .rst(rst),
        .hlt(stim[16]),
        .pc_in(stim[15:0]),
        .pc_out(out)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("PC.fsdb");
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