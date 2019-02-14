module PADDSB (
    input [15:0]a,
    input [15:0]b,
    output [15:0]sum
    );
    
    wire [3:0]c;
    wire [3:0]ovfl;
    wire [15:0]sum_temp;

    CLA4 U_CLA4_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(1'b0),
        .sum(sum_temp[3:0]),
        .cout(c[0]),
        .ovfl(ovfl[0]),
        .tg(),
        .tp()
        );
    // assign ovfl[0] = (b[3] ~^ a[3]) & (sum_temp[3] != a[3]);
    assign sum[3:0] = ovfl[0] ? (c[0] ? 4'h8 : 4'h7) : sum_temp[3:0];

    CLA4 U_CLA4_1(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(1'b0),
        .sum(sum_temp[7:4]),
        .cout(c[1]),
        .ovfl(ovfl[1]),
        .tg(),
        .tp()
        );
    // assign ovfl[1] = (b[7] ~^ a[7]) & (sum_temp[7] != a[7]);
    assign sum[7:4] = ovfl[1] ? (c[1] ? 4'h8 : 4'h7) : sum_temp[7:4];

    CLA4 U_CLA4_2(
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(1'b0),
        .sum(sum_temp[11:8]),
        .cout(c[2]),
        .ovfl(ovfl[2]),
        .tg(),
        .tp()
        );
    // assign ovfl[2] = (b[11] ~^ a[11]) & (sum_temp[11] != a[11]);
    assign sum[11:8] = ovfl[2] ? (c[2] ? 4'h8 : 4'h7) : sum_temp[11:8];

    CLA4 U_CLA4_3(
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(1'b0),
        .sum(sum_temp[15:12]),
        .cout(c[3]),
        .ovfl(ovfl[3]),
        .tg(),
        .tp()
        );
    // assign ovfl[3] = (b[15] ~^ a[15]) & (sum_temp[15] != a[15]);
    assign sum[15:12] = ovfl[3] ? (c[3] ? 4'h8 : 4'h7) : sum_temp[15:12];


endmodule