`timescale 1ns/1ns
module FLAG_tb ();

    reg clk;
    reg rst;
    reg [5:0]stim;
    wire [2:0]out;

    FLAG U_FLAG(
        .clk(clk),
        .rst(rst),
        .opcode(stim[3:0]),
        .aluout({16{stim[4]}}),
        .aluovfl(stim[5]),
        .flag(out)
        );

    `ifdef DUMPFSDB
        initial begin
            $fsdbDumpfile("FLAG.fsdb");
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