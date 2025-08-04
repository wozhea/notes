module clk_div_fraction
  #(
   parameter            SOURCE_NUM = 76 , //cycles in source clock
   parameter            DEST_NUM   = 10  //cycles in destination clock
   )
   (
    input               rstn ,
    input               clk,
    output              clk_frac
    );
  
   //7��Ƶ������8��Ƶ������������ֵ
   parameter    SOURCE_DIV = SOURCE_NUM/DEST_NUM ; 
   parameter    DEST_DIV   = SOURCE_DIV + 1; 
   parameter    DIFF_ACC   = SOURCE_NUM - SOURCE_DIV*DEST_NUM ;


   reg [3:0]            cnt_end_r ;  //�ɱ��Ƶ����
   reg [3:0]            main_cnt ;   //��������
   reg                  clk_frac_r ; //ʱ��������ߵ�ƽ������Ϊ1
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b0 ;
      end
      else if (main_cnt == cnt_end_r) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b1 ;
      end
      else begin
         main_cnt    <= main_cnt + 1'b1 ;
         clk_frac_r  <= 1'b0 ;
      end
   end



   //���ʱ��
   assign       clk_frac        = clk_frac_r ;
   //��ֵ�ۼ���ʹ�ܿ���
   wire         diff_cnt_en     = main_cnt == cnt_end_r ;

   //��ֵ�ۼ����߼�
   reg [4:0]            diff_cnt_r ;
   wire [4:0]           diff_cnt = diff_cnt_r >= DEST_NUM ?
                                   diff_cnt_r -10 + DIFF_ACC : 
                                   diff_cnt_r + DIFF_ACC ;                                
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         diff_cnt_r <= 0 ;
      end
      else if (diff_cnt_en) begin
         diff_cnt_r <= diff_cnt ;
      end
   end

   //��Ƶ���ڱ����Ŀ����߼�
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
      //��ֵ�ۼ������ʱ���޸ķ�Ƶ����
      else if (diff_cnt >= 10) begin
         cnt_end_r      <= DEST_DIV-1 ;
      end
      else begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
   end

endmodule