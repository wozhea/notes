module async_fifo
#(
    parameter DATA_DEPTH = 8,
    parameter DATA_WIDTH = 3,
    parameter ADDR_WIDTH = 3
)
(
    input wr_clk,
    input [DATA_WIDTH-1:0] wr_data,
    input wr_en,
    input rst_n,

    input rd_clk,
    input rd_en,
    output reg [DATA_WIDTH-1:0] rd_data,
    output reg rd_vld,
    output empty,
    output full,
    output [ADDR_WIDTH:0] fifo_cnt
);
reg [DATA_WIDTH-1:0] ram [DATA_DEPTH-1:0];//存储
reg [ADDR_WIDTH:0] wr_ptr;//多一位指针
reg [ADDR_WIDTH:0] rd_ptr;
wire [ADDR_WIDTH:0] wr_ptr_gray;//跨时钟域传输格雷码
wire [ADDR_WIDTH:0] rd_ptr_gray;
reg [ADDR_WIDTH:0] wr_ptr_gray_r;//打拍
reg [ADDR_WIDTH:0] wr_ptr_gray_2r;
reg [ADDR_WIDTH:0] rd_ptr_gray_r;
reg [ADDR_WIDTH:0] rd_ptr_gray_2r;
wire [ADDR_WIDTH-1:0] wr_addr;
wire [ADDR_WIDTH-1:0] rd_addr;

reg [ADDR_WIDTH:0] wr_ptr_r;//用于计数
reg [ADDR_WIDTH:0] wr_ptr_2r;




//格雷码
assign wr_ptr_gray = wr_ptr ^ (wr_ptr >> 1);
assign rd_ptr_gray = rd_ptr ^ (rd_ptr >> 1);
//读数写数地址
assign wr_addr = wr_ptr[ADDR_WIDTH-1:0];
assign rd_addr = rd_ptr[ADDR_WIDTH-1:0];



//写指针到读时钟域打拍
always @(posedge rd_clk or negedge rst_n)begin
    if(!rst_n)  begin
        wr_ptr_gray_r <= 0;
        wr_ptr_gray_2r <=0;
        wr_ptr_r <=0;
        wr_ptr_2r <=0;
    end else begin
        wr_ptr_gray_r <= wr_ptr_gray;
        wr_ptr_gray_2r <= wr_ptr_gray_r;
        wr_ptr_r <= wr_ptr;
        wr_ptr_2r <= wr_ptr_r;
    end
end
//读指针到写时钟域打拍
always @(posedge wr_clk or negedge rst_n)begin
    if(!rst_n)  begin
        rd_ptr_gray_r <= 0;
        rd_ptr_gray_2r <=0;
    end else begin
        rd_ptr_gray_r <= rd_ptr_gray;
        rd_ptr_gray_2r <= rd_ptr_gray_r;
    end
end

integer  i;
///写
always @(posedge wr_clk or negedge rst_n)begin
    if(!rst_n)begin
        wr_ptr <= 0;
        for (i =0;i<DATA_DEPTH;i=i+1)
        ram[i] <=0;
    end
    else if(!full && wr_en) begin   
        ram[wr_addr] <= wr_data;
        wr_ptr <= wr_ptr+1'b1;
    end else begin

        wr_ptr <= wr_ptr;
    end
end
//读
always @(posedge rd_clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_ptr <= 0;
        rd_vld <= 0;
    end
    else if(!empty && rd_en) begin   
        rd_data <= ram[rd_addr];
        rd_vld <= 1'b1;
        rd_ptr <= rd_ptr+1'b1;
    end
    else begin
        rd_vld <= 1'b0;
        rd_ptr <= rd_ptr;
    end
end

assign empty = wr_ptr_gray_2r == rd_ptr_gray;
//assign full  = (rd_ptr_gray_2r[ADDR_WIDTH-:2]^wr_ptr[ADDR_WIDTH-:2])==2'b11 && rd_ptr_gray_2r[ADDR_WIDTH-2:0]==wr_ptr[ADDR_WIDTH-2:0];
assign full = wr_ptr_gray == {~rd_ptr_gray_2r[ADDR_WIDTH-:2],rd_ptr_gray_2r[ADDR_WIDTH-2:0]};
assign fifo_cnt =  wr_ptr_2r - rd_ptr;
endmodule