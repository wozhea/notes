## 信号流程
输入100Mhz,32位sample0 = {i0,q0};


### watchdog design
input:enable接收机进入解码状态前使能，iq_data,dc_running_sum_th直流偏置门限，power_trigger能量检测触发，min/max_signal_len_th最长最短信号长度门限，signal_len接收机解调信号长度
output:receiver_rst用于复位wifi接收机，异常状态复位

receiver_rst_internal，对输入数据符号位进行32点平均，计算直流分量，若为0则交替选择-1和1避免异常，若直流分量大于阈值，复位，
power_trigger，接收机检测能量大于能量门限，复位
equalizer_monitor_rst，均衡器归一化星座图绝对值过小，无法解调，复位
signal_len_rst，解调出来的signal大于或小于协议规定长度。复位。



### dot11_rx
S_WAIT_POWER_TRIGGER,等待rssi计算出的信号强度超过门限，进入S_SYNC_SHORT状态
其他状态下强度指示低于门限则都返回S_WAIT_POWER_TRIGGER状态，
S_SYNC_SHORT,捕获到到短训练序列，进入S_SYNC_LONG状态
S_SYNC_LONG,检测到长同步序列后进入S_DECODE_SIGNAL,处理sample个数大于320返回S_WAIT_POWER_TRIGGER,
S_DECODE_SIGNAL,24个bit后进入S_CHECK_SIGNAL
S_CHECK_SIGNAL校验SIGNAL位信息，错误则进入S_SIGNAL_ERROR，正确则根据rate字段是否为6M，进入S_DETECT_HT，或直接进入S_DECODE_DATA；
S_SIGNAL_ERROR复位后返回S_WAIT_POWER_TRIGGER
S_DETECT_HT如果是BPSK调制旋转后的星座图，进入S_HT_SIGNAL，正常调制则进入S_DECODE_DATA
S_HT_SIGNAL解调完成，各标志位完成，进入S_CHECK_HT_SIG_CRC
S_CHECK_HT_SIG_CRC若HT_SIGNAL_CRC校验正确，进入S_CHECK_HT_SIG，正确则
S_DECODE_DATA下进行数据位解包，解包完后若长度需要补充则送入S_MPDU_PAD，不需要则解包完成进入S_DECODE_DONE送入下一个帧的接收，进入S_WAIT_POWER_TRIGGER状态
有点麻烦，直接画流程图吧










### sync_short module
经过校准后的rssi大于门限后进入sync_short状态，</br>
自相关方法
complex_to_mag_sq模块计算单个信号幅度平方</br>
mag_sq_avg_inst计算16点平均值</br>
sample_delayed_inst延时16点</br>
delay_prod_inst计算两者相关值，以幅度平方形式</br>
delay_prod_avg_inst计算16点平均信号相乘</br>
freq_offset_inst平均长度为64的相隔16点相关窗，输出I、Q值进入phase_inst查找表输出-pi~pi的相位角，进入sync_short除以平均长度(16?)，以负数输出
计算间隔为16的16点平均的滑窗能量计算，间隔为16的16点平均相关的滑窗能量计算，比例超过75%大于最小门限点数100，正负个数分别大于25%，确认检测到短同步序列。



## sync_long module
互相关方法，
跳过短序列后，进入计算与本地序列的相关值，相关窗长为8/16?检测到两个峰并且相隔为64后，送入相位补偿，用sync_short计算得到的相角，补偿后进入FFT核，计算输出




## equalizer module
input经过长导频同步的sync_long_out，相位估计eq_phase_out,
output均衡后的equalizer_out
判断是否经过
导频信道估计













最后出来8位byte_out送入rx_intf的byte_in和xpu的byte_in






