## �ź�����
����100Mhz,32λsample0 = {i0,q0};


### watchdog design
input:enable���ջ��������״̬ǰʹ�ܣ�iq_data,dc_running_sum_thֱ��ƫ�����ޣ�power_trigger������ⴥ����min/max_signal_len_th�����źų������ޣ�signal_len���ջ�����źų���
output:receiver_rst���ڸ�λwifi���ջ����쳣״̬��λ

receiver_rst_internal�����������ݷ���λ����32��ƽ��������ֱ����������Ϊ0����ѡ��-1��1�����쳣����ֱ������������ֵ����λ��
power_trigger�����ջ�������������������ޣ���λ
equalizer_monitor_rst����������һ������ͼ����ֵ��С���޷��������λ
signal_len_rst�����������signal���ڻ�С��Э��涨���ȡ���λ��



### dot11_rx
S_WAIT_POWER_TRIGGER,�ȴ�rssi��������ź�ǿ�ȳ������ޣ�����S_SYNC_SHORT״̬
����״̬��ǿ��ָʾ���������򶼷���S_WAIT_POWER_TRIGGER״̬��
S_SYNC_SHORT,���񵽵���ѵ�����У�����S_SYNC_LONG״̬
S_SYNC_LONG,��⵽��ͬ�����к����S_DECODE_SIGNAL,����sample��������320����S_WAIT_POWER_TRIGGER,
S_DECODE_SIGNAL,24��bit�����S_CHECK_SIGNAL
S_CHECK_SIGNALУ��SIGNALλ��Ϣ�����������S_SIGNAL_ERROR����ȷ�����rate�ֶ��Ƿ�Ϊ6M������S_DETECT_HT����ֱ�ӽ���S_DECODE_DATA��
S_SIGNAL_ERROR��λ�󷵻�S_WAIT_POWER_TRIGGER
S_DETECT_HT�����BPSK������ת�������ͼ������S_HT_SIGNAL���������������S_DECODE_DATA
S_HT_SIGNAL�����ɣ�����־λ��ɣ�����S_CHECK_HT_SIG_CRC
S_CHECK_HT_SIG_CRC��HT_SIGNAL_CRCУ����ȷ������S_CHECK_HT_SIG����ȷ��
S_DECODE_DATA�½�������λ�������������������Ҫ����������S_MPDU_PAD������Ҫ������ɽ���S_DECODE_DONE������һ��֡�Ľ��գ�����S_WAIT_POWER_TRIGGER״̬
�е��鷳��ֱ�ӻ�����ͼ��










### sync_short module
����У׼���rssi�������޺����sync_short״̬��</br>
����ط���
complex_to_mag_sqģ����㵥���źŷ���ƽ��</br>
mag_sq_avg_inst����16��ƽ��ֵ</br>
sample_delayed_inst��ʱ16��</br>
delay_prod_inst�����������ֵ���Է���ƽ����ʽ</br>
delay_prod_avg_inst����16��ƽ���ź����</br>
freq_offset_instƽ������Ϊ64�����16����ش������I��Qֵ����phase_inst���ұ����-pi~pi����λ�ǣ�����sync_short����ƽ������(16?)���Ը������
������Ϊ16��16��ƽ���Ļ����������㣬���Ϊ16��16��ƽ����صĻ����������㣬��������75%������С���޵���100�����������ֱ����25%��ȷ�ϼ�⵽��ͬ�����С�



## sync_long module
����ط�����
���������к󣬽�������뱾�����е����ֵ����ش���Ϊ8/16?��⵽�����岢�����Ϊ64��������λ��������sync_short����õ�����ǣ����������FFT�ˣ��������




## equalizer module
input��������Ƶͬ����sync_long_out����λ����eq_phase_out,
output������equalizer_out
�ж��Ƿ񾭹�
��Ƶ�ŵ�����













������8λbyte_out����rx_intf��byte_in��xpu��byte_in






