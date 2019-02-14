module Shifter (Shift_Out, Shift_In, Shift_Val, Mode); 
input [15:0] Shift_In;  // This is the input data to perform shift operation on 
input [3:0] Shift_Val;  // Shift amount (used to shift the input data) 
input  [1:0] Mode;   // To indicate 00=SLL 01=SRA 10=ROR
output [15:0] Shift_Out;  // Shifted output data
wire [15:0] temp0, temp1, temp2;

assign temp0 = (Mode[1]) ? (Shift_Val[3] ? {Shift_In[7:0],Shift_In[15:8]} : Shift_In[15:0])
							:(Mode[0] ? (Shift_Val[3] ? {{8{Shift_In[15]}}, Shift_In[15:8]} : Shift_In[15:0]) : 
								(Shift_Val[3] ? {Shift_In[7:0], 8'h00} : Shift_In[15:0]));
assign temp1 = (Mode[1]) ? (Shift_Val[2] ? {temp0[3:0],temp0[15:4]} : temp0[15:0])
							:(Mode[0] ? (Shift_Val[2] ? {{4{temp0[15]}}, temp0[15:4]} : temp0[15:0]) : 
								(Shift_Val[2] ? {temp0[11:0], 4'h0} : temp0[15:0]));
assign temp2 = (Mode[1]) ? (Shift_Val[1] ? {temp1[1:0],temp1[15:2]} : temp1[15:0])
							:(Mode[0] ? (Shift_Val[1] ? {{2{temp1[15]}}, temp1[15:2]} : temp1[15:0]) : 
								(Shift_Val[1] ? {temp1[13:0], 2'h0} : temp1[15:0]));
assign Shift_Out = (Mode[1]) ? (Shift_Val[0] ? {temp2[0],temp2[15:1]} : temp2[15:0])
							:(Mode[0] ? (Shift_Val[0] ? {{1{temp2[15]}}, temp2[15:1]} : temp2[15:0]) : 
								(Shift_Val[0] ? {temp2[14:0], 1'h0} : temp2[15:0]));

endmodule
