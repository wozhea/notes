## csma/ca 
80211-2012,9.2,9.3
80211-2012,362ҳ,������ʱ���л���ʱ��ԭ�ﶨ��
80211-2012,843ҳ��IFS֮�����͹�ϵ

a) RIFS reduced interframe space    ��С֡������ֻ������վ
b) SIFS short interframe space  ��վ�������С֡�������տڽ������һ�����ţ����������������Ӧ֡����ͷ����̼��
c) PIFS PCF interframe space
d) DIFS DCF interframe space
e) AIFS arbitration interframe space (used by the QoS facility)
f) EIFS extended interframe space

csma/ca���������ز������������ز������������ز���������ccaʵ�֣������ز�����ͨ��mac֡��nav�ֶ�ʵ��

![mac_frame_format](./picture//mac_frame_format.JPG);
![MAC_type](./picture/MAC_type.JPG)
![RTS_frame](./picture/RTS_frame.JPG)
![CTS_frame](./picture/CTS_frame.JPG)
![csma_cca](./picture/csma_cca.JPG)


CTS/RTS����ÿ֡����Ҫ�������ӣ����ڹ������ݳ��ȵ�֡����û��rts/cts�������û��ƿ�����dot11RTSThreshold attribute��Ϊalways��never��or ����length threshold
CTS/RTS֡����duration�ֶΰ��������ACK����ռ���ŵ�ʱ��(us)�����Ա�����sta���գ���������ÿ��sta��nav���ȣ�


sifs = aRXRFDelay����Ƶ�ӳ٣���aRXPLCPDelay�������ͷ�������ӳ٣���aMACProcessingDelay��MAC�㴦���ӳ٣� + aRxTxTurnaroundTime�����ͽ�������ת��ʱ�䣩
slot = �������ɾ�������Backoff����Сʱ�����������aCCATime��CCAʱ�䣩��aRxTxTurnaroundTime�����ͽ�������ת��ʱ�䣩��aAirPropagationTime�������ӳ٣���aMACProcessingDelay��MAC�㴦���ӳ٣���20us
pifs = sifs + 1*slot
difs = sifs + 2*slot,�䱾����ʵ���϶����������SIFS��Slot��һ����ϡ�


��Ҫ��Ϊnav�ĵ���������








## cca module (channel assesment clear)
�������������ز�������������⼴����rssi�жϣ��ز��������Ƿ��⵽ǰ��ѵ�������ж�
����������ޣ�rssi_half_db_th = 87<<1; // -62dBm
ǰ�����гɹ���⣺��⵽�̳�ѵ������
����һЩ�����ź�
���ch_idle��ʾ�ŵ�����

## tsf_timer(time syc function)
����һ������Ϊ1us��ռ�ձ�Ϊ1%��С����tsf_pulse_1M,
��linux����һ��64λ�ı�׼ʱ�䣬����1us���ٶȼ���,�²�Ϊϵͳ֮��ͬ������Ϣ��radio tap header?


## time_slice_gen
�����ĸ����е�ʹ��


# rssi module
�ò����õ���iqֵ����iq_rssi_half_db���ֶ����Ե�����correction,����9361ʵʱ�����gpio_status��
����slv_reg57,
{gpio_status_delay[6:0],iq_rssi_half_db,1'b0,(~ch_idle_final),(tx_core_is_ongoing|tx_bb_is_ongoing|tx_rf_is_ongoing|cts_toself_rf_is_ongoing|ack_cts_is_ongoing), demod_is_ongoing,(~gpio_status_delay[7]),rssi_half_db};//rssi_half_db 11bit, iq_rssi_half_db 9bit
iq_rssi_half_db = 115;ֵ
rssi_half_db_offset = 150;hardware_gain
gpio_status = 96;agc_control
ʵʱ��rssi_half_dB = 168
����ʵʱ��У׼rssi

rssi_half_db == ����IQ����iq_rssi_half_db - agc���� + ��ͬƵ���²����õ���ad9361ƫ����У׼




## phy_rx_parse
����֡�������ֱ�ack֡�͵�ַ
2Byte framecontrol + 2Byte Duration/ID + 6Byte rx_addr +6Byte tx_addr �̶�
��Ϊ����֡��block ack request 
    2Byte blk_ack_req_control +2Byte blk_ack_req_ssc
��Ϊ����֡��block ack 
    ��2Byte +2Byte blk_ack_req_ssn +8Byte blk_ack_resp_bitmap
else 
    2Byte sequence control 
        ��(to DS,from DS = 2b'11)
        +6Byte src_addr
    2Byte Qos
end

## pkt_filter_ctl
����ĳЩ����֡�Ϳ���֡����Ϊ��fpga���ֿ���ʵ��low mac��csma������֡����Ҫ�����ϲ�mac80211����
���block_rx_dma_to_ps�źž���֡�Ƿ񽻸�rx_intf�ٸ�dma�����ϲ�
monitorģʽ�¿��ܻ�ı�frame filter�Ĺ���ͨ��sdr�����ı��־λ�ı�mac80211״̬��ͬʱ�ı�fpga����״̬

��Ҫ���linux��mac80211Э��ջ��mac֡�ṹͬʱ��



## spi module 
����ad9361���շ�ģʽ�л���������9361��fddģʽ��ͨ��д24bit��ָ����Ʊ����Ƶ���Ŀ��أ�
ʵ�ֿ����л���tdd����ģʽ��
psѡ��SPI0_SCLK_O��SPI0_MOSI_O,SPI0_MISO_I(ֱ��9361),SPI0_SS_O����������xpu������
��˰�����źŸ���openwifi_module spi0_csn,spi0_sclk,spi0_mosi������spi����ѡ������ad9361��









## cw_exp module (contention window)
����cw_exp
if��ͬ����֮�䡢��ɷ��͡��ش��˳�����������cw��������С��
    else {if�ش���������С����󴰿�ʱ
        cw_exp+1
        else
        cw_exp���ֲ���
        }



## tx_control(�ؼ�)
�����͡��ش���ACK



## tx_on_detection
���ݴ�tx_intf��txģ������ķ������״̬��־�źţ������������ʱ�����һЩ״̬��־�ź�
tx_core_is_ongoing��txģ�����ڽ��У�change 1st
tx_bb_is_ongoing��tx_intf���ڽ��У������Ѿ�����tx_iq_intf��fifo��2nd
tx_rf_is_ongoing��rf�Ѿ�����ʱ���ֶ�������ʱȷ����־λ��4th
tx_chain_on��bb״̬���ֶ�������ʱ��ȷ����9361��״̬�л���־��3rd

## csma/ca module(�ؼ�)


