module clk_div_fractioin_5(
    input               rst_n ,
    input               clk,
    output              clk_div3p5
    );
parameter  DIV_CLK = 7;
/*
������ѭ�������� 7���ֱ������ 4 ���� 3 ��Դʱ��������ɵ� 2 ����Ƶʱ�ӡ��� 7 ��Դʱ�Ӳ����� 2 ����Ƶʱ�ӵĽǶ��������ù�������� 3.5 ���ķ�Ƶ������ÿ����Ƶʱ�Ӳ������ϸ�� 3.5 ����Ƶ��
(2) ��������ڲ����ȵķ�Ƶʱ�ӽ��е�����һ��ѭ�������У���Դʱ���½��طֱ������ 4 ���� 3 ��Դʱ��������ɵ� 2 ����Ƶʱ�ӡ�����ڵ�һ�β����� 2 �����ڲ����ȵ�ʱ�ӣ����β����� 2 ��ʱ����λһ���ӳٰ��Դʱ�����ڣ�һ����ǰ���Դʱ�����ڡ�

*/

reg [3:0] clk_cnt;
always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        clk_cnt <= 'b0 ;
      end
      else if (clk_cnt == DIV_CLK-1) begin //����2����Ƶ��
        clk_cnt <= 'b0 ;
      end
      else begin
        clk_cnt <= clk_cnt + 1'b1 ;
      end
   end



reg clk_ave;
reg clk_adjust;


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        clk_ave <= 0 ;
    end else if(clk_cnt == 0 || (clk_cnt == DIV_CLK/2+1))
        clk_ave <= 1'b1;
    else 
        clk_ave <= 1'b0;
end

always @(negedge clk or negedge rst_n)begin
    if(!rst_n)begin
        clk_adjust <= 0 ;
    end else if(clk_cnt == 1 || (clk_cnt == DIV_CLK/2+1))
        clk_adjust <= 1'b1;
    else 
        clk_adjust <= 1'b0;
end


assign clk_div3p5 = clk_adjust | clk_ave;
endmodule