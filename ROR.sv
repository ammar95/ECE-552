module ROR (
    input [15:0]a,
    input [3:0]shift,
    output [15:0]out
);
    
	Shifter ror(out, a, shift, 2'b10); 
	
	
	
/*     reg [15:0]stage[3:0];

    always@(*) begin
        case(shift[3])
            1'b0: stage[0] = a;
            1'b1: stage[0] = {a[7:0],a[15:8]};
            default: stage[0] = a;
        endcase // shift
        case(shift[2])
            1'b0: stage[1] = stage[0];
            1'b1: stage[1] = {stage[0][3:0],stage[0][15:4]};
            default: stage[1] = stage[0];
        endcase // shift
        case(shift[1])
            1'b0: stage[2] = stage[1];
            1'b1: stage[2] = {stage[1][1:0],stage[1][15:2]};
            default: stage[2] = stage[1];
        endcase // shift
        case(shift[0])
            1'b0: stage[3] = stage[2];
            1'b1: stage[3] = {stage[2][0],stage[2][15:1]};
            default: stage[3] = stage[2];
        endcase // shift
    end

    assign out = stage[3]; */
    
endmodule