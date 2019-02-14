module hazard_detection (
input ID_EX_MemRead, 
input IF_ID_MemWrite, 
input [3:0] ID_EX_RegisterRt,
input [3:0] IF_ID_RegisterRs,
input [3:0] IF_ID_RegisterRt,
output Enable_stall
 );
 assign Enable_stall= (ID_EX_MemRead & (ID_EX_RegisterRt!=1'b0)
						& ((ID_EX_RegisterRt == IF_ID_RegisterRs) 
						| ((ID_EX_RegisterRt==IF_ID_RegisterRt) & (!IF_ID_MemWrite))));

			
endmodule