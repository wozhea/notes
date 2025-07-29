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
 
 
//------------<����������ģ��>----------------------------------------
async_fifo
#(	

	.DATA_WIDTH	(DATA_WIDTH),			//FIFOλ��
    .DATA_DEPTH	(DATA_DEPTH),			//FIFO���
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
 
//------------<���ó�ʼ��������>----------------------------------------
initial begin
	wr_clk = 1'b0;							//��ʼʱ��Ϊ0
	rd_clk = 1'b0;
	rst_n <= 1'b0;						//��ʼ��λ
	wr_data <= 'd0;		
	wr_en <= 1'b0;		
	rd_en <= 1'b0;
//�ظ�8��д��������FIFOд�� 
# 20	
	repeat(10) begin		
		@(posedge wr_clk)begin		
			rst_n <= 1'b1;				
			wr_en <= 1'b1;		
			wr_data <= $random;			//����8λ�����
		end
	end
//�ظ�8�ζ���������FIFO����	
	repeat(12) begin
		@(posedge rd_clk)begin		
			wr_en <= 1'b0;
			rd_en <= 1'd1;
		end
	end
//�ظ�4��д������д��4���������	
	repeat(7) begin
		@(posedge wr_clk)begin		
			wr_en <= 1'b1;
			wr_data <= $random;	//����8λ�����
			rd_en <= 1'b0;
		end
	end
				wr_en <= 1'b1;
				rd_en <= 1'b1;
//����ͬʱ��FIFO��д��д������Ϊ�������	
	forever begin
		@(posedge wr_clk)begin		
			wr_data <= $random;	//����8λ�����
		end
	end



end
//------------<����ʱ��>----------------------------------------------
always #10 wr_clk = ~wr_clk;			//ϵͳʱ������20ns
always #5 rd_clk = ~rd_clk;


endmodule


