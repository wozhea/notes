���壺
���˻�ȺԶ��������֯�������磬������·Э��������㣬��̬·��Э��
CSI��֪

## wifi�ṹ
![whole](./picture/structure.JPG)  
���û��ռ����sdr��������FPGA������·��һ·��Ӧ������ͨ��ϵͳ���ã����׽��ֵ�����Э�飬���豸�ӿڣ����������֡����mac80211����һ·��ר�Ŷ�wifi���й���Ĺ��ߣ���wpa_supplicant,hostapd,iwconfig�ȣ���linux�ں˿ռ�nl80211��cfg80211Э��ջ���û��ռ������ͨ��netlink�׽��ִ��ݸ��ںˣ�nl80211��һ��netlinkЭ�飬רΪ�������������ƣ����û��ռ������ת��Ϊ�ں��ܹ����ĸ�ʽ����󽻸�mac80211��  
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
plcp(physical layer converge protocol);  
ppdu(physical layer protocol data unit);  
psdu(physical service data unit)  

### ���ݰ����
![layer_pdu](./picture/layer_pdu.JPG)
IP��->MSDU->MPDU(MAC��)->PLCP->PSDU>phy
���������簲ȫ�У�MSDU��Ethernet���ģ��������������У��MIC����֡��ʡ��ģʽ�±��Ļ��桢���ܡ����кŸ�ֵ��CRCУ�顢MACͷ֮���ΪMPDU��MPDU����ָ�ľ���802.11Э���װ��������֡��A-MSDU������ָ�Ѷ��MSDUͨ��һ���ķ�ʽ�ۺϳ�һ���ϴ���غɡ�ͨ������AP�����߿ͻ��˴�Э��ջ�յ����ģ�MSDU��ʱ�������Ethernet����ͷ����֮ΪAMSDUSubframe����A-MSDU����ּ�ڽ����ɸ�A-MSDUSubframe����802.11Э��� ʽ����װ��һ��MPDU���ĵ�Ԫ(��������·�㽻��������DATA)  
PLCP ���Կ��� PPDU �� Header ���֣�����MCS��data rate ����Ϣ����PSDU������ʵ�ʴ� MAC ��õ���Ҫ��������ݣ�PPDU���� PLCP+PSDU

### MAC��֡�ṹ
������·���ΪLLC��Logical Link Control���߼���·���ƣ��Ӳ㼰MAC��Media Access Control��ý����ʿ��ƣ��Ӳ㡣�ϲ����ݱ��ƽ���LLC�Ӳ���ΪMAC�������ݵ�Ԫ����MSDU��MAC Service Data Unit��������LLC��MSDU���͵�MAC�Ӳ����Ҫ��MSDU����MAC��ͷ��Ϣ������װ���MSDU��ΪMACЭ�����ݵ�Ԫ����MPDU��MAC Protocol Data Unit������ʵ������802.11MAC֡��802.11MAC֡�����ڶ��㱨ͷ��֡���弰֡β  

![mac_state](./picture/mac_state.JPG)  
��ͬ״̬���ܹ����͵�MAC֡���Ͳ�ͬ������state1��ֻ�ܷ���Class 1��֡��  
![mac_class1](./picture/MAC_class1.JPG)  
![mac_class2](./picture/MAC_class2.JPG)  
![mac_class3](./picture/MAC_class3.JPG)  
![mac_frame_format](./picture//mac_frame_format.JPG);  
![control_field](./picture//control_field.JPG)  
Address 2, Address 3, Sequence Control, Address 4,��Frame Body�ֶ�ֻ��ĳЩ֡�г���

Type(management,control,data)��Subtype�ֶι�ͬ����MAC֡���ͣ�To DSΪ1���ʾ֡����DS(distributing system����AP),From DS��ʾ����DS
![duration_field](./picture/duration_field.JPG)duration��ʾ ΢��

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
CTS/RTS����ÿ֡����Ҫ�������ӣ����ڹ������ݳ��ȵ�֡����û��rts/cts�������û��ƿ�����dot11RTSThreshold attribute��Ϊalways��never��or ����length threshold
CTS/RTS֡����duration�ֶΰ��������ACK����ռ���ŵ�ʱ��(us)�����Ա�����sta���գ���������ÿ��sta��nav���ȣ�

#### data frames
![DATA_frames](./picture/DATA_frames.JPG)
#### management frames
![management_frames](./picture/management_frames.JPG)
��Beacon֡��IBSS ATIM֡(Announcement Traffic Indication Message)֡��Disassociation֡��Association Request��Association Response��Reassociation Request��Reassociation Response��Probe Request֡�ȵȡ�




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


### �����
��������·�����ƣ������Ҳ��Ϊ�����Ӳ㡣�ϲ�ΪPLCP��Physical Layer Convergence Procedure���������Э�飩�Ӳ㣬�²�ΪPMD��Physical Medium Dependent������ý����أ��Ӳ㡣
PLCP�Ӳ㽫������·�㴫��������֡�����PLCPЭ�����ݵ�Ԫ��PLCP Protocol Data Unit��PPDU�������PMD�Ӳ㽫�������ݵ��ƴ��������ط�ʽ���д��䡣PLCP���յ�PSDU��MAC���MPDU����׼��Ҫ�����PSDU��PLCP Service Data Unit ,PLCP�������ݵ�Ԫ����������PPDU����ǰ�����ֺ�PHY��ͷ��ӵ�PSDU�ϡ�ǰ����������ͬ��802.11���߷���ͽ�����Ƶ�ӿڿ�������PPDU��PMD�Ӳ㽫PPDU���Ƴ�����λ��ʼ���䡣

## wifi ���幤�̽ṹ
### sdr����
����of_match_tableƥ���豸��ƥ����������������豸����Ӧ�Ľڵ��¡�
### verilog
#### ps�����Ľӿ�
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
## openofdm_tx  
### �������
![�������.JPG](./picture/�������.JPG);
a/g����20Mhz����n֧��ĳЩ40M���ŵ�
![rate_parameters.JPG](./picture/rate_parameters.JPG);
#### 802.11n�ṹ
mixed modeΪǿ��֧��,n�����a������ht����ַ�
![80211nframe_structure.JPG](./picture/80211nframe_structure.JPG);
80211a��PPDU��ʽ
![PPDU_structure.JPG](./picture/PPDU_structure.JPG);
#### L-STF:
2��sym��160samples,
һ��L-STF16�����㣬�ܹ�16*10=160samples��Ƶ������,��������Ӧ���ز�λ������64��IFFT����ȡǰ16������ʱ��㣬������
![L_STF_IFFT.JPG](./picture/L_STF_IFFT.JPG);

#### L-LTF:
2��sym,16+16+64+64=160samples��
Ƶ�����ɣ���STF��ͬ��64��IFFT���õ�64ʱ��㣬������
![L_LTF_IFFT.JPG](./picture/L_LTF_IFFT.JPG);


#### L_signal
1��sym��(24*2+4+12)+16=80samples
bit0-3��ʾRATE�������ʣ�HTģʽĬ��6Mbps��
bit4����Ϊ0,
bit5-16,LENGTH��ʾ�޷���MAC�������PSDU���ֽ�����bit17Ϊǰ17����żУ��λ��LSB�ȷ���
6��bit��tail����Ϊ0,
�����м��ţ�
�����Ч��1/2��bpsk���ƣ������д�ף���6Mbps�����ʷ���
![legacy_signal.JPG](./picture/legacy_signal.JPG);


#### ht-signal
2��sym��160samples
48�����ݵ�(96�������)�����⵽rateΪ6M�����L-SIG��HT-SIG��BPSK�����㣬L-SIGΪ0,1ͬ�࣬HT-SIGΪ�������������������������ͬ�࣬

![ht_signal.JPG](./picture/ht_signal.JPG);
MCS: only supports 0 - 7.
CBW 20/40: channel bandwidth. OpenOFDM only supports 20 MHz channel (0).
Reserved: must be 0.
STBC: number of space time block code. OpenOFDM only supports 00 (no STBC).
FEC coding: OpenOFDM only supports BCC (0).
Short GI: whether short guard interval is used.
Number of extension spatial streams: only 0 is supported.
CRC: checksum of previous 34 bits.
Tail bits: must all be 0
MCS��7bit����0-76�е�ĳһ������ʾ���������ֶεĵ��Ʊ��뷽��
20/40MHz��1bit��������ָʾ���͵���20MHz����40MHz����
���ȣ�16bit����ָʾ���ݵĳ���
ƽ����1bit�����ڽ���Tx�������ͺͿռ���չ�󣬵õ�������ͽ��ջ�֮����ŵ����Գ���800ns�����ӳٴ���ɽ���������ز�������ԡ�ĳЩTx��������Ҳ�ᵼ���������ز�����λ�Ĳ���������ʹ�����ز�ƽ������ʱ������������������ŵ����ơ�������������£������Ӧ�ý�ƽ����������Ϊ0����֪ͨ���ջ�ֻ����ÿ�ز��ŵ����ơ�
��̽�⣨1bit������Ϊ0ʱ���͵���̽����顣̽����������ռ�Tx�������ͺ���·��Ӧ���ŵ�״̬��Ϣ��Ϊ�˽�̽����չ�������ֶ�֮��Ķ���ռ����ϣ���չ�ռ������ֶ������ֵ����0��
����λ��1bit��
�ۺϣ�1bit������ʾ��Ч�غɰ�������MPDU��Ϊ0����һ��MPDU�ۺϣ�Ϊ1����
STBC��2bit������ʾSTBC������ά��
FEC���루1bit����Ϊ0ʱ��ʾ����ΪBCC���룬Ϊ1ʱ��ʾ����ΪLDPC���롣
��GI��1bit����Ϊ1ʱ��ʾʹ��400ns�̱��������Ϊ0ʱ��ʾʹ��800ns��׼�����������
��չ�ռ�������1bit��������̽��������
CRC��8bit�������ɶ���ʽΪG(D)=D^8+D^2+D^1+1
ht_crc����![ht_crc.JPG](./picture/ht_crc.JPG);
#### ht-stf
1��sym,5*16=80samples
���ڸĽ�mimoϵͳ�е��Զ�������ƣ�
20Mhz���к�l-stfһ����40Mhzͨ����20MHz�����з�ֵ����ת�ϰ벿�ֵ����ز�
��ʱû��ʵ��40Mhz�ģ�����mimo
![ht_stf.JPG](./picture/ht_stf.JPG);

#### ht-ltf
������ֻ����һ��sym��80samples
ǰ�湲��720��samples��һ��sym��legacy_siganl,2��sym��ht_signal������Ϊ�̶�����
#### DATA��
#### service
16bit��bit0-6 set to 0������ͬ��������;bit7-15 reserved to 0
#### tail
6bit,ȷ�������������������״̬

#### pad
����λ��������䵽��OFDM����
![���Ÿ���.JPG](./picture/���Ÿ���.JPG);
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
### verilog
�ϲ����ݴ�dma0������s00_axis��Ϊ��������
#### ��������ӿ�
dac_rst:������˸�λ�ź�
dac_clk��40Mhz������axi_ad9361��L_clk����Ƶ���γ�adc_clk
#### tx_intf_s_axis_i module
��s00_axis���߰����ݴ�dma��������
����4��xpm_fifo_sync���ڴ洢���ݶ��У����ݶ������������ش���
�����ӵ�pl��dma�����ݣ�dma��һͷ����psͨ��dma������psͨ�ţ�dma�͸�ģ��ʵ��pl��ps֮���ͨ��
��������DATA_TO_ACC���
#### tx_bit_intf_i module      xxxxxxxx���ӣ�����
��ؼ���ģ�飬���ƽ������������MAC����
���ݾ��������ж�ѡ������һ��˫�˿�xpm_memory_tdpram��1024��64��С,������64λdouta��64λ����data_to_acc��data_to_acc�����������ݣ���󽻸�openofdm_tx�������
#### ���� edge_to_flip module 
û�ã�ֻ��led��ʾ��־λ��û������
#### dac_intf module 
�������ת����ad9361
#### tx_iq_intf module
���뷢������ݣ�����ѡ��ʹ�����Ƿ�ѡ��������ݣ������dac������
#### tx_status_fifo_i module
һЩ����״̬������ʱ
#### tx_interrupt_selection module
����״̬�ն�����

## rx_intf
### ����
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
### verilog
#### adc_intf module
����adc_data��������ѡ���Ƿ�����һ·->adc_data_internal
��һ����ʱģ��->adc_data_delay
���첽xpm fifo(д40Madcʱ�ӣ�дʹ��20MHz,��100Mm_axis_clk)Ϊ100Mhz��data_to_acc_internal
��bb_gain����λ����ԭ��12λ��9361���ݷ�����չ��Ϊ16λ->ant_data_after_sel(data_to_bb)


�ж��Ƿ�ѡ�񱾵ػػ���ѡ��tx_intf���ݺ�ant_data_after_sel,->bw20_i0,q0,i1,q1

#### rx_iq_intf
�Ѿ�������·����ƥ��->rf_i0_to_acc,
sample0 = {rf_i0_to_acc,rf_q0_to_acc}����Ϊ��������
sample1 = {rf_i1_to_acc,rf_q1_to_acc}������Ϊ�ɼ�����

#### byte_to_word_fcs_sn_insert module
input ofdm_rx���ջ��������8λbyte_out���ݣ�ת��Ϊaxis���ߴ����64λ����



## ofdm_rx

### verilogģ��
#### dot11���ջ�״̬��
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
#### �ź�
��������rx_intf��32λsample0��ΪIQ���ݣ������������8λbyte_out��rx_intf��pl_to_m_axisģ���xpu��rx_parseģ��
#### watchdog design
input:enable���ջ��������״̬ǰʹ�ܣ�iq_data,dc_running_sum_thֱ��ƫ�����ޣ�power_trigger������ⴥ����min/max_signal_len_th�����źų������ޣ�signal_len���ջ�����źų���
output:receiver_rst���ڸ�λwifi���ջ����쳣״̬��λ

receiver_rst_internal�����������ݷ���λ����32��ƽ��������ֱ����������Ϊ0����ѡ��-1��1�����쳣����ֱ������������ֵ����λ��
power_trigger�����ջ�������������������ޣ���λ
equalizer_monitor_rst����������һ������ͼ����ֵ��С���޷��������λ
signal_len_rst�����������signal���ڻ�С��Э��涨���ȡ���λ��

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
#### equalizer module
input��������Ƶͬ����sync_long_out����λ����eq_phase_out,
output������equalizer_out
�ж��Ƿ񾭹�
��Ƶ�ŵ�����


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


### verilog
#### csma/ca 
80211-2012,9.2,9.3
80211-2012,362ҳ,������ʱ���л���ʱ��ԭ�ﶨ��
80211-2012,843ҳ��IFS֮�����͹�ϵ

a) RIFS reduced interframe space    ��С֡������ֻ������վ
b) SIFS short interframe space  ��վ�������С֡�������տڽ������һ�����ţ����������������Ӧ֡����ͷ����̼��
c) PIFS PCF interframe space
d) DIFS DCF interframe space
e) AIFS arbitration interframe space (used by the QoS facility)
f) EIFS extended interframe space

sifs = aRXRFDelay����Ƶ�ӳ٣���aRXPLCPDelay�������ͷ�������ӳ٣���aMACProcessingDelay��MAC�㴦���ӳ٣� + aRxTxTurnaroundTime�����ͽ�������ת��ʱ�䣩
slot = �������ɾ�������Backoff����Сʱ�����������aCCATime��CCAʱ�䣩��aRxTxTurnaroundTime�����ͽ�������ת��ʱ�䣩��aAirPropagationTime�������ӳ٣���aMACProcessingDelay��MAC�㴦���ӳ٣���20us
pifs = sifs + 1*slot
difs = sifs + 2*slot,�䱾����ʵ���϶����������SIFS��Slot��һ����ϡ�

csma/ca���������ز������������ز������������ز���������ccaʵ�֣������ز�����ͨ��mac֡��nav�ֶ�ʵ��
�����ز�����Ϊ����ʱ��nav��slottimeΪ��λ���ˣ��ŵ�����ʱ��Ϊæ��nav��ͣ����
#### rssi
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
#### cca��channel assesment clear��
�������������ز�������������⼴����rssi�жϣ��ز��������Ƿ��⵽ǰ��ѵ�������жϡ�
�ȽϽ����ź�ǿ�Ⱥ��ź�ǿ����ֵ��������ݰ��Ľ���״̬�ͷ���״̬��ȷ���ŵ��Ƿ���С�ǰ�����гɹ���⣺��⵽�̳�ѵ�����С�����������ޣ�rssi_half_db_th = 87<<1; // -62dBm
�ڽ����������ʱ��ȴ�7.5us,
assign ch_idle_rssi = (is_counting?1:( (rssi_half_db<=rssi_half_db_th) && (~demod_is_ongoing) ));
ch_idle = (ch_idle_rssi&&(~tx_rf_is_ongoing)&&(~cts_toself_rf_is_ongoing)&&(~ack_cts_is_ongoing))
���ź�ǿ�ȸ������ޣ�����������С��������Ƶ�������С�û���ڷ�cts_toself��Ҳû���ڻ�ӦACKʱ���ch_idle��ʾ�ŵ�����
#### tx_control

#### tx_on_detection
����һЩ�����õ��������ʱ���������Ƶ֮�䴫���ʱ�ӡ���Ƶ�رպ��ӳ���ʱ�䡢�������俪ʼ������ͨ�������������������������ͨ���رգ�����openwifiģ���ڷ����һЩ״̬��outputһЩָʾ����״̬�ı�־��
���ݴ�tx_intf��txģ������ķ������״̬��־�źţ������������ʱ�����һЩ״̬��־�ź�
tx_core_is_ongoing��txģ�����ڽ��У�change 1st
tx_bb_is_ongoing��tx_intf���ڽ��У������Ѿ�����tx_iq_intf��fifo��2nd
tx_rf_is_ongoing��rf�Ѿ�����ʱ���ֶ�������ʱȷ����־λ��4th
tx_chain_on��bb״̬���ֶ�������ʱ��ȷ����9361��״̬�л�spiд���־��3rd
#### cw_exp
input����tx_bit_intf��tx_queue_idx��ͬ�����cw���ڳ���
if����������ͬ�����Է�����ɡ��˳��ش�����������cw��������С��
    else {if�ش���������С����󴰿�ʱ
        cw_exp+1
        else
        cw_exp���ֲ���
        }
#### tsf_timer(time syc function)
����һ������Ϊ1us��ռ�ձ�Ϊ1%��С����tsf_pulse_1M,
��linux����һ��64λ�ı�׼ʱ�䣬����1us���ٶȼ���,�²�Ϊϵͳ֮��ͬ������Ϣ��radio tap header?
#### phy_rx_parse
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
#### pkt_filter_ctl
����ĳЩ����֡�Ϳ���֡����Ϊ��fpga���ֿ���ʵ��low mac��csma������֡����Ҫ�����ϲ�mac80211����
���block_rx_dma_to_ps�źž���֡�Ƿ񽻸�rx_intf�ٸ�dma�����ϲ�
monitorģʽ�¿��ܻ�ı�frame filter�Ĺ���ͨ��sdr�����ı��־λ�ı�mac80211״̬��ͬʱ�ı�fpga����״̬
��Ҫ���linux��mac80211Э��ջ��mac֡�ṹͬʱ��
#### spi module 
����ad9361���շ�ģʽ�л���������9361��fddģʽ��ͨ��д24bit��ָ����Ʊ����Ƶ���Ŀ��أ�
ʵ�ֿ����л���tdd����ģʽ��
psѡ��SPI0_SCLK_O��SPI0_MOSI_O,SPI0_MISO_I(ֱ��9361),SPI0_SS_O����������xpu������
��˰�����źŸ���openwifi_module spi0_csn,spi0_sclk,spi0_mosi������spi����ѡ������ad9361��
