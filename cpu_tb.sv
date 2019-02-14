module cpu_tb();
  

   wire [15:0] PC;
   wire [15:0] Inst;           /* This should be the 15 bits of the FF that
                                  stores instructions fetched from instruction memory
                               */
   wire        RegWrite;       /* Whether register file is being written to */
   wire [3:0]  WriteRegister;  /* What register is written */
   wire [15:0] WriteData;      /* Data */
   wire        MemWrite;       /* Similar as above but for memory */
   wire        MemRead;
   wire [15:0] MemAddress;
   wire [15:0] MemData;

   wire        Halt;         /* Halt executed and in Memory or writeback stage */
        
   integer     inst_count;
   integer     cycle_count;

   integer     trace_file;
   integer     sim_log_file;

   reg clk; /* Clock input */
   reg rst_n; /* (Active low) Reset input */

   reg [3:0] sat0, sat1, sat2, sat3;
   reg [3:0] itr0, itr1, itr2, itr3;
     

   cpu DUT(.clk(clk), .rst_n(rst_n), .pc(PC), .hlt(Halt)); /* Instantiate your processor */
   






   /* Setup */
   initial begin
      $display("Hello world...simulation starting");
      $display("See verilogsim.log and verilogsim.trace for output");
      inst_count = 0;
      trace_file = $fopen("verilogsim.trace");
      sim_log_file = $fopen("verilogsim.log");
      
   end





  /* Clock and Reset */
// Clock period is 100 time units, and reset length
// to 201 time units (two rising edges of clock).

   initial begin
      $dumpvars;
      cycle_count = 0;
      rst_n = 0; /* Intial reset state */
      clk = 1;
      #201 rst_n = 1; // delay until slightly after two clock periods
    end

    always #50 begin   // delay 1/2 clock period each time thru loop
      clk = ~clk;
    end
  
    always @(posedge clk) begin
      cycle_count = cycle_count + 1;
      if (cycle_count > 100000) begin
        $display("hmm....more than 100000 cycles of simulation...error?\n");
        $finish;
      end
    end

    // always @(posedge clk) begin
    //   // ADDD
    //   if (Inst[15:12] === 4'b0000) begin
    //     if ((DUT.regwrdata !== (DUT.aluin1 + DUT.aluin2)) && ~DUT.aluovfl) begin
    //       $display("Error: ADD",);
    //       $display("%x + %x != %x", DUT.aluin1, DUT.aluin2, DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // SUB
    //   else if (Inst[15:12] === 4'b0001) begin
    //     if ((DUT.regwrdata !== (DUT.aluin1 - DUT.aluin2)) && ~DUT.aluovfl) begin
    //       $display("Error: SUB",);
    //       $stop();
    //     end
    //   end
    //   // RED
    //   else if (Inst[15:12] === 4'b0010) begin
    //     if (DUT.regwrdata !== (((DUT.aluin1[15:12] + DUT.aluin2[15:12]) + 
    //                         (DUT.aluin1[11:8] + DUT.aluin2[11:8])) + 
    //                         ((DUT.aluin1[7:4] + DUT.aluin2[7:4]) + 
    //                         (DUT.aluin1[3:0] + DUT.aluin2[3:0])))) begin
    //       $display("Error: RED",);
    //       $stop();
    //     end
    //   end
    //   // XOR
    //   else if (Inst[15:12] === 4'b0011) begin
    //     if (DUT.regwrdata !== (DUT.aluin1 ^ DUT.aluin2)) begin
    //       $display("Error: XOR",);
    //       $display("%x ^ %x != %x", DUT.aluin1, DUT.aluin2, DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // SLL
    //   else if (Inst[15:12] === 4'b0100) begin
    //     if (DUT.regwrdata !== (DUT.aluin1 << Inst[3:0])) begin
    //       $display("Error: SLL",);
    //       $stop();
    //     end
    //   end
    //   // SRA
    //   else if (Inst[15:12] === 4'b0101) begin
    //     if ($signed(DUT.regwrdata) !== ($signed(DUT.aluin1) >>> Inst[3:0])) begin
    //       $display("Error: SRA",);
    //       $display("%x >>> %x != %x", DUT.aluin1, Inst[3:0], DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // ROR
    //   else if (Inst[15:12] === 4'b0110) begin
    //     if (DUT.regwrdata !== ((DUT.aluin1 >> Inst[3:0]) | DUT.aluin1 << (16 - Inst[3:0]))) begin
    //       $display("Error: ROR",);
    //       $display("%x ROR %x != %x", DUT.aluin1, Inst[3:0], DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // PADDSB
    //   else if (Inst[15:12] === 4'b0111) begin
    //     itr3 = (DUT.aluin1[15:12] + DUT.aluin2[15:12]);
    //     itr2 = (DUT.aluin1[11:8] + DUT.aluin2[11:8]);
    //     itr1 = (DUT.aluin1[7:4] + DUT.aluin2[7:4]);
    //     itr0 = (DUT.aluin1[3:0] + DUT.aluin2[3:0]);
    //     sat3 = DUT.aluin1[15] & DUT.aluin2[15] & ~itr3[3]   ? 4'h8 : 
    //            ~DUT.aluin1[15] & ~DUT.aluin2[15] & itr3[3]  ? 4'h7 :
    //                                                           itr3;
    //     sat2 = DUT.aluin1[11] & DUT.aluin2[11] & ~itr3[3]   ? 4'h8 :
    //            ~DUT.aluin1[11] & ~DUT.aluin2[11] & itr3[3]  ? 4'h7 :
    //                                                           itr2;
    //     sat1 = DUT.aluin1[7] & DUT.aluin2[7] & ~itr3[3]   ? 4'h8 :
    //            ~DUT.aluin1[7] & ~DUT.aluin2[7] & itr3[3]  ? 4'h7 :
    //                                                         itr1;
    //     sat0 = DUT.aluin1[3] & DUT.aluin2[3] & ~itr3[3]   ? 4'h8 :
    //            ~DUT.aluin1[3] & ~DUT.aluin2[3] & itr3[3]  ? 4'h7 :
    //                                                         itr0;

    //     if (DUT.regwrdata !== {sat3, sat2, sat1, sat0}) begin
    //       $display("Error: PADDSB",);
    //       $stop();
    //     end
    //   end
    //   // LW & SW - only check if calculated addr is correct
    //   else if (Inst[15:12] === 4'b1000 || Inst[15:12] === 4'b1001) begin
    //     if (DUT.u_memory1c_data.addr !== (DUT.aluin1 & 16'hFFFE) + ({{12{Inst[3]}}, Inst[3:0]} << 1)) begin
    //       $display("Error: LW or SW",);
    //       $display("Expected lw/sw address: %x", (DUT.aluin1 & 16'hFFFE) + ({{12{Inst[3]}}, Inst[3:0]} << 1));
    //       $display("Actual lw/sw address: %x", DUT.u_memory1c_data.addr);
    //       $stop();
    //     end
    //   end
    //    // LHB
    //   else if (Inst[15:12] === 4'b1010) begin
    //     if (DUT.regwrdata !== ((DUT.aluin1 & 16'h00FF) | (Inst[7:0] << 8))) begin
    //       $display("Error: LHB",);
    //       $display("%x LHB %x != %x", DUT.aluin1, Inst[7:0], DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // LLB
    //   else if (Inst[15:12] === 4'b1011) begin
    //     if (DUT.regwrdata !== ((DUT.aluin1 & 16'hFF00) | Inst[7:0])) begin
    //       $display("Error: LLB",);
    //       $display("%x LLB %x != %x", DUT.aluin1, Inst[7:0], DUT.regwrdata);
    //       $stop();
    //     end
    //   end
    //   // BR
    //   else if (Inst[15:12] === 4'b1101) begin
    //     if ((Inst[11:9] === 3'b000 & (DUT.U_FLAG.flag[2] == 0)) ||
    //         (Inst[11:9] === 3'b001 & (DUT.U_FLAG.flag[2] == 1)) ||
    //         (Inst[11:9] === 3'b010 & (DUT.U_FLAG.flag[2] == 0 & DUT.U_FLAG.flag[0] == 0)) ||
    //         (Inst[11:9] === 3'b011 & (DUT.U_FLAG.flag[0] == 1)) ||
    //         (Inst[11:9] === 3'b100 & (DUT.U_FLAG.flag[2] == 1 | (DUT.U_FLAG.flag[2] == 0 & DUT.U_FLAG.flag[0] == 0))) ||
    //         (Inst[11:9] === 3'b101 & (DUT.U_FLAG.flag[2] == 1 | DUT.U_FLAG.flag[0] == 1)) ||
    //         (Inst[11:9] === 3'b110 & (DUT.U_FLAG.flag[1] == 1)) ||
    //         (Inst[11:9] === 3'b111)) begin
    //       if (DUT.pc_next !== DUT.aluin1) begin
    //         $display("Error: BR",);
    //         $display("Expected target address: %x", DUT.aluin1);
    //         $display("Actual target address: %x", DUT.pc_next);
    //         $stop();
    //       end
    //     end
    //     else begin
    //       if (DUT.pc_next !== PC + 2) begin
    //         $display("Error: BR",);
    //         $display("Expected next address: %x", PC + 2);
    //         $display("Actual next address: %x", DUT.pc_next);
    //         $stop();
    //       end
    //     end 
    //   end
      
    // end


  `ifdef DUMPFSDB
    initial begin
        $fsdbDumpfile("cpu.fsdb");
        $fsdbDumpvars(0,"+all");
    end
  `endif




  /* Stats */
   always @ (posedge clk) begin
      if (rst_n) begin
         if (Halt || RegWrite || MemWrite) begin
            inst_count = inst_count + 1;
         end
         $fdisplay(sim_log_file, "SIMLOG:: Cycle %d PC: %8x I: %8x R: %d %3d %8x M: %d %d %8x %8x",
                  cycle_count,
                  PC,
                  Inst,
                  RegWrite,
                  WriteRegister,
                  WriteData,
                  MemRead,
                  MemWrite,
                  MemAddress,
                  MemData);
         if (RegWrite) begin
            if (MemRead) begin
               // ld
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress);
            end else begin
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );
            end
         end else if (Halt) begin
            $fdisplay(sim_log_file, "SIMLOG:: Processor halted\n");
            $fdisplay(sim_log_file, "SIMLOG:: sim_cycles %d\n", cycle_count);
            $fdisplay(sim_log_file, "SIMLOG:: inst_count %d\n", inst_count);
            $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                      (inst_count-1),
                      PC );

            $fclose(trace_file);
            $fclose(sim_log_file);
            
            $finish;
         end else begin
            if (MemWrite) begin
               // st
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData);
            end else begin
               // conditional branch or NOP
               // Need better checking in pipelined testbench
               inst_count = inst_count + 1;
               $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                         (inst_count-1),
                         PC );
            end
         end 
      end
      
   end


   /* Assign internal signals to top level wires
      The internal module names and signal names will vary depending
      on your naming convention and your design */

   // Edit the example below. You must change the signal
   // names on the right hand side
    
//   assign PC = DUT.fetch0.pcCurrent; //You won't need this because it's part of the main cpu interface
   assign Inst = DUT.inst;
   
   // assign RegWrite = DUT.decode0.regFile0.write;
   assign RegWrite = DUT.regwrite;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign WriteRegister = DUT.regwraddr;
   // The name of the register being written to. (4 bit signal)

   assign WriteData = DUT.regwrdata;
   // Data being written to the register. (16 bits)
   
   assign MemRead =  (~DUT.datawr & DUT.dataena);
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign MemWrite = (DUT.datawr & DUT.dataena);
   // Is memory being written to (1 bit signal)
   
   assign MemAddress = DUT.dataaddr;
   // Address to access memory with (for both reads and writes to memory, 16 bits)
   
   assign MemData = DUT.datain;
   // Data to be written to memory for memory writes (16 bits)
   
//   assign Halt = DUT.memory0.halt; //You won't need this because it's part of the main cpu interface
   // Is processor halted (1 bit signal)
   
   /* Add anything else you want here */

   
endmodule
