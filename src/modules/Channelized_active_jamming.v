`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 20:16:07
// Design Name: 
// Module Name: Channelized_active_jamming
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//`define _DEBUG_ila_fpga_fifo 
`define _INST_4MOD_ 
// 信道化有源干扰
module Channelized_active_jamming#(
parameter mult_obj = 16
)(
    input I_clk_p,                // 输入差分时钟，100MHz
    input I_clk_n,
    //------------------K7_325T interface------------------------
////    output uart422_txd,
////    input  uart422_rxd,
////    output reg [6:0]o_RD,
////    output reg [6:0]o_TD,
//    output o_K_LNA,
//    output o_K_T,
//    output o_power28,
////    output reg o_PA_POWER,
////    output reg o_PA_TX,
////    input [9:0]i_freq_single_bit,
////    input i_clk_singel_bit,

////    input  i_uart_PA_selftest,
////     input  i_uart_LR_RX,
////     output o_uart_LR_TX,
////     input  i_uart_LT_RX,
////     output o_uart_LT_TX,
////     input  i_uart_RCS_RX,
////     output o_uart_RCS_TX,
    //------------------K7_325T interface END--------------------
//    //------------------singel bit board interface---------------------
//    input [17:0]singel_bit_freq,
//    input singel_bit_clk,
//    input singel_bit_en,
//    //------------------singel bit board interface END-----------------
    input adc0_clk_p,
    input adc0_clk_n,
    input adc1_clk_p,
    input adc1_clk_n,
    input dac0_clk_p,
    input dac0_clk_n,
    input sysref_in_p,
    input sysref_in_n,
    input vin0_01_p,
    input vin0_01_n,
    input vin0_23_p,
    input vin0_23_n,
    input vin1_01_p,
    input vin1_01_n,
    input vin1_23_p,
    input vin1_23_n,
    input [10:0]sym_debug1_from_zcu2,//[rx_demod_valid rx_demod_data frame_sync_flag frame_head_flag]
    output vout00_p,
    output vout00_n,
    output vout01_p,
    output vout01_n,
    output vout02_p,
    output vout02_n,
    output vout03_p,
    output vout03_n,
////    output [7:0] test_io,
    output clk_83M_to_zcu2,
    output rst_to_zcu2,
    output [11:0] channel_sub04_I_to_zcu2,
    output [11:0] channel_sub04_Q_to_zcu2,
    output re_acq_to_zcu2
    );

//////////////////////////////////////////////////////////////////////////////////

// 信号声明
wire sys_clk;
wire clk_250M;
wire clk_83M;
wire pll_locked;
wire rst;
wire [63:0] system_time;
wire vio_rst;
wire vio_send_source;
//wire vio_recv_enable;
assign rst = ~pll_locked;
//assign rst = vio_rst;
wire [2:0]vio_rate_up_dsss; 
wire [2:0]vio_rate_down_qpsk; 
assign vio_rate_up_dsss = 3'd4;
assign vio_rate_down_qpsk = 3'd2;
//vio_rst u_vio_rst (
//  .clk(clk_250M),                // input wire clk
//  .probe_out0(vio_rst),  // output wire [0 : 0] probe_out0
//  .probe_out1(vio_send_source),  // output wire [0 : 0] probe_out0
//  .probe_out2(vio_rate_up_dsss),  // output wire [0 : 0] probe_out0
//  .probe_out3(vio_rate_down_qpsk)  // output wire [0 : 0] probe_out0
//);
// RFDC
wire clk_adc0;
wire clk_adc1;
wire clk_dac0;

wire [127 : 0] m00_axis_tdata;    // output wire [127 : 0] m00_axis_tdata
wire m00_axis_tvalid;  // output wire m00_axis_tvalid
wire m00_axis_tready;  // input wire m00_axis_tready
wire [127 : 0] m01_axis_tdata;    // output wire [127 : 0] m01_axis_tdata
wire m01_axis_tvalid;  // output wire m01_axis_tvalid
wire m01_axis_tready;  // input wire m01_axis_tready 
wire [127 : 0] m02_axis_tdata;    // output wire [127 : 0] m02_axis_tdata
wire m02_axis_tvalid;  // output wire m02_axis_tvalid
wire m02_axis_tready;  // input wire m02_axis_tready
wire [127 : 0] m03_axis_tdata;    // output wire [127 : 0] m03_axis_tdata
wire m03_axis_tvalid;  // output wire m03_axis_tvalid
wire m03_axis_tready;  // input wire m03_axis_tready

wire [127 : 0] m10_axis_tdata;    // output wire [127 : 0] m10_axis_tdata
wire m10_axis_tvalid;  // output wire m10_axis_tvalid
wire m10_axis_tready;  // input wire m10_axis_tready
wire [127 : 0] m11_axis_tdata;    // output wire [127 : 0] m11_axis_tdata
wire m11_axis_tvalid;  // output wire m11_axis_tvalid
wire m11_axis_tready;  // input wire m11_axis_tready
wire [127 : 0] m12_axis_tdata;    // output wire [127 : 0] m12_axis_tdata
wire m12_axis_tvalid;  // output wire m12_axis_tvalid
wire m12_axis_tready;  // input wire m12_axis_tready
wire [127 : 0] m13_axis_tdata;    // output wire [127 : 0] m13_axis_tdata
wire m13_axis_tvalid;  // output wire m13_axis_tvalid
wire m13_axis_tready;  // input wire m13_axis_tready

wire [255 : 0] s00_axis_tdata;    // input wire [255 : 0] s00_axis_tdata
wire s00_axis_tvalid;  // input wire s00_axis_tvalid
wire s00_axis_tready;  // output wire s00_axis_tready
wire [255 : 0] s01_axis_tdata;    // input wire [255 : 0] s01_axis_tdata
wire s01_axis_tvalid;  // input wire s01_axis_tvalid
wire s01_axis_tready;  // output wire s01_axis_tready
wire [255 : 0] s02_axis_tdata;    // input wire [255 : 0] s02_axis_tdata
wire s02_axis_tvalid;  // input wire s02_axis_tvalid
wire s02_axis_tready;  // output wire s02_axis_tready
wire [255 : 0] s03_axis_tdata;    // input wire [255 : 0] s03_axis_tdata
wire s03_axis_tvalid;  // input wire s03_axis_tvalid
wire s03_axis_tready;  // output wire s03_axis_tready
                

wire [23:0] din_channelized[0:3][7:0];

// DAC接口
//wire [31:0] dac[0:3][7:0];

// PL2PS的FIFO接口
wire valid_fifo[0:3];
wire [31:0] dout_fifo[0:3];
wire [3:0] empty_fifo[0:3];

wire recv_enable;
assign recv_enable = 1'b1;
//////////////////////////////////////////////////////////////////////////////////
// 模块例化

// 系统时钟
IBUFGDS sys_clk_ibufgds   //generate single end clock
 (
    .O (sys_clk),
    .I (I_clk_p),
    .IB(I_clk_n)
 );

  sys_mmcm sys_mmcm_u
   (
    // Clock out ports
    .clk_out1(clk_83M),     // output clk_out1
    .clk_out2(clk_250M),     // output clk_out2
    // Status and control signals
    .locked(pll_locked),       // output locked
   // Clock in ports
    .clk_in1(sys_clk));      // input clk_in1

// 系统时间
SystemTimer SystemTimer_u(
    .clk(clk_250M),
    .rst(rst),
    .system_time(system_time)
    );

wire adc_valid;
//////////////////////////////////////////////////////////////////////////////////
// ADC接口
// 本模块只做数据的拆分与组合，便于后续信道化处理
// 输出是复数，Q在高位，I在低位，I、Q均为12位有符号数
adc_interface adc_interface_u(
    .clk(clk_250M),
    .rst(~recv_enable),
    .m00_axis_tdata(m00_axis_tdata),
    .m01_axis_tdata(m01_axis_tdata),
    .m02_axis_tdata(m02_axis_tdata),
    .m03_axis_tdata(m03_axis_tdata),
    .m10_axis_tdata(m10_axis_tdata),
    .m11_axis_tdata(m11_axis_tdata),
    .m12_axis_tdata(m12_axis_tdata),
    .m13_axis_tdata(m13_axis_tdata),
    .adc_valid(adc_valid),
    .adc0_0(din_channelized[0][0]),               // s(0),{Q,I}
    .adc0_1(din_channelized[0][1]),               // s(1)
    .adc0_2(din_channelized[0][2]),               // s(2)
    .adc0_3(din_channelized[0][3]),               // s(3)
    .adc0_4(din_channelized[0][4]),               // s(4)
    .adc0_5(din_channelized[0][5]),               // s(5)
    .adc0_6(din_channelized[0][6]),               // s(6)
    .adc0_7(din_channelized[0][7]),               // s(7)
    .adc1_0(din_channelized[1][0]),               // s(0),{Q,I}   
    .adc1_1(din_channelized[1][1]),               // s(1)         
    .adc1_2(din_channelized[1][2]),               // s(2)         
    .adc1_3(din_channelized[1][3]),               // s(3)         
    .adc1_4(din_channelized[1][4]),               // s(4)         
    .adc1_5(din_channelized[1][5]),               // s(5)         
    .adc1_6(din_channelized[1][6]),               // s(6)         
    .adc1_7(din_channelized[1][7]),               // s(7)         
    .adc2_0(din_channelized[2][0]),               // s(0),{Q,I}   
    .adc2_1(din_channelized[2][1]),               // s(1)         
    .adc2_2(din_channelized[2][2]),               // s(2)         
    .adc2_3(din_channelized[2][3]),               // s(3)         
    .adc2_4(din_channelized[2][4]),               // s(4)         
    .adc2_5(din_channelized[2][5]),               // s(5)         
    .adc2_6(din_channelized[2][6]),               // s(6)         
    .adc2_7(din_channelized[2][7]),               // s(7)         
    .adc3_0(din_channelized[3][0]),               // s(0),{Q,I}   
    .adc3_1(din_channelized[3][1]),               // s(1)         
    .adc3_2(din_channelized[3][2]),               // s(2)         
    .adc3_3(din_channelized[3][3]),               // s(3)         
    .adc3_4(din_channelized[3][4]),               // s(4)         
    .adc3_5(din_channelized[3][5]),               // s(5)         
    .adc3_6(din_channelized[3][6]),               // s(6)         
    .adc3_7(din_channelized[3][7])                // s(7)         
    );

// 信道化接收变量    
wire valid_channelized;
wire [31:0] dout_channelized[15:0];
// 1,复信号16信道化
// 输入、输出都是复信号，高位为Q，低位为I
Channelized_receiver_complex_16 Channelized_receiver_complex_16_u(
    .clk(clk_250M),
    .rst(rst),
    .bw_sel(8'd0),
    .den(adc_valid),
    .din0(din_channelized[0][7]),         // {Q[11:0],I[11:0]}，s(0)   
    .din1(din_channelized[0][6]),         // s(-1)                    
    .din2(din_channelized[0][5]),
    .din3(din_channelized[0][4]),
    .din4(din_channelized[0][3]),
    .din5(din_channelized[0][2]),
    .din6(din_channelized[0][1]),
    .din7(din_channelized[0][0]),         // s(-7)                    
    .valid(valid_channelized),
    .dout00(dout_channelized[00]),     // 中心频率为0MHz   // {Q[15:0],I[15:0]}   
    .dout01(dout_channelized[01]),     // 中心频率为125MHz 
    .dout02(dout_channelized[02]),     // 中心频率为250MHz 
    .dout03(dout_channelized[03]),     // 中心频率为375MHz 
    .dout04(dout_channelized[04]),     // 中心频率为500MHz 
    .dout05(dout_channelized[05]),     // 中心频率为625MHz 
    .dout06(dout_channelized[06]),     // 中心频率为750MHz 
    .dout07(dout_channelized[07]),     // 无效频率区间
    .dout08(dout_channelized[08]),     // 无效频率区间
    .dout09(dout_channelized[09]),     // 无效频率区间
    .dout10(dout_channelized[10]),     // 中心频率为-750MHz 
    .dout11(dout_channelized[11]),     // 中心频率为-625MHz 
    .dout12(dout_channelized[12]),     // 中心频率为-500MHz 
    .dout13(dout_channelized[13]),     // 中心频率为-375MHz 
    .dout14(dout_channelized[14]),     // 中心频率为-250MHz 
    .dout15(dout_channelized[15])      // 中心频率为-125MHz 
    );
wire [15:0]dout_channelized0_I = dout_channelized[00][15:0];
wire [15:0]dout_channelized0_Q = dout_channelized[00][31:16];
wire [15:0]dout_channelized2_I = dout_channelized[02][15:0];
wire [15:0]dout_channelized2_Q = dout_channelized[02][31:16];
wire [15:0]dout_channelized1_I = dout_channelized[01][15:0];
wire [15:0]dout_channelized1_Q = dout_channelized[01][31:16];
wire [15:0]dout_channelized15_I = dout_channelized[15][15:0];
wire [15:0]dout_channelized15_Q = dout_channelized[15][31:16];
wire [15:0]dout_channelized14_I = dout_channelized[14][15:0];
wire [15:0]dout_channelized14_Q = dout_channelized[14][31:16];
//-----3.01 3.03 3.05 G的信号落在通道0的负频域
//3.01--- -10M 3.03= -30M 3.05= -50M 需要上变频
wire signed [11:0] channel_sub00_I,channel_sub01_I,channel_sub02_I,channel_sub03_I,channel_sub04_I;
wire signed [11:0] channel_sub00_Q,channel_sub01_Q,channel_sub02_Q,channel_sub03_Q,channel_sub04_Q;
wire channel_sub00_valid,channel_sub01_valid,channel_sub02_valid,channel_sub03_valid,channel_sub04_valid;
ddc_duc u_ddc_duc(
.clk(clk_250M),
.rst(rst),
.i_channel0_I(dout_channelized0_I),     //[15:0]
.i_channel0_Q(dout_channelized0_Q),     //[15:0]
.i_channel0_den(valid_channelized),   //[15:0]
.i_channel15_I(dout_channelized15_I),    //[15:0]
.i_channel15_Q(dout_channelized15_Q),
.i_channel15_den(valid_channelized),   //[15:0]
.o_channel_sub0_I(channel_sub00_I),  // [11:0]
.o_channel_sub0_Q(channel_sub00_Q),  // [11:0]
.o_channel_sub0_valid(channel_sub00_valid),

.o_channel_sub1_I(channel_sub01_I),  // [11:0]
.o_channel_sub1_Q(channel_sub01_Q),  // [11:0]
.o_channel_sub1_valid(channel_sub01_valid),

.o_channel_sub2_I(channel_sub02_I),  // [11:0]
.o_channel_sub2_Q(channel_sub02_Q),  // [11:0]
.o_channel_sub2_valid(channel_sub02_valid),

.o_channel_sub3_I(channel_sub03_I),  // [11:0]
.o_channel_sub3_Q(channel_sub03_Q),  // [11:0]
.o_channel_sub3_valid(channel_sub03_valid),

.o_channel_sub4_I(channel_sub04_I),  // [11:0]
.o_channel_sub4_Q(channel_sub04_Q),  // [11:0]
.o_channel_sub4_valid(channel_sub04_valid)
    );

//ila_top_channelized u_ila_top_channelized (
//	.clk(clk_250M), // input wire clk


//	.probe0(adc_valid), // input wire [0:0]  probe0  
//	.probe1(din_channelized[0][7]), // input wire [23:0]  probe1 
//	.probe2(din_channelized[0][6]), // input wire [23:0]  probe2 
//	.probe3(dout_channelized2_I), // input wire [23:0]  probe3 
//	.probe4(dout_channelized2_Q), // input wire [23:0]  probe4 
//	.probe5(dout_channelized14_I), // input wire [23:0]  probe5 
//	.probe6(dout_channelized14_Q), // input wire [23:0]  probe6 
//	.probe7(dout_channelized15_I), // input wire [23:0]  probe7 
//	.probe8(dout_channelized15_Q), // input wire [23:0]  probe8 
//	.probe9(valid_channelized), // input wire [0:0]  probe9 
//	.probe10(dout_channelized0_I), // input wire [15:0]  probe10 
//	.probe11(dout_channelized0_Q), // input wire [15:0]  probe11 
//	.probe12(dout_channelized1_I), // input wire [15:0]  probe12 
//	.probe13(dout_channelized1_Q) // input wire [15:0]  probe13
//);
/*
//##############################################AGC模块##########################################################
wire [6:0]RD,TD;
wire [7:0]atten_sum;
AGC_CTRL AGC_CTRL_u(
    .clk_250M           (clk_250M               ), 
    .rst                (rst                    ),
    .atten_sum          (atten_sum              ),
    .din_channelized_0  (din_channelized[0][0]  ),
    .din_channelized_1  (din_channelized[1][0]  ),
    .din_channelized_2  (din_channelized[2][0]  ),
    .din_channelized_3  (din_channelized[3][0]  ),
    .enable             (recv_enable            ),//使能AGC，当系统发送数据时不使能，其他时间使能
    .RD_atten           (RD                     ),
    .TD_atten           (TD                     )
    );

//##############################################AGC模块 END######################################################
*/
///////////////////////////////////////////////////////////////////////////////////////////     
// PS端	
	wire [31:0]        M_AXIS_tdata  [0:3];
	wire [3:0]         M_AXIS_tkeep  [0:3];
	wire               M_AXIS_tlast  [0:3];
	wire               M_AXIS_tready [0:3];
	wire               M_AXIS_tvalid [0:3];
	wire [31:0]        S_AXIS_tdata  [0:3];
	wire               S_AXIS_tlast  [0:3];
	wire               S_AXIS_tready [0:3];
	wire               S_AXIS_tvalid [0:3];

	wire                W_ps_data_ready;

	wire [15:0]			emio_gpio_in;
	wire [15:0]			emio_gpio_out;
	wire				pl_clk;

	wire [31:0]        W_bram_dout;
	wire [31:0]        W_bram_din;
	wire [31:0]        W_bram_addr;
	wire [3:0]         W_bram_write;

	wire               W_param_valid;
	wire [11:0]        W_param_addr;
	wire [31:0]        W_param_data;

    wire [32*32-1:0]   W_reg_in_0 ,W_reg_in_1;
    wire [32*32-1:0]   W_reg_out_0,W_reg_out_1;
    wire [32*64-1:0]   W_reg_out_2;




    wire [0:0]DIR1;
    wire [0:0]DIR2;
    wire OEN;
    wire [11:0]data_I_0;
    wire [11:0]data_Q_0;
    wire [11:0]din_I_0;
    wire [11:0]din_Q_0;
    wire [31:0]axi_str_rxd_tdata_0;
    wire [3:0]axi_str_rxd_tkeep_0;
    wire axi_str_rxd_tlast_0;
    wire axi_str_rxd_tready_0;
    wire axi_str_rxd_tvalid_0;
    wire [31:0]axi_str_txd_tdata_0;
    wire [3:0]axi_str_txd_tkeep_0;
    wire axi_str_txd_tlast_0;
    wire axi_str_txd_tready_0;
    wire axi_str_txd_tvalid_0;
    wire [103:0]distance_in_0;
    wire [7:0]SNR_AIR_0;
    wire [9:0]gnd_bit_cnt_0;
    wire [29:0]gnd_nco_0;
    wire [9:0]gnd_pn_cnt_0;
    wire [15:0]gnd_pn_in_cnt_0;
    wire [9:0]air_bit_cnt_0;
    wire [29:0]air_doppler_0;
    wire [9:0]air_pn_cnt_0;
    wire [15:0]air_pn_in_cnt_0;
    wire sync_signal_0;
    wire [7:0]SNR_GND_0;
    reg [7:0]SNR_0;
    wire [1:0]mode_ctrl_out_0;
    wire [2:0]up_speed_out_0;
    wire [2:0]down_speed_out_0;
    reg [1:0] mod_ctl;
    wire mod_rst;
    wire re_acq; //锟斤拷锟斤拷位
    wire recv_clk_locked,send_clk_locked;
    
    wire fifo_push;
    wire [7:0] fifo_din;
    wire [12:0] qpsk_fifo_length;
    wire [8:0]  dsss_fifo_length;
    
    wire [337:0] sym_debug1;
    wire [172:0] sym_debug2;
    
    wire recv_frame_sync;
    
    wire [2:0] rate_sel_qpsk;
    wire [2:0] rate_sel_dsss;
    assign rate_sel_qpsk = vio_rate_down_qpsk; 
    assign rate_sel_dsss = vio_rate_up_dsss;
    wire [1:0] r_s_mode;//00机载 01 地面
    assign r_s_mode = 2'b01;
//
arm_mod_interface  arm_mod_interface_inst(
    .i_clk_send(clk_83M),
    .i_clk_recv(clk_83M),
    .i_reset_n(~rst),   
    .i_r_s_mode(r_s_mode),
 
    .i_axi_str_txd_tdata(axi_str_txd_tdata_0),
    .o_axi_str_txd_tready(axi_str_txd_tready_0),
    .i_axi_str_txd_tvalid(axi_str_txd_tvalid_0),
    .i_axi_str_txd_tlast(axi_str_txd_tlast_0),
    .i_axi_str_txd_tkeep(axi_str_txd_tkeep_0),
    
    .o_axi_str_rxd_tdata(axi_str_rxd_tdata_0),
    .i_axi_str_rxd_tready(axi_str_rxd_tready_0),
    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_0),
    .o_axi_str_rxd_tlast(axi_str_rxd_tlast_0),
    .o_axi_str_rxd_tkeep(axi_str_rxd_tkeep_0),
    
    .o_re_acq(re_acq),
    .o_recv_frame_sync(recv_frame_sync),
    
    .o_fifo_push(fifo_push),
    .o_fifo_din(fifo_din),
    .i_qpsk_fifo_length(qpsk_fifo_length),
    .i_dsss_fifo_length(dsss_fifo_length),
    .o_plane_bit_cnt (air_bit_cnt_0 ),
    .o_plane_pn_cnt  (air_pn_cnt_0  ),
    .o_plane_pn_nco  (air_pn_in_cnt_0  ),
    .o_ground_trk_nco(gnd_nco_0),
//    .o_ground_frm_cnt(o_ground_frm_cnt),
    .o_ground_bit_cnt(gnd_bit_cnt_0),
    .o_ground_pn_cnt (gnd_pn_cnt_0 ),
    .o_ground_pn_nco (gnd_pn_in_cnt_0 ),
   
    .o_ground_recv_measure_data(SNR_AIR_0),
    .o_plane_recv_measure_data(SNR_GND_0),
    
    .i_sym_debug1(sym_debug1),
    .i_sym_debug2(sym_debug2),
    .i_frm_head_pulse(1'b0),  
    .i_half_chip_nco_t(16'd0)
 );
//例化QPSK和DSSS调制解调模块
wire [7:0] mod_send_data;
wire mod_send_den;
assign vio_send_source = 1'b1;
assign mod_send_den = vio_send_source ? fifo_push : 1'b1;
assign mod_send_data = vio_send_source ? fifo_din : 8'h33;
wire [11:0]mod_tx_I0;
wire [11:0]mod_tx_Q0;
//-----signal 
wire frame_head_flag;
wire frame_sync_flag;
wire [7:0]rx_demod_data;
wire [7:0]rx_demod_temp;
wire rx_demod_valid;
wire [6:0]tx_fram_cnt;
assign frame_head_flag = sym_debug1[217];
assign frame_sync_flag = sym_debug1[234];
genvar ik;
generate 
for (ik=0;ik<=7;ik=ik+1)begin
assign rx_demod_data[ik] = rx_demod_temp[7-ik];  
end
endgenerate
assign rx_demod_temp = sym_debug1[242:235];
assign rx_demod_valid = sym_debug1[243];
assign tx_fram_cnt = sym_debug2[172:166];
MOD_DEMOD MOD_DEMOD_channel00(
    .n_rst(~rst),
    .clk_rev(clk_83M), //250M       
    .I_in(channel_sub00_I),   //input[11:0]AD9361 输出到调制模块 RX        
    .Q_in(channel_sub00_Q),          
    .clk_send(clk_83M), //250     
    .I_out(mod_tx_I0),   //output[11:0]调制模块输出到AD9361  TX     
    .Q_out(mod_tx_Q0),          
    .i_re_acq(re_acq),//re_acq每秒复位信号
    .i_r_s_mode(r_s_mode),
    .i_rate_sel_qpsk(rate_sel_qpsk),
    .i_rate_sel_dsss(rate_sel_dsss),

    .i_fifo_push(mod_send_den),//fifo_push
    .i_fifo_din(mod_send_data),//fifo_din
    .o_qpsk_fifo_length(qpsk_fifo_length),
    .o_dsss_fifo_length(dsss_fifo_length),
    
    .o_sym_debug1(sym_debug1),
    .o_sym_debug2(sym_debug2),
    .o_frm_head_pulse(),
    .o_half_chip_nco_t()          
);
//-------------channel04----------------
//-----signal 
wire [337:0] sym_debug1_channel4;
wire [172:0] sym_debug2_channel4;
wire frame_head_flag4;
wire frame_sync_flag4;
wire [7:0]rx_demod_data4;
wire [7:0]rx_demod_temp4;
wire rx_demod_valid4;
wire [6:0]tx_fram_cnt4;
assign frame_head_flag4 = sym_debug1_channel4[217];
assign frame_sync_flag4 = sym_debug1_channel4[234];
genvar ik4;
generate 
for (ik4=0;ik4<=7;ik4=ik4+1)begin
assign rx_demod_data4[ik4] = rx_demod_temp4[7-ik4];  
end
endgenerate
assign rx_demod_temp4 = sym_debug1_channel4[242:235];
assign rx_demod_valid4 = sym_debug1_channel4[243];
assign tx_fram_cnt4 = sym_debug2_channel4[172:166];
//----------------------------------------------//
localparam W_ARRY = 3'd4;
///----------------------------------ground 4 RX QPSK DEMOD-----------------------------//
//----------------4 arm_interface inst-----------//
wire [11:0] channel_sub4I [W_ARRY-1:0];
wire [11:0] channel_sub4Q [W_ARRY-1:0];
assign channel_sub4I[0] = channel_sub01_I;assign channel_sub4Q[0] = channel_sub01_Q;
assign channel_sub4I[1] = channel_sub02_I;assign channel_sub4Q[1] = channel_sub02_Q;
assign channel_sub4I[2] = channel_sub03_I;assign channel_sub4Q[2] = channel_sub03_Q;
assign channel_sub4I[3] = channel_sub04_I;assign channel_sub4Q[3] = channel_sub04_Q;
//assign channel_sub4I[4] = channel_sub00_I;assign channel_sub4Q[4] = channel_sub00_Q;
wire [337:0]sym_debug1_4channel  [W_ARRY-1:0];
wire [172:0]sym_debug2_4channel  [W_ARRY-1:0];
wire [31:0] axi_str_rxd_tdata_4  [W_ARRY-1:0];
wire [3:0]  axi_str_rxd_tkeep_4  [W_ARRY-1:0];
wire        axi_str_rxd_tlast_4  [W_ARRY-1:0];
wire        axi_str_rxd_tready_4 [W_ARRY-1:0];
wire        axi_str_rxd_tvalid_4 [W_ARRY-1:0];
`ifdef _INST_4MOD_
top_mod_arm uchannel01_top_mod_arm(
    .clk_83M(clk_83M),                  //input 
    .rst(rst),            //input 
    .i_r_s_mode(r_s_mode),      //input [1:0] 
    .i_data_I(channel_sub01_I),       //input  [11:0]
    .i_data_Q(channel_sub01_Q),       //input  [11:0]
    .i_rate_sel_qpsk(rate_sel_qpsk), //input [2:0]   
    .i_rate_sel_dsss(rate_sel_dsss),
    //fpga send to axi fifo
    .o_axi_str_rxd_tdata (axi_str_rxd_tdata_4 [0] ),    //axi fifo data input port    [31:0]                                                            
    .i_axi_str_rxd_tready(axi_str_rxd_tready_4[0]),                        //indicates that the axi fifo which has space that could be write                       
    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_4[0]),                       //write one word which needs a data valid                                               
    .o_axi_str_rxd_tlast (axi_str_rxd_tlast_4 [0] ),                     //the end signal of a data packet                                                       
    .o_axi_str_rxd_tkeep (axi_str_rxd_tkeep_4 [0] )               //[3:0]indicates that whether the corresponding byte among the four bytes of one word is valid
   );
//-------------------------------------------//
top_mod_arm uchannel02_top_mod_arm(
    .clk_83M(clk_83M),                  //input 
    .rst(rst),            //input 
    .i_r_s_mode(r_s_mode),      //input [1:0] 
    .i_data_I(channel_sub02_I),       //input  [11:0]
    .i_data_Q(channel_sub02_Q),       //input  [11:0]
    .i_rate_sel_qpsk(rate_sel_qpsk), //input [2:0]  
    .i_rate_sel_dsss(rate_sel_dsss), 
    //fpga send to axi fifo
    .o_axi_str_rxd_tdata (axi_str_rxd_tdata_4 [1] ),    //axi fifo data input port    [31:0]                                                            
    .i_axi_str_rxd_tready(axi_str_rxd_tready_4[1]),                        //indicates that the axi fifo which has space that could be write                       
    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_4[1]),                       //write one word which needs a data valid                                               
    .o_axi_str_rxd_tlast (axi_str_rxd_tlast_4 [1] ),                     //the end signal of a data packet                                                       
    .o_axi_str_rxd_tkeep (axi_str_rxd_tkeep_4 [1] )               //[3:0]indicates that whether the corresponding byte among the four bytes of one word is valid
   );
//-------------------------------------------//
top_mod_arm uchannel03_top_mod_arm(
    .clk_83M(clk_83M),                  //input 
    .rst(rst),            //input 
    .i_r_s_mode(r_s_mode),      //input [1:0] 
    .i_data_I(channel_sub03_I),       //input  [11:0]
    .i_data_Q(channel_sub03_Q),       //input  [11:0]
    .i_rate_sel_qpsk(rate_sel_qpsk), //input [2:0]   
    .i_rate_sel_dsss(rate_sel_dsss),
    //fpga send to axi fifo
    .o_axi_str_rxd_tdata (axi_str_rxd_tdata_4 [2] ),    //axi fifo data input port    [31:0]                                                            
    .i_axi_str_rxd_tready(axi_str_rxd_tready_4[2]),                        //indicates that the axi fifo which has space that could be write                       
    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_4[2]),                       //write one word which needs a data valid                                               
    .o_axi_str_rxd_tlast (axi_str_rxd_tlast_4 [2] ),                     //the end signal of a data packet                                                       
    .o_axi_str_rxd_tkeep (axi_str_rxd_tkeep_4 [2] )               //[3:0]indicates that whether the corresponding byte among the four bytes of one word is valid
   );
//-------------------------------------------//   
//top_mod_arm uchannel04_top_mod_arm(
//    .clk_83M(clk_83M),                  //input 
//    .rst(rst),            //input 
//    .i_r_s_mode(r_s_mode),      //input [1:0] 
//    .i_data_I(channel_sub04_I),       //input  [11:0]
//    .i_data_Q(channel_sub04_Q),       //input  [11:0]
//    .i_rate_sel_qpsk(rate_sel_qpsk), //input [2:0]   
//    .i_rate_sel_dsss(rate_sel_dsss),
//    //fpga send to axi fifo
//    .o_axi_str_rxd_tdata (axi_str_rxd_tdata_4 [3] ),    //axi fifo data input port    [31:0]                                                            
//    .i_axi_str_rxd_tready(axi_str_rxd_tready_4[3]),                        //indicates that the axi fifo which has space that could be write                       
//    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_4[3]),                       //write one word which needs a data valid                                               
//    .o_axi_str_rxd_tlast (axi_str_rxd_tlast_4 [3] ),                     //the end signal of a data packet                                                       
//    .o_axi_str_rxd_tkeep (axi_str_rxd_tkeep_4 [3] )               //[3:0]indicates that whether the corresponding byte among the four bytes of one word is valid
//   );   
////3090M 移动至zcu2板
wire re_acq_channel04;
assign clk_83M_to_zcu2 = clk_83M;
assign rst_to_zcu2 = rst;
assign channel_sub04_I_to_zcu2 = channel_sub04_I;
assign channel_sub04_Q_to_zcu2 = channel_sub04_Q;
assign re_acq_to_zcu2 = re_acq_channel04;
wire [337:0]sym_debug1_1;
wire [172:0]sym_debug2_2;
assign sym_debug1_1 = { {94{1'b0}} , sym_debug1_from_zcu2[10:1] , {16{1'b0}} , sym_debug1_from_zcu2[0] , {217{1'b0}}};
assign sym_debug2_2 = 173'b0;
arm_mod_interface  qpsk_arm_mod_interface_channel04(
    .i_clk_send(clk_83M),
    .i_clk_recv(clk_83M),
    .i_reset_n(~rst),   
    .i_r_s_mode(r_s_mode),
    .i_axi_str_txd_tdata(32'd0),
    .o_axi_str_txd_tready(),
    .i_axi_str_txd_tvalid(1'b0),
    .i_axi_str_txd_tlast(1'b0),
    .i_axi_str_txd_tkeep(4'd0),
    
    .o_axi_str_rxd_tdata (axi_str_rxd_tdata_4 [3]),
    .i_axi_str_rxd_tready(axi_str_rxd_tready_4[3]),
    .o_axi_str_rxd_tvalid(axi_str_rxd_tvalid_4[3]),
    .o_axi_str_rxd_tlast (axi_str_rxd_tlast_4 [3]),
    .o_axi_str_rxd_tkeep (axi_str_rxd_tkeep_4 [3]),  
    .o_re_acq(re_acq_channel04),
    .o_recv_frame_sync(),
    .o_fifo_push(),
    .o_fifo_din(),
    .i_qpsk_fifo_length(),
    .i_dsss_fifo_length(),
    .o_plane_bit_cnt (),
    .o_plane_pn_cnt  (),
    .o_plane_pn_nco  (),
    .o_ground_trk_nco(),
    .o_ground_frm_cnt(),
    .o_ground_bit_cnt(),
    .o_ground_pn_cnt (),
    .o_ground_pn_nco (),   
    .o_ground_recv_measure_data(),
    .o_plane_recv_measure_data(),    
    .i_sym_debug1(sym_debug1_1),
    .i_sym_debug2(sym_debug2_2),
    .i_frm_head_pulse(1'b0),  
    .i_half_chip_nco_t(16'd0)
 );
ila_channel4  ila_channel4(
	.clk(clk_83M), // input wire clk
	.probe0(rst), // input wire [0:0]  probe0  
	.probe1(axi_str_rxd_tdata_4[3]), // input wire [31:0]  probe1 
	.probe2(axi_str_rxd_tvalid_4[3]), // input wire [0:0]  probe2 
	.probe3(re_acq_channel04), // input wire [0:0]  probe3 
	.probe4(sym_debug1_from_zcu2) // input wire [10:0]  probe4
);




`endif      
//
`ifdef _DEBUG_ila_fpga_fifo
//ila_demod_data u_ila_demod_data (
//	.clk(clk_83M), // input wire clk
//	.probe0(frame_head_flag), // input wire [0:0]  probe0  
//	.probe1(frame_sync_flag), // input wire [0:0]  probe1 
//	.probe2(rx_demod_data), // input wire [7:0]  probe2 
//	.probe3(rx_demod_valid), // input wire [0:0]  probe3 
//	.probe4(gnd_pn_in_cnt_0), // input wire [15:0]  probe4 
//	.probe5({rx_demod_data4,rx_demod_valid4}), // input wire [8:0]  probe5 
//	.probe6(gnd_bit_cnt_0), // input wire [9:0]  probe6 
//	.probe7({5'd0,frame_head_flag4,frame_sync_flag4}) // input wire [6:0]  probe7
//);  

ila_fpga_fifo u_ila_fpga_fifo (
	.clk(clk_83M), // input wire clk
	.probe0(axi_str_rxd_tdata_4[0]), // input wire [31:0]  probe0  
	.probe1(axi_str_rxd_tdata_4[1]), // input wire [31:0]  probe1 
	.probe2(axi_str_rxd_tdata_4[2]), // input wire [31:0]  probe2 
	.probe3(axi_str_rxd_tdata_4[3]), // input wire [31:0]  probe3 
	.probe4(axi_str_rxd_tdata_0), // input wire [31:0]  probe4 
	.probe5(axi_str_txd_tdata_0), // input wire [31:0]  probe5 
	.probe6(axi_str_rxd_tvalid_0), // input wire [0:0]  probe6 
	.probe7(axi_str_txd_tvalid_0), // input wire [0:0]  probe7 
	.probe8(axi_str_rxd_tvalid_4[0]), // input wire [0:0]  probe8 
	.probe9(axi_str_rxd_tvalid_4[1]), // input wire [0:0]  probe9 
	.probe10(axi_str_rxd_tvalid_4[2]), // input wire [0:0]  probe10 
	.probe11(axi_str_rxd_tvalid_4[3]) // input wire [0:0]  probe11
);
`endif
//---------------------------------------------------TX 信道化发射---------------------------------------//
wire [31:0]dac[0:3][7:0];
channe_tx_dac u_channe_tx_dac(
.clk_250M(clk_250M),
.rst(rst),
.i_din_I(mod_tx_I0),//83M的数据速率 [11:0]
.i_din_Q(mod_tx_Q0),//
// 信道化发射机接口
.valid(), //output reg        
.dout0(dac[0][0]), //output reg [31:0] 
.dout1(dac[0][1]), //output reg [31:0] 
.dout2(dac[0][2]), //output reg [31:0] 
.dout3(dac[0][3]), //output reg [31:0] 
.dout4(dac[0][4]), //output reg [31:0] 
.dout5(dac[0][5]), //output reg [31:0] 
.dout6(dac[0][6]), //output reg [31:0] 
.dout7(dac[0][7])  //output reg [31:0] 
    );
// DAC接口 DAC是14位，高位对齐
// 4通道并行信道化接收，干扰调制，信道化发射
dac_interface dac_interface_u(
    .clk(clk_250M),
    .rst(rst),
//    .rst(recv_enable),//wxl ? 为什么发送的时候不能接收
//    .rst(~(valid_dac[0] | valid_dac[1] | valid_dac[2] | valid_dac[3])),
    .dac0_0(dac[0][0]),         // {Q[15:0],I[15:0]}
    .dac0_1(dac[0][1]),
    .dac0_2(dac[0][2]),
    .dac0_3(dac[0][3]),
    .dac0_4(dac[0][4]),
    .dac0_5(dac[0][5]),
    .dac0_6(dac[0][6]),
    .dac0_7(dac[0][7]),
    .dac1_0(dac[1][0]),
    .dac1_1(dac[1][1]),
    .dac1_2(dac[1][2]),
    .dac1_3(dac[1][3]),
    .dac1_4(dac[1][4]),
    .dac1_5(dac[1][5]),
    .dac1_6(dac[1][6]),
    .dac1_7(dac[1][7]),
    .dac2_0(dac[2][0]),
    .dac2_1(dac[2][1]),
    .dac2_2(dac[2][2]),
    .dac2_3(dac[2][3]),
    .dac2_4(dac[2][4]),
    .dac2_5(dac[2][5]),
    .dac2_6(dac[2][6]),
    .dac2_7(dac[2][7]),
    .dac3_0(dac[3][0]),
    .dac3_1(dac[3][1]),
    .dac3_2(dac[3][2]),
    .dac3_3(dac[3][3]),
    .dac3_4(dac[3][4]),
    .dac3_5(dac[3][5]),
    .dac3_6(dac[3][6]),
    .dac3_7(dac[3][7]),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s01_axis_tvalid(s01_axis_tvalid),
    .s02_axis_tvalid(s02_axis_tvalid),
    .s03_axis_tvalid(s03_axis_tvalid),
    .s00_axis_tdata(s00_axis_tdata),
    .s01_axis_tdata(s01_axis_tdata),
    .s02_axis_tdata(s02_axis_tdata),
    .s03_axis_tdata(s03_axis_tdata)
    );
//-----------------fifo axi-----------------//


///////////////////////////////////////////////////////////////////////////////////////////   

system_wrapper system_wrapper_i(
//       .BRAM_PORTB_addr(),
//        .BRAM_PORTB_clk(),
//        .BRAM_PORTB_din(),
//        .BRAM_PORTB_dout(),
//        .BRAM_PORTB_en(),
//        .BRAM_PORTB_rst(),
//        .BRAM_PORTB_we(),
        .I_CLK_83M(clk_83M),
        .I_clk(clk_250M),
        .I_rstn(~rst),
        .SNR_0(SNR_0),
        .adc0_clk_clk_n(adc0_clk_n),
        .adc0_clk_clk_p(adc0_clk_p),
        .adc1_clk_clk_n(adc1_clk_n),
        .adc1_clk_clk_p(adc1_clk_p),
        .air_bit_cnt_0(air_bit_cnt_0),
        .air_doppler_0(air_doppler_0),
        .air_pn_cnt_0(air_pn_cnt_0),
        .air_pn_in_cnt_0(air_pn_in_cnt_0),
        .att_choise_0(),       
        //axi rx_fifo fpga to ps fifo 0
        .AXI_STR_RXD_0_tdata (axi_str_rxd_tdata_0 ),
        .AXI_STR_RXD_0_tkeep (axi_str_rxd_tkeep_0 ),
        .AXI_STR_RXD_0_tlast (axi_str_rxd_tlast_0 ),
        .AXI_STR_RXD_0_tready(axi_str_rxd_tready_0),
        .AXI_STR_RXD_0_tvalid(axi_str_rxd_tvalid_0),
        //axi rx_fifo fpga to ps fifo 1
        .AXI_STR_RXD_1_tdata (axi_str_rxd_tdata_4 [0]  ),//axi_str_rxd_tdata_4 [0]
        .AXI_STR_RXD_1_tkeep (axi_str_rxd_tkeep_4 [0]  ),//axi_str_rxd_tkeep_4 [0]
        .AXI_STR_RXD_1_tlast (axi_str_rxd_tlast_4 [0]  ),//axi_str_rxd_tlast_4 [0]
        .AXI_STR_RXD_1_tready(axi_str_rxd_tready_4[0]),//axi_str_rxd_tready_4[0]
        .AXI_STR_RXD_1_tvalid(axi_str_rxd_tvalid_4[0]),//axi_str_rxd_tvalid_4[0]
        //axi rx_fifo fpga to ps fifo 2
        .AXI_STR_RXD_2_tdata (axi_str_rxd_tdata_4 [1]),//axi_str_rxd_tdata_4 [1]
        .AXI_STR_RXD_2_tkeep (axi_str_rxd_tkeep_4 [1]),//axi_str_rxd_tkeep_4 [1]
        .AXI_STR_RXD_2_tlast (axi_str_rxd_tlast_4 [1]),//axi_str_rxd_tlast_4 [1]
        .AXI_STR_RXD_2_tready(axi_str_rxd_tready_4[1]),//axi_str_rxd_tready_4[1]
        .AXI_STR_RXD_2_tvalid(axi_str_rxd_tvalid_4[1]),//axi_str_rxd_tvalid_4[1]
        //axi rx_fifo fpga to ps fifo 3
        .AXI_STR_RXD_3_tdata (axi_str_rxd_tdata_4 [2]),//axi_str_rxd_tdata_4 [2]
        .AXI_STR_RXD_3_tkeep (axi_str_rxd_tkeep_4 [2]),//axi_str_rxd_tkeep_4 [2]
        .AXI_STR_RXD_3_tlast (axi_str_rxd_tlast_4 [2]),//axi_str_rxd_tlast_4 [2]
        .AXI_STR_RXD_3_tready(axi_str_rxd_tready_4[2]),//axi_str_rxd_tready_4[2]
        .AXI_STR_RXD_3_tvalid(axi_str_rxd_tvalid_4[2]),//axi_str_rxd_tvalid_4[2]
        //axi rx_fifo fpga to ps fifo 4
        .AXI_STR_RXD_4_tdata (axi_str_rxd_tdata_4 [3]),//axi_str_rxd_tdata_4 [3]
        .AXI_STR_RXD_4_tkeep (axi_str_rxd_tkeep_4 [3]),//axi_str_rxd_tkeep_4 [3]
        .AXI_STR_RXD_4_tlast (axi_str_rxd_tlast_4 [3]),//axi_str_rxd_tlast_4 [3]
        .AXI_STR_RXD_4_tready(axi_str_rxd_tready_4[3]),//axi_str_rxd_tready_4[3]
        .AXI_STR_RXD_4_tvalid(axi_str_rxd_tvalid_4[3]),//axi_str_rxd_tvalid_4[3]
        //axi tx_fifo ps to fpga fifo
        .axi_str_txd_tdata_0(axi_str_txd_tdata_0),
        .axi_str_txd_tkeep_0(axi_str_txd_tkeep_0),
        .axi_str_txd_tlast_0(axi_str_txd_tlast_0),
        .axi_str_txd_tready_0(axi_str_txd_tready_0),
        .axi_str_txd_tvalid_0(axi_str_txd_tvalid_0),
        .clk_adc0(clk_adc0),
        .clk_adc1(clk_adc1),
        .clk_dac0(clk_dac0),
        .dac0_clk_clk_n(dac0_clk_n),
        .dac0_clk_clk_p(dac0_clk_p),
        .down_speed_out_0(down_speed_out_0),
        .emio_gpio_in(emio_gpio_in),
        .emio_gpio_out(emio_gpio_out),
        .gnd_bit_cnt_0(gnd_bit_cnt_0),
        .gnd_nco_0(gnd_nco_0),
        .gnd_pn_cnt_0(gnd_pn_cnt_0),
        .gnd_pn_in_cnt_0(gnd_pn_in_cnt_0),
        .m00_axis_tdata(m00_axis_tdata),
        .m00_axis_tready(m00_axis_tready),
        .m00_axis_tvalid(m00_axis_tvalid),
        .m01_axis_tdata(m01_axis_tdata),
        .m01_axis_tready(m01_axis_tready),
        .m01_axis_tvalid(m01_axis_tvalid),
        .m02_axis_tdata(m02_axis_tdata),
        .m02_axis_tready(m02_axis_tready),
        .m02_axis_tvalid(m02_axis_tvalid),
        .m03_axis_tdata(m03_axis_tdata),
        .m03_axis_tready(m03_axis_tready),
        .m03_axis_tvalid(m03_axis_tvalid),
        .m10_axis_tdata(m10_axis_tdata),
        .m10_axis_tready(m10_axis_tready),
        .m10_axis_tvalid(m10_axis_tvalid),
        .m11_axis_tdata(m11_axis_tdata),
        .m11_axis_tready(m11_axis_tready),
        .m11_axis_tvalid(m11_axis_tvalid),
        .m12_axis_tdata(m12_axis_tdata),
        .m12_axis_tready(m12_axis_tready),
        .m12_axis_tvalid(m12_axis_tvalid),
        .m13_axis_tdata(m13_axis_tdata),
        .m13_axis_tready(m13_axis_tready),
        .m13_axis_tvalid(m13_axis_tvalid),
        .mode_ctrl_out_0(mode_ctrl_out_0),
        .pl_clk(pl_clk),
        .power_det_0(),
        .power_switch_0(),
        .rf_axis_aclk(clk_250M),
        .s00_axis_tdata(s00_axis_tdata),
        .s00_axis_tready(s00_axis_tready),
        .s00_axis_tvalid(s00_axis_tvalid),
        .s01_axis_tdata(s01_axis_tdata),
        .s01_axis_tready(s01_axis_tready),
        .s01_axis_tvalid(s01_axis_tvalid),
        .s02_axis_tdata(s02_axis_tdata),
        .s02_axis_tready(s02_axis_tready),
        .s02_axis_tvalid(s02_axis_tvalid),
        .s03_axis_tdata(s03_axis_tdata),
        .s03_axis_tready(s03_axis_tready),
        .s03_axis_tvalid(s03_axis_tvalid),
        .sync_signal_0(sync_signal_0),
        .sysref_in_diff_n(sysref_in_n),
        .sysref_in_diff_p(sysref_in_p),
        ////.uart422_rxd(uart422_rxd),
        ////.uart422_txd(uart422_txd),
        .uart422_rxd(),
        .uart422_txd(),
        .up_speed_out_0(up_speed_out_0),
        .vin0_01_v_n(vin0_01_n),
        .vin0_01_v_p(vin0_01_p),
        .vin0_23_v_n(vin0_23_n),
        .vin0_23_v_p(vin0_23_p),
        .vin1_01_v_n(vin1_01_n),
        .vin1_01_v_p(vin1_01_p),
        .vin1_23_v_n(vin1_23_n),
        .vin1_23_v_p(vin1_23_p),
        .vout00_v_n(vout00_n),
        .vout00_v_p(vout00_p),
        .vout01_v_n(vout01_n),
        .vout01_v_p(vout01_p),
        .vout02_v_n(vout02_n),
        .vout02_v_p(vout02_p),
        .vout03_v_n(vout03_n),
        .vout03_v_p(vout03_p));
endmodule
