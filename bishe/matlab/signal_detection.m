clear;
close all;
% wifi系统参数
fs = 20e6;
T = 1/fs;
modulation_level = 2;                      %modulation ,1--bpsk,2--4QAM,4--16QAM,6--64QAM
modulation_level_SIGNAL = 1;
NormFactor = sqrt(2/3*(modulation_level.^2-1));%归一化功率
gi = 1/4;                    %CP length，short cp
fftlen = 64;                    
cplen = gi*fftlen;           
sym = fftlen + cplen;        % total length of the block with CP
N_pilot=4;                   %导频载波数量，根据802.11a标准
Nused=52;                    %实际使用52个载波，48个信息载波，4个导频载波


% 信道与频偏参数
fc = 2412e6;%%载频,channel1=2412,channel6=2437,channel11=2462

h = zeros(cplen,1);  % 定义多径信道
h(1) = 1; h(3) = 0.2; h(5) = 0.1;   % 假设3径
h = h/norm(h);       %归一化
% CFO = 0.1*fs/fft_len;    % 频偏，发射接受机载波振荡+多普勒
CFO = 120e3;    % 频偏，收发机采样频偏+多普勒,5.8G,20ppm=120KHz，多普勒一般较小，假设无人机场景，相背飞行2KHZ



% 子载波映射规则
DataSubcPatt = [1:5 7:19 21:26 27:32 34:46 48:52]';
PilotSubcPatt = [6 20 33 47];
UsedSubcIdx = [7:32 34:59];
trellis = poly2trellis(7,[133 171]); % 133，171卷积器
tb = 7*5;
ConvCodeRate = 1/2;       % 1/2卷积码效率
InterleaveBits = 1;



%%前导训练序列生成
% L_STF
ShortTrain = sqrt(13/6)*[0 0 1+j 0 0 0 -1-j 0 0 0 1+j 0 0 0 -1-j 0 0 0 -1-j 0 ...
 0 0 1+j 0 0 0 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0].';
NumShortTrainBlks = 10;
NumShortComBlks = 16*NumShortTrainBlks/sym;
short_train = tx_freqd_to_timed(ShortTrain);
%plot(abs(short_train));
short_train_blk = short_train(1:16);
short_train_blks = repmat(short_train_blk,NumShortTrainBlks,1);


% L_LTF
LongTrain = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 ...
      1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1].';
NumLongTrainBlks = 2;
NumTrainBlks = NumShortComBlks + NumLongTrainBlks;
long_train = tx_freqd_to_timed(LongTrain);
long_train_syms = [long_train(fftlen-2*cplen+1:fftlen,:); long_train; long_train];%32CP+64+64
preamble = [short_train_blks; long_train_syms];


% packet information
NumBitsPerBlk = 48*modulation_level*ConvCodeRate;
NumBlksPerPkt = 20;%假设每包20个ofdm符号
NumBitsPerPkt = NumBitsPerBlk*NumBlksPerPkt;
NumPkts = 100000;

% timing parameters
ExtraNoiseSamples = 50;

%% ************** Loop start***************************
snr = 5:0.5:12;
sum_detect = zeros(1,length(snr))
for snr_index = 1:length(snr)
    for pkt_index = 1:NumPkts
%% *********************** Transmitter ******************************
%%L_STF+L_LTF+SIGNAL+DATA
%%%%%%%%%%%%%%%%%%%L_SINAL域信号生成 RATE
        SINAL_f_RATE_R_LEN = [1 1 0 1 0  randi([0 1],1,12)  ];
        SINAL_f_parity = mod(sum(SINAL_f_RATE_R_LEN),2);
        SINAL_f = [SINAL_f_RATE_R_LEN SINAL_f_parity 0 0 0 0 0 0];
        CONVENC_data_SINAL= convenc(SINAL_f,trellis);%卷积
            for k=1:48%交织
                 i = 3*(mod(k-1,16))+floor((k-1)/16);
                 INTERLEAE_data_SINAL(i+1) = CONVENC_data_SINAL(k);
            end
        INTERLEAE_data_SINAL = reshape(INTERLEAE_data_SINAL,length(INTERLEAE_data_SINAL)/1,1); %%SINAL域使用BPSK
        INTERLEAE_data_SINAL = qammod(bi2de(INTERLEAE_data_SINAL),2^modulation_level_SIGNAL);  
        mod_ofdm_sym_signal = zeros(52,1);
        mod_ofdm_sym_signal(DataSubcPatt,:) = reshape(INTERLEAE_data_SINAL,48,1);
        mod_ofdm_sym_signal(PilotSubcPatt,:) = 1; % 加导频，导频载波位置处为1
        %对SIGNAL符号作IFFT
        signal_t = tx_freqd_to_timed(mod_ofdm_sym_signal);
        signal_t = [signal_t(fftlen-cplen+1:fftlen,:); signal_t];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%固定前导生成完成，L_STF+L_LTF+L_SIGNAL

        preamble_signal = [short_train_blks; long_train_syms;signal_t]; 

        % 生成WIFI OFDM数据符号，按最简单的格式，无HT_signal,ht_stf,ht_ltf
        inf_bits = randn(1,NumBitsPerPkt)>0;
        CodedSeq = convenc(inf_bits,trellis);
        if InterleaveBits
           rdy_to_mod_bits = tx_interleaver(CodedSeq,48, modulation_level);
        else
           rdy_to_mod_bits = CodedSeq;
        end
        %数据符号Modulate
        paradata = reshape(rdy_to_mod_bits,length(rdy_to_mod_bits)/modulation_level,modulation_level);
        ModedSeq = qammod(bi2de(paradata),2^modulation_level)/NormFactor;
		%填好52个子载波
        mod_ofdm_syms = zeros(52, NumBlksPerPkt);
        mod_ofdm_syms(DataSubcPatt,:) = reshape(ModedSeq, 48, NumBlksPerPkt);
        mod_ofdm_syms(PilotSubcPatt,:) = 1;
		%IFFT
        tx_blks = tx_freqd_to_timed(mod_ofdm_syms);
        % Guard interval insertion
        tx_frames = [tx_blks(fftlen-cplen+1:fftlen,:); tx_blks];
        % P/S
        tx_seq = reshape(tx_frames,NumBlksPerPkt*sym,1);
tx = [preamble_signal;tx_seq];   %%最终发送生成数据



%% ****************************** Channel****************************

start_time = 100/3e8;               %%路径传播的时延，用于产生不同的相位旋转
t_tx = [0:(length(tx)-1)]/fs;
t_tx(1:length(t_tx)) = t_tx(1:length(t_tx))+start_time;
shift = exp(j*2*pi*fc.*t_tx);
% figure(1);plot(real(tx));hold on;plot(imag(tx));


        ExtraNoiseSamples_max = 50;
        Len_signal = randi(ExtraNoiseSamples_max);


%         FadedSignal = filter(h,1,tx);
        FadedSignal = tx;
%         len = length(FadedSignal);
        noise_var = 1/(10^(snr(snr_index)/10))/2;
%         noise = sqrt(noise_var) * (randn(len,1) + j*randn(len,1));
        % add noise

        % extra noise samples are inserted before the packet to test the packet search algorithm
%         extra_noise = sqrt(noise_var) * (randn(ExtraNoiseSamples,1) + j*randn(ExtraNoiseSamples,1));
        % end noise is added to prevent simulation from crashing from incorrect timing in receiver

        signal_exist = randi([0,1],1,1);
%         rx = [extra_noise; rx_signal; end_noise];

% rx = [zeros(50,1); signal_exist*FadedSignal; zeros(170,1)];
rx = [zeros(50,1); FadedSignal; zeros(170,1)];

        extra_noise = sqrt(noise_var) * (randn(length(rx),1) + j*randn(length(rx),1));
        rx = rx+extra_noise;

% rx = [zeros(50,1); rx_signal; zeros(170,1)];
%         rx = [zeros(500,1);tx];
% plot(abs(rx));


        % introduce CFO
%         total_length = length(rx);
%         t = [0:total_length-1]/fs;
%         phase_shift = exp(j*2*pi*CFO*t).';
%         rx = rx.*phase_shift;

%% *************************  Receiver  ****************************

        %信号检测
        [rx_signal,packet_detected] = sync_short(rx);

% if signal_exist == packet_detected
if packet_detected == 1
sum_detect(snr_index) =sum_detect(snr_index)+1;

end

    end
    display(snr(snr_index));
end