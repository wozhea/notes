### ���� 
���յ��ľ��������64λadc_data
���ػػ���32λiq0,iq1





## ����
adc_intf 
adc_data��������ѡ���Ƿ�����һ·
->adc_data_internal
��һ����ʱģ�飨��ע��Ϊ40M��Ϊ20M��->adc_data_delay
���첽xpm fifo(д40Madcʱ�ӣ�дʹ��20MHz,��100Mm_axis_clk)Ϊ100Mhz��data_to_acc_internal
��bb_gain����λ����ԭ��12λ��9361���ݷ�����չ��Ϊ16λ->ant_data_after_sel(data_to_bb)
�ж��Ƿ�ѡ�񱾵ػػ���ѡ��tx_intf���ݺ�ant_data_after_sel,->bw20_i0,q0,i1,q1

rx_iq_intf
�Ѿ�������·����ƥ��->rf_i0_to_acc,
sample0 = {rf_i0_to_acc,rf_q0_to_acc}
sample1 = {rf_i1_to_acc,rf_q1_to_acc}
