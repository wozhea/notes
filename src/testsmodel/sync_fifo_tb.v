`timescale 1ns/1ps

module sync_fifo_tb();

parameter DATA_WIDTH = 3;
parameter DATA_DEPTH = 8;
parameter ADDR_WIDTH = 3;


reg									clk		;
reg									rst_n	;
reg		[DATA_WIDTH-1:0]			wr_date	;
reg									rd_en	;
reg									wr_en	;
						
wire	[DATA_WIDTH-1:0]			rd_date;	
wire								empty	;	
wire								full	;
wire	[ADDR_WIDTH:0]				fifo_cnt;
 
 
//------------<例化被测试模块>----------------------------------------
sync_fifo
#(	

	.DATA_WIDTH	(DATA_WIDTH),			//FIFO位宽
    .DATA_DEPTH	(DATA_DEPTH),			//FIFO深度
	.ADDR_WIDTH (ADDR_WIDTH)
)
sync_fifo_inst(
	.clk		(clk		),
	.rst_n		(rst_n		),
	.wr_date	(wr_date	),
	.rd_en		(rd_en		),
	.wr_en		(wr_en		),
                 
	.rd_date	(rd_date	),	
	.empty		(empty		),	
	.full		(full		),
	.fifo_cnt	(fifo_cnt	)			
);
 
//------------<设置初始测试条件>----------------------------------------
initial begin
	clk = 1'b0;							//初始时钟为0
	rst_n <= 1'b0;						//初始复位
	wr_date <= 'd0;		
	wr_en <= 1'b0;		
	rd_en <= 1'b0;
//重复8次写操作，让FIFO写满 
# 20	
	repeat(10) begin		
		@(posedge clk)begin		
			rst_n <= 1'b1;				
			wr_en <= 1'b1;		
			wr_date <= $random;			//生成8位随机数
		end
	end
//重复8次读操作，让FIFO读空	
	repeat(12) begin
		@(posedge clk)begin		
			wr_en <= 1'b0;
			rd_en <= 1'd1;
		end
	end
//重复4次写操作，写入4个随机数据	
	repeat(7) begin
		@(posedge clk)begin		
			wr_en <= 1'b1;
			wr_date <= $random;	//生成8位随机数
			rd_en <= 1'b0;
		end
	end
//持续同时对FIFO读写，写入数据为随机数据	
	forever begin
		@(posedge clk)begin		
			wr_en <= 1'b1;
			wr_date <= $random;	//生成8位随机数
			rd_en <= 1'b1;
		end
	end
end
//------------<设置时钟>----------------------------------------------
always #10 clk = ~clk;			//系统时钟周期20ns
endmodule

