`timescale 1ns/1ps

module async_fifo_tb();

parameter DATA_WIDTH = 3;
parameter DATA_DEPTH = 8;
parameter ADDR_WIDTH = 3;


reg									wr_clk	;
reg									rd_clk	;
reg									rst_n	;
reg		[DATA_WIDTH-1:0]			wr_data	;
reg									rd_en	;
reg									wr_en	;
wire 								rd_vld	;
wire	[DATA_WIDTH-1:0]			rd_data;	
wire								empty	;	
wire								full	;
wire	[ADDR_WIDTH:0]				fifo_cnt;
 
 
//------------<例化被测试模块>----------------------------------------
async_fifo
#(	

	.DATA_WIDTH	(DATA_WIDTH),			//FIFO位宽
    .DATA_DEPTH	(DATA_DEPTH),			//FIFO深度
	.ADDR_WIDTH (ADDR_WIDTH)
)
async_fifo_inst(
	.wr_clk		(wr_clk		),
	.rd_clk		(rd_clk		),
	.rst_n		(rst_n		),
	.wr_data	(wr_data	),
	.rd_en		(rd_en		),
	.wr_en		(wr_en		),
                 
	.rd_data	(rd_data	),	
	.rd_vld 	(rd_vld		),
	.empty		(empty		),	
	.full		(full		),
	.fifo_cnt	(fifo_cnt	)			
);
 
//------------<设置初始测试条件>----------------------------------------
initial begin
	wr_clk = 1'b0;							//初始时钟为0
	rd_clk = 1'b0;
	rst_n <= 1'b0;						//初始复位
	wr_data <= 'd0;		
	wr_en <= 1'b0;		
	rd_en <= 1'b0;
//重复8次写操作，让FIFO写满 
# 20	
	repeat(10) begin		
		@(posedge wr_clk)begin		
			rst_n <= 1'b1;				
			wr_en <= 1'b1;		
			wr_data <= $random;			//生成8位随机数
		end
	end
//重复8次读操作，让FIFO读空	
	repeat(12) begin
		@(posedge rd_clk)begin		
			wr_en <= 1'b0;
			rd_en <= 1'd1;
		end
	end
//重复4次写操作，写入4个随机数据	
	repeat(7) begin
		@(posedge wr_clk)begin		
			wr_en <= 1'b1;
			wr_data <= $random;	//生成8位随机数
			rd_en <= 1'b0;
		end
	end
				wr_en <= 1'b1;
				rd_en <= 1'b1;
//持续同时对FIFO读写，写入数据为随机数据	
	forever begin
		@(posedge wr_clk)begin		
			wr_data <= $random;	//生成8位随机数
		end
	end



end
//------------<设置时钟>----------------------------------------------
always #10 wr_clk = ~wr_clk;			//系统时钟周期20ns
always #5 rd_clk = ~rd_clk;


endmodule


