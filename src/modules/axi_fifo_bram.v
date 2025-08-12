//
// Copyright 2012-2014 Ettus Research LLC
// Copyright 2018 Ettus Research, a National Instruments Company
//
// SPDX-License-Identifier: LGPL-3.0-or-later
//



// Block RAM AXI fifo


module axi_fifo_bram
  #(parameter WIDTH=32, SIZE=9)
   (input clk, input reset, input clear,
    input [WIDTH-1:0] i_tdata,
    input i_tvalid,
    output i_tready,//驱动上游，可以接收上游数据ready
    output reg [WIDTH-1:0] o_tdata = 'd0,
    output reg o_tvalid = 1'b0,
    input o_tready,//下游驱动的，下游可以接收数据
    
    output reg [15:0] space,
    output reg [15:0] occupied);

   wire [WIDTH-1:0]   int_tdata;
   wire 	      int_tready;

   wire full, empty;
   wire write     = i_tvalid & i_tready;//实际写fifo
   // read_int will assert when either a read occurs or the output register is empty (and there is data in the shift register fifo)
   wire read_int  = ~empty & int_tready;//(fifo不空且(下游可以读/输出数据无效))
   // read will only assert when an actual 1read request occurs at the interface
   wire read      = o_tready & o_tvalid;//实际读fifo

   assign i_tready  = ~full;

   // Read side states
   localparam 	  ST_EMPTY = 0;
   localparam 	  PRE_READ = 1;
   localparam 	  READING = 2;

   reg [SIZE-1:0] wr_addr, rd_addr;
   reg [1:0] 	  read_state;

   reg 	  empty_reg = 1'b1, full_reg = 1'b0;
   always @(posedge clk)//写地址管理
     if(reset)
       wr_addr <= 0;
     else if(clear)
       wr_addr <= 0;
     else if(write)
       wr_addr <= wr_addr + 1;
//例化双口ram，一口只读，一口只写
   ram_2port #(.DWIDTH(WIDTH),.AWIDTH(SIZE))
     ram (.clka(clk),
	  .ena(1'b1),
	  .wea(write),
	  .addra(wr_addr),
	  .dia(i_tdata),
	  .doa(),

	  .clkb(clk),
	  .enb((read_state==PRE_READ)|read_int),//外部读，内部读
	  .web(1'b0),
	  .addrb(rd_addr),
	  .dib({WIDTH{1'b1}}),
	  .dob(int_tdata));

   always @(posedge clk)
     if(reset)
       begin
	  read_state <= ST_EMPTY;//复位清零
	  rd_addr <= 0;
	  empty_reg <= 1;
       end
     else
       if(clear)
	 begin
	    read_state <= ST_EMPTY;
	    rd_addr <= 0;
	    empty_reg <= 1;
	 end
       else 
	 case(read_state)
	   ST_EMPTY :
	     if(write)
	       begin
		  //rd_addr <= wr_addr;
		  read_state <= PRE_READ;
	       end
	   PRE_READ :
	     begin
		read_state <= READING;
		empty_reg <= 0;
		rd_addr <= rd_addr + 1;
	     end
	   //递增读地址
	   READING :
	     if(read_int)
	       if(rd_addr == wr_addr)//如果读地址追上写地址，根据是否有写行为
		 begin
		    empty_reg <= 1; 
		    if(write)
		      read_state <= PRE_READ;
		    else
		      read_state <= ST_EMPTY;
		 end
	       else
		 rd_addr <= rd_addr + 1;//正常更新读地址
	 endcase // case(read_state)

   wire [SIZE-1:0] dont_write_past_me = rd_addr - 2;
   wire 	   becoming_full = wr_addr == dont_write_past_me;//即将写满
     
   always @(posedge clk)
     if(reset)
       full_reg <= 0;
     else if(clear)
       full_reg <= 0;
     else if(read_int & ~write)
       full_reg <= 0;
     //else if(write & ~read_int & (wr_addr == (rd_addr-3)))
     else if(write & ~read_int & becoming_full)//写却不读，而且快满了
       full_reg <= 1;

   //assign empty = (read_state != READING);
   assign empty = empty_reg;

   // assign full = ((rd_addr - 1) == wr_addr);
   assign full = full_reg;

   // Output registered stage
   always @(posedge clk)
   begin
      // Valid flag
      if (reset | clear)
         o_tvalid <= 1'b0;
      else if (int_tready)
         o_tvalid <= ~empty;

      // Data
      if (int_tready)
         o_tdata <= int_tdata;
   end

   assign int_tready = o_tready | ~o_tvalid;

   //////////////////////////////////////////////
   // space and occupied are for diagnostics only
   // not guaranteed exact

   localparam NUMLINES = (1<<SIZE);
   always @(posedge clk)
     if(reset)
       space <= NUMLINES;
     else if(clear)
       space <= NUMLINES;
     else if(read & ~write)
       space <= space + 16'b1;
     else if(write & ~read)
       space <= space - 16'b1;
   
   always @(posedge clk)
     if(reset)
       occupied <= 16'b0;
     else if(clear)
       occupied <= 16'b0;
     else if(read & ~write)
       occupied <= occupied - 16'b1;
     else if(write & ~read)
       occupied <= occupied + 16'b1;

endmodule // fifo_long
