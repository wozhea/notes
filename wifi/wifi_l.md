���������ؿ�ʱ����������fifo


���ջ��������sync_long��
�������ض�csi�����Ӱ�죬������ô��csi����ȥ����λ����
axisЭ�鴫��csi
��·/��·�����ȡ��Ϣ
tx_bit_intf
��ʱ������



tcl�ű�



���壺
���˻�ȺԶ�������磬������·Э��������㣬ȫ˫��CSMA/CA��ƣ���̬·��Э��
CSI��֪�������״ͬ��һ�廯



## wifi�ṹ
![whole](./picture/structure.JPG);
���û��ռ����sdr��������FPGA������·��һ·��Ӧ�����ݽ���ϵͳ���ã����׽��ֵ�����Э�飬���豸�ӿڣ����������֡����mac80211��
��һ·��ר�Ŷ�wifi���й���Ĺ��ߣ���wpa_supplicant,hostapd,iwconfig�ȣ���linux�ں˿ռ�nl80211��cfg80211Э��ջ���û��ռ������ͨ��netlink�׽��ִ��ݸ��ںˣ�nl80211��һ��netlinkЭ�飬רΪ�������������ƣ����û��ռ������ת��Ϊ�ں��ܹ����ĸ�ʽ����󽻸�mac80211��
nl80211�����󴫵ݸ�cfg80211,����һ��ͨ�õ������������ÿ�ܣ�������������豸״̬������WIFI�豸�����ñ����ŵ���Ƶ�ʵȡ�
mac80211��ʵ��80211MAC���ģ�飬����������WIFI��ص�Э���߼�����֡�����ɡ����ͺͽ��ա�
mac80211ͨ��ieee80211_ops����ĺ����ӿ�api����sdr.ko�������Ѹ������ݺ�sdr��������sdr.ko��������fpga�Ĺ�����

openwifi����softmac�ܹ�����������֡ͨ��mac80211Э��ջ���ƣ�lowmac��csma/ca��cca��fpga�ڲ�

![verilog.JPG](./picture/structure_2.JPG);
���ݴ�mac80211����֮�󽻸�sdr������sdr��������rx_intf��openofdm_rx_driver��xilinx_dma_driver��xpu_driver��openofdm_tx_driver��tx_intf_driver��������fpga���ƣ�
sdr_driver�����Ƚ���axis_dma��dma�˺�tx_intf RTLģ����axis����������tx_intf���ж��й���ȹ��ܣ��յ�����XPU�Ŀ��Է��͡�ʱ����ȱ�־�����ݺ�����ݡ������������PMD����㷢���openofdm_tx��openofdm_tx�����������������֡������ݽ���tx_iq_intf��dac_intf��󽻸�ad9361���䡣
ad9361ʵʱ���յ�Ų��󣬾�adc_intf��rx_iq_intf��õ�IQ���ݽ���openofdm_rx���ջ��õ�����֡�Ľṹ�����ݣ���һϵ�в�������pl_to_m_axis RTLģ�����ڴ���mac80211��Ҫ��������rssi���桢ʱ������桢������������Ϣ��֡���ݽ���XPUģ�飬����MAC֡����������tx_control�������ģ�飬����csma_ca�����ز������ͳ�ͻ����ģ�飬�������˰�macͷ��Ϣ����pl_to_m_axis��
��ad9361���ʵʱagc����Դ�IQ������õ�rssi���в�������ʵ�ʵ��ź�ǿ�Ƚ���pl_to_m_axis��cca�ŵ��������ģ�飬�������ŵ����к�ѱ�־λ��csmaģ�顣



### glossary:
RTS/CTS��request to send;clear to send��clear to send
cca(channel clear assessment)
nav(network allocation vector )��rts/cts���ƣ�Nav����0�͹���backoff��������RTS/CTS��CP�ڳ�PSPOLL֡���֡����
BEB(binary exponential backoff)
backoff ���ˣ������С�ľ������ڣ����͵���ʱ��ֻ���ڼ������ŵ�����ʱ�ŵ�����
PCF��point coordination function��
DCF(distributed coordination function)csma/ca����ʵ��
RA(received address)
TA(transmite address)

### MAC��֡�ṹ

������·���ΪLLC��Logical Link Control���߼���·���ƣ��Ӳ㼰MAC��Media Access Control��ý����ʿ��ƣ��Ӳ㡣�ϲ����ݱ��ƽ���LLC�Ӳ���ΪMAC�������ݵ�Ԫ����MSDU��MAC Service Data Unit��������LLC��MSDU���͵�MAC�Ӳ����Ҫ��MSDU����MAC��ͷ��Ϣ������װ���MSDU��ΪMACЭ�����ݵ�Ԫ����MPDU��MAC Protocol Data Unit������ʵ������802.11MAC֡��802.11MAC֡�����ڶ��㱨ͷ��֡���弰֡β  

![mac_frame](./picture/mac_frame.JPG)
һ���MAC֡�ṹ��ͼ��FrameControl��Ҫ�涨֡���͡���Ϊ����֡������֡������֡��������֡���ڿ��ƶ������ŵ���ռ�ã����ͷ���֡�ۺ��Ƿ��и����Ƭ���Ƿ����ش�֡����Դʡ��ģʽ���������Ƿ��и������ݡ��Ƿ���WEP���ܡ��Ƿ�Ϊ����֡��  

����֡(management)����AP/STA�ű�֡�����롢��֤�����ӵȡ���Ϊ����(Association)����ͻ�Ӧ������(Reassociation)����ͻ�Ӧ��̽��(Probe)����ͻ�Ӧ��ʱ��ͬ��֡(Timing Advertisement)���ű�֡(Beacon)��ATIM(Announcement Traffic Indication Message)(IBSS������˯�߻��ѽ���)������(Disassociation)����/����Ȩ(Authentication)������֡(Action)(Э��ͬ������ڵ����Ϊ��Ƶ���л���ͬ����λ��)������ACK�Ķ���֡(Action-noACK)������֡(Reserved)  

����֡(Control)���ڿ��ƶ������ŵ���ռ�ã���װ֡(Control Wrapper)��װ����������͵�֡����ȷ��/��ȷ������֡(Block Ack Request)��ʡ����ѯ(PowerSave-POLL)֡��RTS��CTS��ACK���޾�������(CF-END,Contension-Free-END)AP��PCFģʽ�¿�������STA���ŵ�����ģʽ���Ż��޾����ڲ����ĸ��Ͽ���֡(CF-END��CF-ACK)  
CF-END��ʾPCF���ܽ�����CF-ACK��ʾPCF�µ�ACK�ظ���CF-POLL��ʾPCF�µ�������ѯ

����֡(Data)����������֡�⣬Ҳ�����Ƶģ���PCF�µ�Data + CF-Ack��Data+CF-end�� Data + CF-Ack + CF-Pol������Qos������֡(QoS Data)����PCF�µ�(QoS Data + CF-Ack)�ȡ�





Duration/ID���ڸ���NAV������AID���ڱ�ʾAP��STA֮�������ID;  
Address��BSSID��Destination Adress��Source Adress��Reciever Adress��Transmitter Adress����һ��ȫ���С�  
Qos��ʾ���ݰ����ȼ�  
HtControl��ʾ��HTģʽ��һЩ����  
FrameBody��󳤶��ڲ�ͬ�汾�²�ͬ��80211a/g��󳤶�Ϊ2312��n��󳤶�Ϊ7951  
Sequence Control����Ƭ��źͶ�����š�
FCS��У��  




![control_field](./picture//control_field.JPG)
����鿴80211-2012-p480  
ProtocolVersion��ʾЭ��汾  
Tpye��Subtype�涨֡���ͣ�
To DS��From DS��ʾ֡���䷽�򣬰�DS����AP��00��ʾStation֮���AD Hoc���Ƶ�ͨ�ţ����߿����졢������;01��ʾSta���յ�֡��10��ʾSta���͵�֡��11��ʾ�����Ž����ϵ�֡��  
�����ݻ����֡��MoreFragΪ1ʱ��ʾ֮���и����Ƭ��������Ϊ0  
RetryΪ1ʱ��ʾ�����ݻ����֡�У�����һ���ش�֡��������Ϊ0
PowerManagement��ʾ��������ģʽ����BSS��Mesh�в�ͬ�Ķ��壬��Э��  
MoreData���ڱ�ʾSTA��PSģʽ�Ƿ��и��໺�����ݵȴ����䣬����ʡ�����  
ProtectedFrame����ָʾFrameBody�Ƿ񾭹�����ѧ���ܷ�װ

����֡�о���ĸ�ʽ��CTS��RTS��ACK��������Ҫ��RTS��CTS��ACK��  
![RTS](./picture/RTS_frame.JPG)
![CTS](./picture/CTS_frame.JPG)
![ACK](./picture/ACK_frame.JPG)
![PS-PLL](./picture/PS-PLL.JPG)

#################################
Qos��HT Control����ϸ����
#################################


## wifi ���幤�̽ṹ

### sdr����
����of_match_tableƥ���豸��ƥ����������������豸����Ӧ�Ľڵ��¡�

### ps�����Ľӿ�
S_AXI_ACP��interconnect2 ����dma1������side_ch�����ݲɼ�

S_AXI_HP3��interconnect0 ����dma0������tx_intf,�������ݴ洢

M_AXI_GP0��axi_ad9361,axi_gpreg

M_AXI_GP1����ģ����߸�IP��




### ʱ�Ӻ���������
ps���  FCLK_CLK0 100Mhz -ps_clk -xpu
        FCLK_CLK1 200Mhz -axi_ad9361_delayclk(7 series)
        FCLK_CLK2 125Mhz



axi_ad9361����160MHZdata_clk,���l_clk 160Mhz��Ƶ��40Mhz��Ϊadc,dacIP�˵�ʱ�ӣ�������ģ��adc_clk
40Mhz��Ƶ��100Mhz������ģ��m_axi_mm2s_aclk



openwifi��ģ������
ps_clk 100Mhz
adc_clk 40Mhz
m_axi_mm2s_aclk 100Mhz





## tx_intf
�ϲ����ݴ�dma0������s00_axis��Ϊ��������

### ��������ӿ�
dac_rst:������˸�λ�ź�
dac_clk��40Mhz������axi_ad9361��L_clk����Ƶ���γ�adc_clk

### tx_intf_s_axis_i module
��s00_axis���߰����ݴ�dma��������
����4��xpm_fifo_sync���ڴ洢���ݶ��У����ݶ������������ش���
�����ӵ�pl��dma�����ݣ�dma��һͷ����psͨ��dma������psͨ�ţ�dma�͸�ģ��ʵ��pl��ps֮���ͨ��
��������DATA_TO_ACC���


### tx_bit_intf_i module      xxxxxxxx���ӣ�����
��ؼ���ģ�飬���ƽ������������MAC����
���ݾ��������ж�ѡ������һ��˫�˿�xpm_memory_tdpram��1024��64��С,������64λdouta��64λ����data_to_acc��data_to_acc�����������ݣ���󽻸�openofdm_tx�������




### ���� edge_to_flip module 
û�ã�ֻ��led��ʾ��־λ��û������



### dac_intf module 
�������ת����ad9361

### tx_iq_intf module
���뷢������ݣ�����ѡ��ʹ�����Ƿ�ѡ��������ݣ������dac������



### tx_status_fifo_i module
һЩ����״̬������ʱ


### tx_interrupt_selection module
����״̬�ն�����


## openofdm_tx  
��Ҫ����dot11_txģ�����״̬��״̬������֡
### ��������ӿ�
(
  input  wire        clk,//100M 
  input  wire        phy_tx_arest,//fromPS���FCLK2�ĸ�λ�ź�

  input  wire        phy_tx_start,//from tx_intf��tx_bit_intfģ�����phy_tx_start
  output reg         phy_tx_done,//dot11�������һ������֡
  output reg         phy_tx_started,//dot11����ʼ���һ������֡

  input  wire [6:0]  init_pilot_scram_state,
  input  wire [6:0]  init_data_scram_state,

  input  wire [63:0] bram_din,
  output reg  [9:0]  bram_addr,

  input  wire        result_iq_ready,
  output wire        result_iq_valid,
  output wire [15:0] result_i,//���I·���ݣ�����tx_intf��tx_iq_intf
  output wire [15:0] result_q
);

state1��signal��ht_signal����֡
state11��data����֡
state2�����ź�ľ������ס���֯����Ƶ�����IFFT
state3������������ݵ����

### ��state3����
�յ���ʼ�źź��S3_WAIT_PKT״̬����S3_L_STF
����ü򵥵Ĳ��ұ�ģ��l_stf_rom����ת��Ϊ����16λi��qǰ�����ݣ�����160samples�����S3_L_LTF
����ü򵥵Ĳ��ұ�ģ��l_ltf_rom����ת��Ϊ����16λi��qǰ�����ݣ�����160samples����sym�����S3_L_SIG


S3_L_SIG��֡��
��plcp_bit������ȡbram_dinǰ[0:23]Ϊsignal���趨��Ӧ�������������bram_din[24]�ж�PKT����ΪLEGACY��HT(DATA service��ͷΪ0��HT signalͷΪ1)��LEGACY�����S1_DATA״̬��HT�����S1_HT_SIG��








## rx_intf

### adc_intf module
����adc_data��������ѡ���Ƿ�����һ·->adc_data_internal
��һ����ʱģ��->adc_data_delay
���첽xpm fifo(д40Madcʱ�ӣ�дʹ��20MHz,��100Mm_axis_clk)Ϊ100Mhz��data_to_acc_internal
��bb_gain����λ����ԭ��12λ��9361���ݷ�����չ��Ϊ16λ->ant_data_after_sel(data_to_bb)


�ж��Ƿ�ѡ�񱾵ػػ���ѡ��tx_intf���ݺ�ant_data_after_sel,->bw20_i0,q0,i1,q1

### rx_iq_intf
�Ѿ�������·����ƥ��->rf_i0_to_acc,
sample0 = {rf_i0_to_acc,rf_q0_to_acc}����Ϊ��������
sample1 = {rf_i1_to_acc,rf_q1_to_acc}������Ϊ�ɼ�����



### byte_to_word_fcs_sn_insert module
input ofdm_rx���ջ��������8λbyte_out���ݣ�ת��Ϊaxis���ߴ����64λ����



## ofdm_rx
### �ź�
��������rx_intf��32λsample0��ΪIQ���ݣ������������8λbyte_out��rx_intf��pl_to_m_axisģ���xpu��rx_parseģ��



### dot11���ջ�״̬��
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
����У׼���rssi�������޺����sync_short״̬,  


#### sync_short
����WIFI����֡ͷ����Ƶƫ����
2��16λ��IQsample�ź�sample_in[31:0]
complex_to_mag_sq   ģ����㵥���źŷ���ƽ��(input,sample_in),���truncate��(output)32λmag_sq[31:0]�������/2  
mag_sq_avg_inst     ����(16��)�����ź�(input)mag_sq����ƽ��ƽ��mag_sq_avg[31:0]��Ĭ��3/4mag_sq_avg��Ϊ�о�����  
sample_delayed_inst �ӳ�16�����������sample_delayed[31:0],���㸴����sample_delayed_conj
delay_prod_inst     ������16�ĵ㳤�Ķ�ѵ������(input,sample_in,sample_delayed_conj)���ֵ�����prod[63:0],��λΪI����ȡ��1/2��  
delay_prod_avg_inst     ��(input)prod��16��ƽ��������������⣬���prod_avg[63:0]
delay_prod_avg_mag_inst   (input)prod_avgת��Ϊƽ������,(output)delay_prod_avg_mag��Ϊ�ж�ֵ��sqrt(i^2+q^2)��dsp trick ,Mag ~=Alpha*max(|I|,|Q|) + Beta*min(|I|,|Q|),�о����Ը���һ��

freq_offset_inst    prod��64��ƽ�������ƽ�����IQֵ������Ƶƫ��������ʾΪ�нǣ�����phase_inst���ұ����-pi~pi����λ�Ǻ󣬽���sync_short�����16���õ�2pifT,����������Ը������

����L_STF������:��ƽ�������ֵ��������������޺󣬸�������100���������ݸ���������1/4


#### phase_inst
512λ���ұ����0~pi/4��Χ���������0.0878��
����32λI��Q�����[-pi,pi]������[-1608,1608]
sync_short�׶Σ���short����2pi*f*16*TƵƫ���ҽǶȺ��ٴ�����short�����������16�õ�2pifT�����֡�


#### sync_long 
֡ͬ��ϸ��⣬��λ������FFT�任

��dot11�Ӽ�⵽��ͬ�����к���ת��sync_long��
��sync_long��ÿ����������dpram���棬���µ�ַ�����ڲ���ltf��ʼ��ַ��
����S_SKIPPING��L_STF��β��(����LTF��CP)������32�㻥�������λ�Ĵ�洢����λΪ�������ݣ���8�������˷�����4�����32��ͱ���L_LTF�Ļ����ֵ���ҳ���ֵ���ַ����addr1
S_WAIT_FOR_FIRST_PEAK:
����88����ֱ��ָʾ��⵽L_LTF???














## xpu
### �ź��������
�� Linux �ں˵� mac80211 ��ϵͳ�У������ź���Ϣ��ͨ�� struct ieee80211_rx_status �ṹ�崫�ݸ� MAC ��ġ�������һЩ�ؼ��ֶΣ�

�ֶ���	����
signal	�����ź�ǿ�ȣ�RSSI������ dBm Ϊ��λ��
snr	����ȣ�SNR������ dB Ϊ��λ��
freq	�����źŵ�Ƶ�ʡ�
rate	����֡��������Ϣ���� MCS ��������
flag	��־λ������ָʾ֡��״̬�����Ƿ�ɹ����ա��Ƿ���ܵȣ���
chains	��������������Ϣ������ MIMO����
chain_signal	ÿ�����������ź�ǿ�ȣ����� MIMO����
rx_flags	����֡�ı�־λ�����Ƿ�ʹ�ö�ǰ���룩��

struct ieee80211_rx_status {
	u64 mactime;
	u64 boottime_ns;
	u32 device_timestamp;
	u32 ampdu_reference;
	u32 flag;
	u16 freq;
	u8 enc_flags;
	u8 encoding:2, bw:3;
	u8 rate_idx;
	u8 nss;
	u8 rx_flags;
	u8 band;
	u8 antenna;
	s8 signal;
	u8 chains;
	s8 chain_signal[IEEE80211_MAX_CHAINS];
	u8 ampdu_delimiter_crc;
};


### mac
![mac_state](./picture/mac_state.JPG)
��ͬ״̬���ܹ����͵�MAC֡���Ͳ�ͬ������state1��ֻ�ܷ���Class 1��֡��
![mac_class1](./picture/MAC_class1.JPG)
![mac_class2](./picture/MAC_class2.JPG)
![mac_class3](./picture/MAC_class3.JPG)


![mac_frame_format](./picture//mac_frame_format.JPG);
![control_field](./picture//control_field.JPG)
Address 2, Address 3, Sequence Control, Address 4,��Frame Body�ֶ�ֻ��ĳЩ֡�г���

Type(management,control,data)��Subtype�ֶι�ͬ����MAC֡���ͣ�To DSΪ1���ʾ֡����DS(distributing system����AP),From DS��ʾ����DS


![duration_field](./picture/duration_field.JPG)

duration��ʾ ΢��

Address��
���ܰ���BSSID��һ�����������ɵ�46λ�����
DA(Destination Address),SA(Source Address),RA(Receiver Address),TA(Transmitter Address),

Sequence Control:
����Sequence Number��Fragment Number��Sequence Number��12λ��ʶMSDU��ţ�Fragment Number��4λ��ʶMSDU��Ԫ��Ƭ�α��

FCS��
32λCRC

#### control frames
RTS֡
![RTS_frame](./picture/RTS_frame.JPG)
CTS֡
![CTS_frame](./picture/CTS_frame.JPG)
ACK֡
![ACK_fram](./picture/ACK_frame.JPG)
����PS-Poll(Power-Save Poll)��CF-End(contension Free-End)��CF-ACK�ȵ�


#### data frames

![DATA_frames](./picture/DATA_frames.JPG)



#### management frames

![management_frames](./picture/management_frames.JPG)
��Beacon֡��IBSS ATIM֡(Announcement Traffic Indication Message)֡��Disassociation֡��Association Request��Association Response��Reassociation Request��Reassociation Response��Probe Request֡�ȵȡ�



### ���ƴ��
csma/ca���������ز������������ز������������ز���������ccaʵ�֣������ز�����ͨ��mac֡��nav�ֶ�ʵ��

�����ز�����Ϊ����ʱ��nav��slottimeΪ��λ���ˣ��ŵ�����ʱ��Ϊæ��nav��ͣ����




### rssi
ad9361��ʵʱagc_gain״̬ͨ��8��gpio_out��pins����fpga��gpio_status_rf��rx_intfת����rx_intf_bb����ʱ�����ź�
�ò����õ���iqֵ����iq_rssi_half_db���ֶ����Ե�����correction,����9361ʵʱ�����gpio_status��
����slv_reg57,
{gpio_status_delay[6:0],iq_rssi_half_db,1'b0,(~ch_idle_final),(tx_core_is_ongoing|tx_bb_is_ongoing|tx_rf_is_ongoing|cts_toself_rf_is_ongoing|ack_cts_is_ongoing), demod_is_ongoing,(~gpio_status_delay[7]),rssi_half_db};//rssi_half_db 11bit, iq_rssi_half_db 9bit
iq_rssi_half_db = 115;ֵ
rssi_half_db_offset = 150;hardware_gain
gpio_status = 96;agc_control
ʵʱ��rssi_half_dB = 168
����ʵʱ��У׼rssi

rssi_half_db == ����IQ����iq_rssi_half_db - agc���� + ��ͬƵ���²����õ���ad9361ƫ����У׼


output rssi_half

### cca
�ȽϽ����ź�ǿ�Ⱥ��ź�ǿ����ֵ��������ݰ��Ľ���״̬�ͷ���״̬��ȷ���ŵ��Ƿ����
����������ޣ�rssi_half_db_th = 87<<1; // -62dBm
�ڽ����������ʱ��ȴ�7.5us,
assign ch_idle_rssi = (is_counting?1:( (rssi_half_db<=rssi_half_db_th) && (~demod_is_ongoing) ));
ch_idle = (ch_idle_rssi&&(~tx_rf_is_ongoing)&&(~cts_toself_rf_is_ongoing)&&(~ack_cts_is_ongoing))
���ź�ǿ�ȸ������ޣ�����������С��������Ƶ�������С�û���ڷ�cts_toself��Ҳû���ڻ�ӦACKʱ���ch_idle��ʾ�ŵ�����

### tx_on_detection
����һЩ�����õ��������ʱ���������Ƶ֮�䴫���ʱ�ӡ���Ƶ�رպ��ӳ���ʱ�䡢�������俪ʼ������ͨ�������������������������ͨ���رգ�����openwifiģ���ڷ����һЩ״̬��outputһЩָʾ����״̬�ı�־��
���ݴ�tx_intf��txģ������ķ������״̬��־�źţ������������ʱ�����һЩ״̬��־�ź�
tx_core_is_ongoing��txģ�����ڽ��У�change 1st
tx_bb_is_ongoing��tx_intf���ڽ��У������Ѿ�����tx_iq_intf��fifo��2nd
tx_rf_is_ongoing��rf�Ѿ�����ʱ���ֶ�������ʱȷ����־λ��4th
tx_chain_on��bb״̬���ֶ�������ʱ��ȷ����9361��״̬�л�spiд���־��3rd



### cw_exp
input����tx_bit_intf��tx_queue_idx��ͬ�����cw���ڳ���
if����������ͬ�����Է�����ɡ��˳��ش�����������cw��������С��
    else {if�ش���������С����󴰿�ʱ
        cw_exp+1
        else
        cw_exp���ֲ���
        }

















