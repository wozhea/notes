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
 
 
//------------<����������ģ��>----------------------------------------
sync_fifo
#(	

	.DATA_WIDTH	(DATA_WIDTH),			//FIFOλ��
    .DATA_DEPTH	(DATA_DEPTH),			//FIFO���
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
 
//------------<���ó�ʼ��������>----------------------------------------
initial begin
	clk = 1'b0;							//��ʼʱ��Ϊ0
	rst_n <= 1'b0;						//��ʼ��λ
	wr_date <= 'd0;		
	wr_en <= 1'b0;		
	rd_en <= 1'b0;
//�ظ�8��д��������FIFOд�� 
# 20	
	repeat(10) begin		
		@(posedge clk)begin		
			rst_n <= 1'b1;				
			wr_en <= 1'b1;		
			wr_date <= $random;			//����8λ�����
		end
	end
//�ظ�8�ζ���������FIFO����	
	repeat(12) begin
		@(posedge clk)begin		
			wr_en <= 1'b0;
			rd_en <= 1'd1;
		end
	end
//�ظ�4��д������д��4���������	
	repeat(7) begin
		@(posedge clk)begin		
			wr_en <= 1'b1;
			wr_date <= $random;	//����8λ�����
			rd_en <= 1'b0;
		end
	end
//����ͬʱ��FIFO��д��д������Ϊ�������	
	forever begin
		@(posedge clk)begin		
			wr_en <= 1'b1;
			wr_date <= $random;	//����8λ�����
			rd_en <= 1'b1;
		end
	end
end
//------------<����ʱ��>----------------------------------------------
always #10 clk = ~clk;			//ϵͳʱ������20ns
endmodule

