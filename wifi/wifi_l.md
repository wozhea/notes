���壺
���˻�ȺԶ��������֯�������磬������·Э��������㣬��̬·��Э��
CSI��֪

## wifi�ṹ
![whole](./picture/structure.JPG)  
���û��ռ����sdr��������FPGA������·��һ·��Ӧ�����ݣ����ȴ���һ���׽��֣�Ȼ���һ���ӿ�(�磬��̫���ӿڡ� WiFi �ӿ�)��������������д�뵽�׽��ֻ��������ٽ������������ݷ��ͳ�ȥ��Ӧ�ó������ϵͳ���ú����Ƚ����׽��ֲ㣬���������һ������Ҫ�����ݽṹ����sk_buff��һ���Ϊskb ��һ��skb�ṹ�еĳ�Ա�����Ż������ĵ�ַ�Լ����ݳ��ȡ�Ȼ��ͨ�����ӵ�����Э��㣬�����豸�޹ز㣬����ӿ�ͨ�� net_device_ops�ṹʵ�֣��ýṹ��Ӧ��net_device�ĺܶ����������mac80211������ע��ops������mac80211Ҳ���Կ�����һ�� net_device ����һ�����ݰ�ͨ�� WiFi ����ʱ����صĴ��亯�� ieee80211_subif_start_xmit�����������������֡����mac80211��ͨ�� mac80211 �е� local->ops->tx ��ע�ᵽ�豸�����еĻص��������ᱻ���ã��ص������������б����塣��һ·ͨ��ר�Ŷ�wifi���й���Ĺ��ߣ���wpa_supplicant,hostapd,iwconfig�ȣ���linux�ں˿ռ�nl80211��cfg80211Э��ջ������mac80211��  

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



## �ں˿ռ�
### nl80211
�����û��ռ����ں˿ռ�֮��� API ���������� cfg80211 ��ǰ�ˣ�Ҳ�������¼�(events) ��Ϣ����ģ������ netlink Э�����������ռ������Ϣ������ע��ΪGeneric Netlink���壩��Netlink ��һ�� Linux �е� socket ���ͣ��������ں����û��ռ�֮�䴫���¼�����������һ���ӿڣ���ֻ�Ὣ���ݰ�װΪ���ʵĸ�ʽȻ�����û����ں˿ռ����ߴ��䡣

```
֧�ֵ���Ϣ���ͣ�  
enum nl80211_commands {
    NL80211_CMD_GET_WIPHY,         // ��ѯ�����豸
    NL80211_CMD_SET_WIPHY,         // ���������豸
    NL80211_CMD_TRIGGER_SCAN,      // ����ɨ��
    NL80211_CMD_CONNECT,           // ��������
    NL80211_CMD_ROAM,              // ��������
    NL80211_CMD_FRAME,             // ���͹���֡
};
```
### cfg80211
����һ���������� WLAN �豸���м�㣬����ͨ�û��ռ����ں˿ռ�����������ں˿ռ��ṩ���ù���������ڶ������豸�������ù���ͨ���ṩһ�麯���ӿڣ�cfg80211_ops���ͽṹ�壨wiphy����Э���û��ռ������MAC�������Ӳ MAC �豸���� MAC �豸����Ҫ cfg80211 ���ܹ�����
�����豸����Ҫʹ��cfg80211����Ҫ��cfg80211��ע��һϵ��Ӳ�����ܽṹ�壬
�� mac80211 ֻ��һ������ API ����ֻ֧�����ʵ�ֵ��� MAC �豸��
��Ҫ����ְ�𣺹�����������ӿڣ�����AP��WDS�ȣ���Ƶ�׹���DFS���ŵ�ѡ�񣩣���֤����Э����WPA/WPA2����ɨ��������ͨ�Ų����������ʣ�����
```
struct cfg80211_ops {
    int (*scan)(struct wiphy *wiphy, struct net_device *dev,
                struct cfg80211_scan_request *request); // ɨ������
    int (*connect)(struct wiphy *wiphy, struct net_device *dev,
                   struct cfg80211_connect_params *sme); // ��������
    int (*disconnect)(struct wiphy *wiphy, struct net_device *dev, 
                      u16 reason_code); // �Ͽ�����


    static int __init cfg80211_init(void)
{
    // 1. ����netlink�׽��֣�nl80211��
    nl80211_socket = netlink_kernel_create(&init_net, NETLINK_GENERIC, &cfg);

    // 2. ע��sysfs�ļ�ϵͳ�ӿ�
    rc = register_netdevice_notifier(&cfg80211_netdev_notifier);

    // 3. ע��ͨ���豸����
    rc = wiphy_class_register(&wiphy_class);

    // 4. ��ʼ��RFKill��ϵͳ
    rc = rfkill_global_init();
}
};
```
### mac80211
�ṹ�� ieee80211_ops ���𽫲�ͬ�豸����ʵ�ֵĻص������� mac80211 �ṩ�� API ӳ���������������ģ�����ע��ʱ����Щ�ص������ͱ�ע�ᵽ mac80211 ����(ͨ�� ieee80211_alloc_hw ʵ��)������ mac80211 �Ͱ�����Ӧ�Ļص���������Ϊ�ں�ģ�飬ʵ��MAC���������֣��ṩӲ���������ϲ㣨cfg80211��֮���������������֪����������֣��Լ�ʵ��ϸ�ڵȡ�  
��Ҫ����ְ��802.11֡����/����������/����/����֡�������ʿ����㷨��Minstrel, PID�ȣ���QoSʵ�֣�WMM������Դ����PSM�����ۺ�֡����A-MPDU/A-MSDU��
```
ע������// ��cfg80211��ʼ��ʱ����
int __init mac80211_init(void)
{
    rc = rc80211_minstrel_init();    // ���ʿ��Ƴ�ʼ��
    rc = ieee80211_iface_init();     // ����ӿ�ϵͳ��ʼ��
    rc = rate_ctrl_register();       // ע�����ʿ����㷨
}

// ����ע��ʱ���õĺ��ĺ���
int ieee80211_register_hw(struct ieee80211_hw *hw)
{
    // ����wiphy�豸
    wiphy = wiphy_new(&mac80211_config_ops, sizeof(struct ieee80211_local));
    
    // ��ʼ���ڲ�״̬
    INIT_LIST_HEAD(&local->interfaces);
    INIT_LIST_HEAD(&local->rx_handlers);
    
    // ��cfg80211ע��
    wiphy_register(wiphy);
}

int __init mac80211_init(void)
{
    // 1. ע�����ʿ����㷨
    rc = rc80211_minstrel_init();

    // 2. ����ieee80211_wq��������
    ieee80211_wq = alloc_ordered_workqueue(...);

    // 3. ע�������豸����
    rc = register_pernet_device(&ieee80211_pernet_ops);

    // 4. ע��֡������
    rc = ieee80211_iface_init();
}
```
### sdr����
����ְ��??ֱ�ӿ�������Ӳ�����Ĵ�������/DMA���ã�������Ӳ���жϣ�����/������ɣ���ʵ��mac80211����Ĳ����ӿ�

#### ������������
1.��ȡ�豸���ڵ��of_match_node��������豸�����������Ƿ�ƥ�䣬�������������豸����Ӧ�Ľڵ��¡�
2.dev = ieee80211_alloc_hw(sizeof(*priv), &openwifi_ops)���ؼ�ע�ᣬ����IEEE802.11Ӳ������ṹ��Ϊwifi�豸����˽�����ݽṹ��*priv���ͻص�������(&openwifi_ops),�������mac80211
3.��ʼ��˽�����ݡ���1����ȡ�豸���ڵ�model���ƣ��ж�FPGA�豸���͡���2��bus_find_device������spi_bus_type�����ϲ�����Ϊ "ad9361-phy" ���豸����ȡAD9361�豸ָ��洢��priv->ad9361_phy����3��bus_find_device������platform_bus_type��������Ϊ�� "cf-ad9361-dds-core-lpc" dds�豸��platform_get_drvdata��iio_priv������ȡIIO�豸axi_ad9361˽������dac/adc���ݣ��洢��priv->dds_st
4.��ʼ����Ƶ������rssiУ׼�����������ʣ�ָ������/�������ߣ�������Ƶ
5.IEEE802.11Ӳ���������ã�ָ���ŵ�Ƶ�Σ����ƶ����ŵ������ʱ�Htģʽ������MAC��ַ��
6.err = ieee80211_register_hw(dev)���ں�ע�����������豸���ؼ�ע�ᣬ
7.���Խӿڴ�����
sysfs_create_bin_file(&pdev->dev.kobj, &priv->bin_iq);����IQ���ݴ���ӿڣ�ֱ�ӷ��ʻ���IQ���ݵĶ����ƽӿ�  
sysfs_create_group(&pdev->dev.kobj, &tx_intf_attribute_group);����������������飬��������������û��ռ�ӿ�  
sysfs_create_group(&pdev->dev.kobj, &stat_attribute_group);����ͳ����Ϣ�����飬ʵʱ���ܼ�����ݵ���  
8.����ͳ�ơ�������ͳ�Ƶȡ�����ɹ��ʵ�40����ϵͳͳ�Ƴ�ʼ��
9.��cfg80211��wiphy�ṹ��ע����Ϣ����ʼ���������豸����Ƶkill״̬�����Ȼ�ȡ��Ƶ����״̬�������ں���Ƶkill״̬��������ѯ�Լ�����Ƶ���ر仯��
#### �ص�������
```
static const struct ieee80211_ops openwifi_ops = {
	.tx			       = openwifi_tx,                       //���룬���͵�֡����
	.start			   = openwifi_start,
	.stop			   = openwifi_stop,
	.add_interface	   = openwifi_add_interface,
	.remove_interface  = openwifi_remove_interface,
	.config			   = openwifi_config,
	.set_antenna       = openwifi_set_antenna,
	.get_antenna       = openwifi_get_antenna,
	.bss_info_changed  = openwifi_bss_info_changed,
	.conf_tx		   = openwifi_conf_tx,
	.prepare_multicast = openwifi_prepare_multicast,
	.configure_filter  = openwifi_configure_filter,
	.rfkill_poll	   = openwifi_rfkill_poll,
	.get_tsf		   = openwifi_get_tsf,
	.set_tsf		   = openwifi_set_tsf,
	.reset_tsf		   = openwifi_reset_tsf,
	.set_rts_threshold = openwifi_set_rts_threshold,
	.ampdu_action      = openwifi_ampdu_action,
	.testmode_cmd	   = openwifi_testmode_cmd,
};
```

### ������ע������
ע���ʼ�����¶��ϣ�������Ӳ���豸�豸ע�ᣬ��sdr.ko�豸������ʼ��ʱ������platform_driver����������.of_match_tableƥ���豸���еĽڵ�.compatable���ƶ�Ӧ���豸��̽�⵽��ִ��Ӳ��������ʼ������openwifi_dev_probe����:1.ieee80211_alloc_hw����Ӳ�������ģ�(������sizeof_priv������˽�����ݴ�С����ops������ʵ�ֵ�ieee80211_ops������struct ieee80211_hw);2.��ʼ��Ӳ�����Ĵ�����DMA���жϵȣ�;3.����ieee80211_register_hw(hw),�ú����ڲ������mac80211��ע���߼������ջ����cfg80211��ע�ắ����wiphy_register����  
Ȼ��ִ��mac80211����ĳ�ʼ����ieee80211_register_hw�᣺1.��ʼ��mac80211���ڲ�״̬������С���ʱ���ȣ���2.ͨ��wiphy_new����struct wiphy������һ�������豸��3.��mac80211ʵ�ֵ����ò�����cfg80211_ops������wiphy 4.����wiphy_register������cfg80211�Ľӿڣ���wiphyע�ᵽcfg80211��
Ȼ��ִ��cfg80211�ĳ�ʼ����1.����nl80211_init����ע����nl80211��Netlink�׽��ֺͲ�����������ʼ���ڲ����ݽṹ���������豸������2.����������wiphy_registerʱ��cfg80211����wiphy��ӵ�ȫ������Ϊ����豸��sysfs�д����ڵ㡣֪ͨ�û��ռ䣨��ͨ��Netlink����NL80211_CMD_NEW_WIPHY�¼�����
Ȼ����nl80211�ĳ�ʼ������cfg80211��ʼ��ʱ��ͨ��nl80211_init������netlink_kernel_create����Netlink�׽��֣�Э��ΪNETLINK_GENERIC����ע��nl80211��ͨ��Netlink�����ô�������nl80211_ops���������е����������ɨ�衢���ӵȣ�
�û��ռ乤�ߣ���iw��ͨ��Netlink�׽��ַ�������ͽ����¼�



## wifi ���幤�̽ṹ
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
#### ��������ӿ�
dac_rst:������˸�λ�ź�
dac_clk��40Mhz������axi_ad9361��L_clk����Ƶ���γ�adc_clk
#### tx_intf_s_axis_i module
tx_queue_idx_indication_from_ps	       // in	ѡ������д���FIFO���У�0-3��
tx_queue_idx	                       // in	ѡ��ACC��ȡ��FIFO���У�0-3��
endless_mode	                        //in	����ģʽ�л���0:���޳���, 1:����������
ACC_ASK_DATA	                        //in	���������������ź�
DATA_TO_ACC	                           // out	�����ACC������
s_axis_recv_data_from_high	           // out	ָʾ��ǰ�Ƿ������ݽ���״̬
S_AXIS_*	                           // in/out	AXI Stream��׼�ӿڣ�ʱ�ӡ���λ�����ݡ�ʹ�ܵȣ�

���Ĺ���������XPM FIFOʵ�ֶ�������ݻ��塣�������������ĸ�xpm_fifo_syncͬ��FIFO��ÿ����Ӧһ��������С���AXI Stream���ݵ���ʱ��tx_queue_idx_indication_from_ps�źž�������д���ĸ�FIFO���С�ÿ��FIFO��д��ʹ���źţ�fifo_wren0-3�����������ѡ���ź����ɡ���ȡ����ͨ��tx_queue_idxѡ����ĸ�FIFO��ȡ���ݸ���������ACC��

#### tx_bit_intf_i module      �ؼ�
��ؼ���ģ�飬���ƽ�����������ı�������
```
fcs_in_strobe                         //  in from���ջ���֡У�� 
    // recv bits from s_axis
tx_queue_idx                           // out ȡaxis��������
linux_prio                            //  out 
pkt_cnt                               //  out
data_from_s_axis                      //  in  ����
ask_data_from_s_axis                  //  out ����ready
emptyn_from_s_axis                    //  in s_axis��fifo��
    // src indication
auto_start_mode                       //  in,set by driver
.num_dma_symbol_th(phy_tx_auto_start_num_dma_symbol_th),  //in .set by driver
.tx_config(slv_reg8),//
.tx_queue_idx_indication_from_ps(slv_reg8[19:18]),
.phy_hdr_config(slv_reg17),
.ampdu_action_config(slv_reg15),
.s_axis_recv_data_from_high(s_axis_recv_data_from_high),
.start(phy_tx_start),                  // in����ʼ����

.tx_config_fifo_data_count0(tx_config_fifo_data_count0), //out,���Ͷ�������
.tx_config_fifo_data_count1(tx_config_fifo_data_count1),
.tx_config_fifo_data_count2(tx_config_fifo_data_count2), 
.tx_config_fifo_data_count3(tx_config_fifo_data_count3),
.tx_iq_fifo_empty(tx_iq_fifo_empty),            //in,s_axis��fifo��
.cts_toself_config(slv_reg4),
.send_cts_toself_wait_sifs_top(send_cts_toself_wait_sifs_top),
.mac_addr(mac_addr),
.tx_try_complete(tx_try_complete),              //in,from xpu
.retrans_in_progress(retrans_in_progress),      //in,from xpu
.start_retrans(start_retrans),                  //in,from xpu
.start_tx_ack(start_tx_ack),                    //in,from xpu
.slice_en(slice_en),                            //in��from xpu������ʱ����Ƭѡ��Ҫ���͵Ķ���
.backoff_done(backoff_done),                    //in,from xpu
.tx_bb_is_ongoing(tx_bb_is_ongoing),
.ack_tx_flag(ack_tx_flag),
.wea_from_xpu(wea_from_xpu),
.addra_from_xpu(addra_from_xpu),
.dina_from_xpu(dina_from_xpu),
.tx_pkt_need_ack(tx_pkt_need_ack),
.tx_pkt_retrans_limit(tx_pkt_retrans_limit),
.use_ht_aggr(use_ht_aggr),
.quit_retrans(quit_retrans),                    //out
.reset_backoff(reset_backoff),                      //out
.high_trigger(high_trigger),                    //out
.tx_control_state_idle(tx_control_state_idle),  //in,from xpu
.bd_wr_idx(bd_wr_idx),                          //in,from tx_status_fifo
// .tx_pkt_num_dma_byte(tx_pkt_num_dma_byte),
.douta(douta),                                  //out,�ش�ʱ�ı��ش�����
.cts_toself_bb_is_ongoing(cts_toself_bb_is_ongoing),
.cts_toself_rf_is_ongoing(cts_toself_rf_is_ongoing),
 
 // to send out to wifi tx module
.tx_end_from_acc(tx_end_from_acc),              //in,�������
.bram_data_to_acc(data_to_acc),                     //in,����
.bram_addr(bram_addr),                          //in��bram��ַ
.tsf_pulse_1M(tsf_pulse_1M)
```

�ؼ�����״̬����ת����
1. ??WAIT_TO_TRIG (���еȴ�)??
??����??������ŵ��Ͷ���״̬��ѡ���Ͷ��С�
??��ת����??��
�� slice_en[N] ʹ���Ҷ�Ӧ���зǿգ�~tx_config_fifo_empty[N] �� floating_pkt_flag[N]=1�����޻���/RFռ�ã�~tx_bb_is_ongoing��~ack_tx_flag����
�ŵ����У�tx_control_state_idle�����޳�ͻ�źţ�~tx_try_complete_dl_pulses��~fcs_in_strobe_dl_pulses����
??����??���������ȼ�ѡ�� tx_queue_idx_reg������ high_trigger �źš���ת���ȴ��˱�״̬
2. ??WAIT_CHANCE (�˱ܵȴ�)??
??����??���ȴ�CSMA/CA�˱���ɡ�
??��ת����??��
backoff_done=1 ʱ���� PREPARE_TX_FETCH�����������Ҫ����λ����֡�ۺϵ����ݰ������Ϊfloating pkt_flag[3:0]�ݴ棻
�����б����ã�~slice_en[N]�������� WAIT_TO_TRIG״̬����λ�˱ܣ�reset_backoff=1��
3. ??PREPARE_TX_FETCH (���ü���)??
??����??������tx_queue_idx_reg���������Ӷ�ӦFIFO��ȡ����ظ�������TX���ã�tx_config_current��phy_hdr_config_current
??��ת����??��ֱ�ӽ��� PREPARE_TX_JUDGE��
4. ??PREPARE_TX_JUDGE (���Ͳ��Ծ���)??
??����??���ж��Ƿ�����CTS������
??��ת����??��
����sdr.ko�ص�����tx�Զ������Ƿ���Ҫcts��ͨ��fifo����tx_config_current���õ���Ϣ�������Ƿ���Ҫcts������use_cts_protect=1 �� DO_CTS_TOSELF��
���� �� CHECK_AGGR��
5. ??DO_CTS_TOSELF (CTS֡����)??
??����??�����ɲ�����CTS֡��
??����??��
дBRAM����CTS֡ͷ��Ŀ��MAC+����ʱ�䣩��CTS_to_self֡������MAC��ַ��CTS��֡��ͨ���㲥��ʽ֪ͨ���Ƿ�Χ���豸��ĬԤ���ŵ��������ͻ
�ȴ�����FIFO������tx_iq_fifo_empty����
??��ת����??��CTS���ݲ��������SIFS�ȴ���ʼ �� WAIT_SIFS��
6. WAIT_SIFS
���ܣ��ȴ�SIFSʱ��
��������ת������
7. ??CHECK_AGGR (�ۺϾ���)??
??����??���ж��Ƿ����AMPDU�ۺϡ�
??��ת����??��
??��������??����HT�����ۺϰ�����/���ȳ��ޡ������ȼ�����ռ��
??�����ۺ�??������δ��������ռ �� ���� PREPARE_TX_FETCH ������һ����
??����������??����ǰ�������´η��� �� PREP_PHY_HDR��
8. ??PREP_PHY_HDR (����֡ͷ����)??
??����??������L-SIG����ͳ֡����HT-SIG��HT֡��������
??�ؼ�����??��
ʹ�ó����������������div_int����
HT֡�����CRC��ht_sig_crc_calc����
??��ת����??��������� �� DO_PHY_HDR1��
9. ??DO_PHY_HDR1/DO_PHY_HDR2 (֡ͷд��)??
??����??����֡ͷд��BRAM��
??����??��
DO_PHY_HDR1��д��L-SIG����ͳ֡����HT-SIG�����ֶΣ�
DO_PHY_HDR2��HT֡д��ʣ��HT-SIG�ֶΡ�
??��ת����??��д����� �� DO_TX��
10. ??WAIT_TX_COMP (�ش��ȴ�)??
??����??�������ش��жϺ�Ļָ���
??��ת����??���ش���ɣ�tx_try_complete_dl2���� WAIT_CHANCE��


TX����FIFO����4������64*64��
�洢ÿ�����ȼ����еĴ�����Ʋ�������CTS���á�����ѡ���ش����Ƶȣ�������MAC���ڲ��Ĳ������ã����ڶ�̬����Э����Ϊ����ֱ�ӷ�װ��MAC֡��
��������??��
д��������tx_config_fifo_wren[N]��Чʱ����{cts_toself_config, tx_config}д���Ӧ����FIFO��
��������״̬����PREPARE_TX_FETCH�׶ΰ����ȡ���ã�tx_config_fifo_rden�źſ��ƣ���

??PHYͷ������FIFO�飨4��32λ��FIFO��??
??����??���洢�����֡ͷ��������֡����len_psdu��MCS����rate_hw_value���ۺϱ�־use_ht_aggr�ȣ���

˫�˿�TDPRAM
1. ??����֡��������??
??����??���洢�����͵���������֡����L-SIG/HT-SIG֡ͷ����Ч�غɣ���
�˿ڷֹ���
??Port A??��״̬������д�루֡ͷ��ģ�����ɣ��غ�����AXI-Stream����
??Port B??�������ģ��ͨ��bram_addr��ȡ���ݡ�
??д���߼�??��
֡ͷд�룺��DO_PHY_HDR1/2״̬д��L-SIG��HT-SIG����ַ0~1����
�غ�д�룺��DO_TX״̬��AXI-Stream����д�루��ַ2~N����
??��ȡ�߼�??�������ͨ��bram_addr������ȡ����bram_data_to_acc�����
2. ??·�����û���??
??�ش�ֱͨ??����retrans_in_progress=1ʱ��Port A�л�Ϊ�ⲿֱͨģʽ��wea_from_xpu��dina_from_xpu����֧���ش������ƹ����档
??ACK֡����??��ack_tx_flag��Чʱ��bram_data_to_accֱ�����dina_from_xpu��ʵ�����ӳ���Ӧ��

���ݾ��������ж�ѡ������һ��˫�˿�xpm_memory_tdpram��1024��64��С,������64λdouta��64λ����data_to_acc��data_to_acc�����������ݣ���󽻸�openofdm_tx�������
#### ���� edge_to_flip module 
ֻ��led��ʾ��־λ
#### tx_iq_intf module
rf_i, rf_q	                            in	RF ǰ������� I/Q ����
tx_arbitrary_iq_in	                    in	ARM �·������� I/Q ����
wifi_iq_pack	                        out	������ I/Q ���ݰ��������������
tx_hold	                                out	�����źţ���ͣ������������
tx_arbitrary_iq_mode	                in	����Դѡ��0 = RF ģʽ��1 = �������ģʽ
bb_gain	                                in	RF ģʽ����������ϵ��
bb_gain1, bb_gain2	                    in	CSI ģ��ĸ�����ϵ��
tx_hold_threshold	                    in	FIFO ��������ֵ������ tx_hold ���ٽ��

��Ҫ���ܣ�
1��IQ����Դѡ����Ƶģʽ??���������� RF ǰ�˵� I/Q ���ݣ�rf_i, rf_q�������������������bb_gain����д�� FIFO��??�������ģʽ??��ͨ�� AXI �Ĵ�����slv_reg_wren������ ARM �������·������� I/Q ���ݣ�tx_arbitrary_iq_in����ֱ��д�� FIFO
2��FIFO���ݻ��壺xpm_fifo_sync������������data_count���FIFO��������������ֵtx_hold_threshold���ɿ����ź�tx_hold����ֹ���
3��IQ����ʵʱ����bb_gain������ֵ��CSI�ŵ�����ģ����

#### dac_intf module 
xpm_fifo_async��ʱ������dac_data��������FIFO���ݲ�0ʵ��2���ϲ������˲�ֱ��ad9361������
ant_flag����Ч���������������λ�ã�simple_cdd_flagѡ�����߷ּ�ģʽ,00�����ߣ�01����1��dacʱ�������ӳ�2���߷ּ���1��ͬ����
#### tx_status_fifo_i module
ÿ�δ��䳢�����(tx_try_complete��Ч)ʱ��������״̬��Ϣͨ��AXI-LITE���ϴ��ݣ�4�����64λ��32��sync_fifo������PS��������״̬��Ϣ��  
���񲢴��䣺1.������Ϣnum_slot_random:����˱�ʱ϶������cw��contension window �˱ܴ��ڸ�����linux_prio��linux���ȼ���tx_queue_idx��tx_bit_intf�ж���������num_retrans�ش�������2.��ȷ����Ӧ��blk_ack_resp_ssn���кţ�
pkt_cnt:��������3.ȷ��λͼblk_ack_bitmap_low��blk_ack_bitmap_high��λͼ


#### tx_interrupt_selection module
����״̬�ж��źŲ���
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
### ��������ӿ�

#### gpio_status
ad9361��8λgpio��ʱ����ת������һ���첽fifo��32��Ļ���ƽ��ģ�飬����ָʾagc����

#### adc_intf module
��ģ��������adc_data��������ѡ��ѡ�����������adc_data_after_sel���Ƿ�����һ·->adc_data_internal���뵽adc_intf
ͨ��fifo������ʹ��fifoдadc_valid_decimate����2����ȡ->data_to_acc_internal�����첽xpm fifo(д40Madcʱ�ӣ�дʹ��20MHz,��100Mm_axis_clk)Ϊ100Mhz��data_to_acc_internal
��bb_gain����λ����ԭ��12λ��9361���ݷ�����չ��Ϊ16λ->ant_data_after_sel(data_to_bb)


�ж��Ƿ�ѡ�񱾵ػػ���ѡ��tx_intf���ݺ�ant_data_after_sel,->bw20_i0,q0,i1,q1

#### rx_iq_intf
�Ѿ�������·����ƥ��->rf_i0_to_acc,
sample0 = {rf_i0_to_acc,rf_q0_to_acc}����Ϊ��������
sample1 = {rf_i1_to_acc,rf_q1_to_acc}������Ϊ�ɼ�����

#### byte_to_word_fcs_sn_insert module
1.���ս��ջ��������8λbyte_out���ݣ���˳�����Ϊaxis���ߴ����64λ���ݣ�ͨ����λ�Ĵ��������ֽڣ��ۼ�8�ֽ�ʱ�������word_out������������8�ֽ�ʱ��ʣ���ֽ��������
2.��fcs_in_strobe��Ч����У����ȷʱ��ԭʼ�����滻ΪУ���������к�{fcs_ok,rx_pkt_sn���ݰ����к�}�������ж����������Ժ�˳��

#### pl_to_m_axis
��������ӿ�  
 // port to xpu
.block_rx_dma_to_ps(block_rx_dma_to_ps),                        //in, ����dma����
.block_rx_dma_to_ps_valid(block_rx_dma_to_ps_valid),
.rssi_half_db_lock_by_sig_valid(rssi_half_db_lock_by_sig_valid),
.gpio_status_lock_by_sig_valid(gpio_status_lock_by_sig_valid),

// to m_axis and PS
.start_1trans_to_m_axis(start_1trans_from_acc_to_m_axis),       //out,����һ�δ���
.data_to_m_axis_out(data_from_acc_to_m_axis),                   //out,axis����
.data_ready_to_m_axis_out(data_ready_from_acc_to_m_axis),       //out,
  .monitor_num_dma_symbol_to_ps(monitor_num_dma_symbol_to_ps),  //out,���δ���DMA��������
.m_axis_rst(m_axis_rst),
.m_axis_tlast(m00_axis_tlast_inner),
.m_axis_tlast_auto_recover(m00_axis_tlast_auto_recover),        //��ʱ�Զ��ָ�

// port to xilinx axi dma
.s2mm_intr(s2mm_intr),                                          //in,dma1�ж�
.rx_pkt_intr(rx_pkt_intr_internal),                             //out,�ڲ������ı��Ľ�������жϣ��ӳٴ���

// to byte_to_word_fcs_sn_intert
.rx_pkt_sn_plus_one(rx_pkt_sn_plus_one),                        //�����������1��
.m_axis_tlast_auto_recover_enable(~slv_reg12[31]),
.m_axis_tlast_auto_recover_timeout_top(slv_reg12[12:0]),
.start_1trans_mode(slv_reg5[2:0]),
.start_1trans_ext_trigger(slv_reg6[0]),
.src_sel(slv_reg7[0]),
.tsf_runtime_val(tsf_runtime_val),                              //in,from xpu
.count_top(slv_reg13[14:0]),
  //.pad_test(slv_reg13[31]),
.max_signal_len_th(slv_reg6[31:16]),

.data_from_acc(data_from_acc),                                  //in��from byte_to_wordģ��ת���������
.data_ready_from_acc(data_ready_from_acc),                      //
.pkt_rate(pkt_rate),                                            //in,from rx
  .pkt_len(pkt_len),                                            //in,from rx
.sig_valid(sig_valid                                            //in,header��Ч��������Ч
.ht_aggr(ht_aggr),
.ht_aggr_last(ht_agg                                            //in,from rx
  .ht_sgi(ht_sgi),                                              //in,from rx
.ht_unsupport(ht_uns                                            //in,from rx
.fcs_valid(fcs_valid                                            //

.rf_iq(rf_iq_loopback),
.rf_iq_valid(sample_strobe),
.tsf_pulse_1M(tsf_pulse_1M)

                 WAIT_FOR_PKT = 3'b000,       // ״̬0���ȴ���Ч����,����dma���Ŵ��䳤��(������64λ������+2��������Ϣ)
                 DMA_HEADER0_INSERT = 3'b001,  // ״̬1��ȷ������TSFʱ���
                 DMA_HEADER1_INSERT_AND_START=3'b010, // ״̬2��������յı������ݣ�
{8'd0, ht_aggr_last, ht_aggr, ht_sgi, pkt_rate[7],pkt_rate[3:0],pkt_len, 8'd1, gpio_status_lock_by_sig_valid, 5'd0, rssi_half_db_lock_by_sig_valid}
                 WAIT_FILTER_FLAG = 3'b011,     // ״̬3���ȴ����˾��ߡ���������ʱ�ȴ����ջ���־block_rx_dma_to_ps_valid�������ʱ��ʱ���FIFO���и�λ
                 WAIT_DMA_TLAST = 3'b100,       // ״̬4������ת��������AXIS��
                 WAIT_RST_DONE = 3'b101;        // ״̬5���ȴ�8�����ڸ�λ������0״̬





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
