module clk_div_fractioin_5(
    input               rst_n ,
    input               clk,
    output              clk_div3p5
    );
parameter  DIV_CLK = 7;
/*
计数器循环计数到 7，分别产生由 4 个和 3 个源时钟周期组成的 2 个分频时钟。从 7 个源时钟产生了 2 个分频时钟的角度来看，该过程完成了 3.5 倍的分频，但是每个分频时钟并不是严格的 3.5 倍分频。
(2) 下面对周期不均匀的分频时钟进行调整。一次循环计数中，在源时钟下降沿分别产生由 4 个和 3 个源时钟周期组成的 2 个分频时钟。相对于第一次产生的 2 个周期不均匀的时钟，本次产生的 2 个时钟相位一个延迟半个源时钟周期，一个提前半个源时钟周期。

*/

reg [3:0] clk_cnt;
always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        clk_cnt <= 'b0 ;
      end
      else if (clk_cnt == DIV_CLK-1) begin //计数2倍分频比
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