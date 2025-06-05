# dot11 read notes




IP��->MSDU->MPDU(MAC��)->PLCP->PSDU>phy
### mac��

![mac_frame_format](./picture//mac_frame_format.JPG);
![control_field](./picture//control_field.JPG)

������·���ΪLLC��Logical Link Control���߼���·���ƣ��Ӳ㼰MAC��Media Access Control��ý����ʿ��ƣ��Ӳ㡣�ϲ����ݱ��ƽ���LLC�Ӳ���ΪMAC�������ݵ�Ԫ����MSDU��MAC Service Data Unit��������LLC��MSDU���͵�MAC�Ӳ����Ҫ��MSDU����MAC��ͷ��Ϣ������װ���MSDU��ΪMACЭ�����ݵ�Ԫ����MPDU��MAC Protocol Data Unit������ʵ������802.11MAC֡��802.11MAC֡�����ڶ��㱨ͷ��֡���弰֡β


### �����
��������·�����ƣ������Ҳ��Ϊ�����Ӳ㡣�ϲ�ΪPLCP��Physical Layer Convergence Procedure���������Э�飩�Ӳ㣬�²�ΪPMD��Physical Medium Dependent������ý����أ��Ӳ㡣PLCP�Ӳ㽫������·�㴫��������֡�����PLCPЭ�����ݵ�Ԫ��PLCP Protocol Data Unit��PPDU�������PMD�Ӳ㽫�������ݵ��ƴ��������ط�ʽ���д��䡣
PLCP���յ�PSDU��MAC���MPDU����׼��Ҫ�����PSDU��PLCP Service Data Unit ,PLCP�������ݵ�Ԫ����������PPDU����ǰ�����ֺ�PHY��ͷ��ӵ�PSDU�ϡ�ǰ����������ͬ��802.11���߷���ͽ�����Ƶ�ӿڿ�������PPDU��PMD�Ӳ㽫PPDU���Ƴ�����λ��ʼ���䡣






###### MPDU
���������簲ȫ�У�MSDU��Ethernet���ģ��������������У��MIC����֡��ʡ��ģʽ�±��Ļ��桢���ܡ����кŸ�ֵ��CRCУ�顢MACͷ֮���ΪMPDU��MPDU���� ָ�ľ���802.11Э���װ��������֡��A-MSDU������ָ�Ѷ��MSDUͨ��һ���ķ�ʽ�ۺϳ�һ���ϴ���غɡ�ͨ������AP �����߿ͻ��˴�Э��ջ�յ����ģ�MSDU��ʱ�������Ethernet����ͷ����֮ΪAMSDUSubframe����A-MSDU����ּ�ڽ����ɸ�A-MSDUSubframe����802.11Э��� ʽ����װ��һ��MPDU���ĵ�Ԫ
(��������·�㽻��������DATA)

plcp(physical layer converge protocol)��</br>
ppdu(physical layer protocol data unit)��</br>
psdu(physical service data unit)</br>
PLCP ���Կ��� PPDU �� Header ���֣������� MCS��data rate ����Ϣ���� PSDU ������ʵ�ʴ� MAC ��õ���Ҫ��������ݣ�PPDU ���� PLCP+PSDU





### �������
![�������.JPG](./picture/�������.JPG);
a/g����20Mhz����n֧��ĳЩ40M���ŵ�

![rate_parameters.JPG](./picture/rate_parameters.JPG);




## 802.11n�ṹ
mixed modeΪǿ��֧��,n�����a������ht����ַ�
![80211nframe_structure.JPG](./picture/80211nframe_structure.JPG);
80211a��PPDU��ʽ
![PPDU_structure.JPG](./picture/PPDU_structure.JPG);

## L-STF:
2��sym��160samples,
һ��L-STF16�����㣬�ܹ�16*10=160samples��Ƶ������,��������Ӧ���ز�λ������64��IFFT����ȡǰ16������ʱ��㣬������
![L_STF_IFFT.JPG](./picture/L_STF_IFFT.JPG);

## L-LTF:
2��sym,16+16+64+64=160samples��
Ƶ�����ɣ���STF��ͬ��64��IFFT���õ�64ʱ��㣬������
![L_LTF_IFFT.JPG](./picture/L_LTF_IFFT.JPG);


## L_signal
1��sym��(24*2+4+12)+16=80samples
bit0-3��ʾRATE�������ʣ�HTģʽĬ��6Mbps��
bit4����Ϊ0,
bit5-16,LENGTH��ʾ�޷���MAC�������PSDU���ֽ�����bit17Ϊǰ17����żУ��λ��LSB�ȷ���
6��bit��tail����Ϊ0,
�����м��ţ�
�����Ч��1/2��bpsk���ƣ������д�ף���6Mbps�����ʷ���
![legacy_signal.JPG](./picture/legacy_signal.JPG);


## ht-signal
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
## ht-stf
1��sym,5*16=80samples
���ڸĽ�mimoϵͳ�е��Զ�������ƣ�
20Mhz���к�l-stfһ����40Mhzͨ����20MHz�����з�ֵ����ת�ϰ벿�ֵ����ز�
��ʱû��ʵ��40Mhz�ģ�����mimo
![ht_stf.JPG](./picture/ht_stf.JPG);

## ht-ltf
������ֻ����һ��sym��80samples



ǰ�湲��720��samples��һ��sym��legacy_siganl,2��sym��ht_signal������Ϊ�̶�����




## DATA��
## service
16bit��bit0-6 set to 0������ͬ��������;bit7-15 reserved to 0

## PSDU


## tail
6bit,ȷ�������������������״̬

## pad
����λ��������䵽��OFDM����
![���Ÿ���.JPG](./picture/���Ÿ���.JPG);



## ����㷢��������̿�ͼ
![phy.JPG](./picture/phy.JPG);


# �����״̬��
<!-- ![dot11_tx_state_machine.JPG](./picture/dot11_tx_state_machine.JPG); -->



state1��signal��ht_signal����֡
state11��data����֡
state2�����ź�ľ������ס���֯����Ƶ�����IFFT
state3������������ݵ����