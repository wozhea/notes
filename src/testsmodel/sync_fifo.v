module sync_fifo
#(	parameter DATA_WIDTH = 3,	//数据宽度
	parameter DATA_DEPTH = 8,	//深度，数据个数
	parameter ADDR_WIDTH = 3	//位宽
)
(
	input clk,
	input rst_n,
	input [DATA_WIDTH-1:0] wr_date,
	input wr_en,
	input rd_en,
	
	output reg [DATA_WIDTH-1:0] rd_date,
	//output rd_data_vld;
	output empty,
	output full,
	output  [ADDR_WIDTH:0] fifo_cnt
);


reg [ADDR_WIDTH:0] ram_wr_ptr_exp;
reg [ADDR_WIDTH:0] ram_rd_ptr_exp;
reg [DATA_WIDTH-1:0] ram [DATA_DEPTH-1:0];
wire [ADDR_WIDTH-1:0] ram_wr_ptr;
wire [ADDR_WIDTH-1:0] ram_rd_ptr;
assign ram_wr_ptr = ram_wr_ptr_exp[ADDR_WIDTH-1:0];
assign ram_rd_ptr = ram_rd_ptr_exp[ADDR_WIDTH-1:0];

//写操作
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		ram_wr_ptr_exp <= 0;
	end
	else if (wr_en && !full)begin
		ram_wr_ptr_exp <=ram_wr_ptr_exp+1'd1;
		ram[ram_wr_ptr] <= wr_date;
	end
end

//读操作
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		ram_rd_ptr_exp <= 0;
	end
	else if (rd_en && !empty)begin
		ram_rd_ptr_exp <= ram_rd_ptr_exp +1'd1;
		rd_date <= ram[ram_rd_ptr];
		//rd_data_vld <= rd_en;

	end
end

assign fifo_cnt = ram_wr_ptr_exp-ram_rd_ptr_exp;
//assign full = (fifo_cnt == DATA_DEPTH || ((fifo_cnt == DATA_DEPTH-1)&&wr_en==1&&rd_en==0))?1'b1:1'b0;
assign full = fifo_cnt == DATA_DEPTH || ((fifo_cnt == DATA_DEPTH - 1)&&wr_en&&!rd_en);

//assign full = fifo_cnt == DATA_DEPTH;

assign empty = fifo_cnt == 1'd0 || ((fifo_cnt == 1)&&rd_en&&wr_en);

//计数器
/*always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		fifo_cnt <=0;
	else begin
		case({wr_en,rd_en})
			2'b00:fifo_cnt<=fifo_cnt;
			2'b10:if(fifo_cnt != DATA_DEPTH) fifo_cnt <= fifo_cnt + 1'd1;
			2'b01:if(fifo_cnt != 0)	fifo_cnt <= fifo_cnt - 1'd1;
			2'b11:fifo_cnt <= fifo_cnt;
			default: fifo_cnt <= fifo_cnt;
		endcase
	end
end
*/


/*
integer ii;
always @(posegde clk or negedge rst_n)begin
    if(!rst_n)
        for (ii = 0;ii<DATA_DEPTH ; ii = ii+1)
            ram[ii] <= 0;
    else begin
        for (ii = 0;ii<DATA_DEPTH ; ii = ii+1)begin
            if(wr_en && ii== ram_wr_ptr)
            ram [ii] <= wr_date;
        end
    end
end
*/



endmodule 