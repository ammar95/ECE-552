module cache_tb();

logic [15:0] data_in,addr_in,data_out, addr_out;
logic clk,rst,write_en, miss_detected;

cache check (clk,rst,data_in,addr_in,write_en, data_out,addr_out,miss_detected);

initial begin
clk=0;
rst=1;
#5 rst=1;
data_in=16'hz;
addr_in=16'h1234;
write_en=1'b0;
#20;
data_in=16'b1000;
addr_in=16'2345;
write_en=1'b1;

#20;

end
always #5 clk=~clk;
endmodule