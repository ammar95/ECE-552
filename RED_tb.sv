`timescale 1ns/1ns
module RED_tb ();

    reg [31:0]stim;
    wire [15:0]sum;

    wire [15:0]sumRef;
    RedUnit U_RED(
        .A(stim[15:0]),
        .B(stim[31:16]),
        .RedResult(sum)
        );

    // `ifdef DUMPFSDB
    //     initial begin
    //         $fsdbDumpfile("RED.fsdb");
    //         $fsdbDumpvars(0,"+all");
    //     end
    // `endif


    // assign sum[9:0] = a[7:0] + a[15:8] + b[7:0] + b[15:8];
    // assign sum[15:10] = {6{sum[9]}};

    wire testCorrect;
    wire [15:0]a_low;
    wire [15:0]a_high;
    wire [15:0]b_low;
    wire [15:0]b_high;

    assign a_low  = {{8{stim[7]}},stim[7:0]};
    assign a_high = {{8{stim[15]}},stim[15:8]};
    assign b_low  = {{8{stim[23]}},stim[23:16]};
    assign b_high = {{8{stim[31]}},stim[31:24]};

    assign testCorrect = (sum == sumRef);
    assign sumRef = a_low + a_high + b_low + b_high;

    initial begin
        stim = 0;
        repeat(10) begin
            #20 stim = $random;
        end
        // #20 stim = 32'hFFFFFFFF;
        // #20 stim = 32'hF1F2F1F0;
        // #20 stim = 32'hFDFCFBFA;
        // #20 stim = 32'hFD04FB06;
        // #20 stim = 32'hFD0405FA;
        // #20 stim = 32'h03FC05FA;
        // #20 stim = 32'h03FCFB06;
        // -3 -4 -5 -6
        // FD FC FB FA
        #10;
        $finish;
    end

endmodule