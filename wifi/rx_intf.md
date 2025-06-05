### 输入 
接收到的经过处理的64位adc_data
本地回环的32位iq0,iq1





## 流程
adc_intf 
adc_data经过天线选择，是否屏蔽一路
->adc_data_internal
经一个延时模块（但注释为40M变为20M）->adc_data_delay
经异步xpm fifo(写40Madc时钟，写使能20MHz,读100Mm_axis_clk)为100Mhz的data_to_acc_internal
经bb_gain，移位，把原本12位的9361数据符号扩展变为16位->ant_data_after_sel(data_to_bb)
判断是否选择本地回环，选择tx_intf数据和ant_data_after_sel,->bw20_i0,q0,i1,q1

rx_iq_intf
已经进行旁路速率匹配->rf_i0_to_acc,
sample0 = {rf_i0_to_acc,rf_q0_to_acc}
sample1 = {rf_i1_to_acc,rf_q1_to_acc}
