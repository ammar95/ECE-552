module BitCell (
    input clk,  
    input rst, 
    input D, 
    input WriteEnable, 
    input ReadEnable1, 
    input ReadEnable2, 
    inout Bitline1, 
    inout Bitline2
);
    
    wire q;    

    dff U_dff0(.q(q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));

    // use 1'b0 for disabled output for simulating tri-state gate
    assign Bitline1 = ReadEnable1 ? q : 1'b0;
    assign Bitline2 = ReadEnable2 ? q : 1'b0;

endmodule