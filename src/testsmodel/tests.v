module tests
#(  parameter DATA_WIDTH = 3,   //λ��
    parameter DATA_DEPTH = 8    //��ȣ�����

)
(   input clk,
    input rst_n,
    input [DATA_WIDTH-1:0] wr_date,
    input wr_en,
    
    input rd_en,
    output [DATA_WIDTH-1:0] rd_date,
    output full,
    output empty,
    output [DATA_ADDR_WIDTH:0]  fifo_count    
);
parameter DATA_ADDR_WIDTH = $clog2(DATA_DEPTH);//�洢��ַ

reg [DATA_WIDTH-1:0] ram [DATA_ADDR_WIDTH-1:0];//�洢

reg [DATA_WIDTH:0] ram_rd_ptr;
reg [DATA_WIDTH:0] ram_wr_ptr;
wire [DATA_WIDTH-1:0] ram_wr_ptr_exp;
wire [DATA_WIDTH-1:0] ram_rd_ptr_exp;
assign ram_wr_ptr = ram_wr_ptr_exp[DATA_WIDTH-1:0];//��չд��ַȡ��λ��Ϊд��ַ
assign ram_rd_ptr = ram_rd_ptr_exp[DATA_WIDTH-1:0];//��չ��


//д��ַ�߼�
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ram_wr_ptr_exp <= 0;
    else if(wr_en && !full)
        ram_wr_ptr_exp <= ram_wr_ptr_exp+1'b1;
    else 
        ram_wr_ptr_exp <= ram_wr_ptr_exp;
end

//����ַ�߼�
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ram_rd_ptr_exp <= 0;
    else if(rd_en && !empty)
        ram_rd_ptr_exp <= ram_rd_ptr_exp+1'b1;
    else 
        ram_rd_ptr_exp <= ram_rd_ptr_exp;
end

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










endmodule