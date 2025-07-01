%%80211n引入52个数据子载波，这里只发了80211a/g包，只有48+4个有效csi估计
csi_raw = abs(csi(3:54,1:end));

figure,plot(csi_raw.'),xlabel("us"),ylabel("amplitude");

% csi_phase_raw = unwrap(angle(csi(3:3,1:end)));
% figure,plot(timestamp,csi_phase_raw.'),xlabel("us"),ylabel('phase');

time = timestamp(end)-timestamp(1);
csi_length=length(csi_raw(1,1:end));
fs = double(csi_length*1e6/time);



%选用某序列子载波
% csi_raw = abs(csi(52,1:end));
% figure,plot(csi_raw);

% 选取有效时间
n_start = 40;
n_stop = 670;
time = timestamp(n_stop)-timestamp(n_start);
csi_length=length(csi_raw(1,n_start:n_stop));
fs = double(csi_length*1e6/time);

figure,plot(timestamp(n_start:n_stop),csi_raw(1:52,n_start:n_stop).'),xlabel("us"),ylabel("amplitude");


% csi_phase = angle(csi(3:54,n_start:n_stop));
% csi_phase_unwrap = unwrap(csi_phase);
% figure,plot(csi_phase_unwrap);
% 
% csi_phase_diff = diff(csi_phase_unwrap);


% figure,plot(unwrap(csi_phase));

% figure,plot(timestamp(n_start:n_stop),unwrap(angle(csi_raw(1:52,n_start:n_stop).')));


freq_subs = zeros(1,52);
max_amp = zeros(1,52);
max_index = zeros(1,52);
csi_sub = zeros(1,csi_length);
for n = 1:52

csi_sub = csi_raw(n,n_start:n_stop);
% figure,plot(timestamp(n_start:n_stop),csi_sub),hold on;

%%带通滤波器
fc_breath_low = 10/60; %成人呼吸频率
% fc_breath_high = 40/60;%婴儿呼吸频率
fc_breath_high = 60/60;
fc_high = 120/60;%移动最高频率

N = 10;



%hampel滤波器离群值去除
csi_filter_normal = hampel(csi_sub,20,3);
csi_filter_normal_var = var (csi_filter_normal);
% plot(timestamp(n_start:n_stop),csi_filter_normal),hold on;


% 带通滤波器滤除噪声
csi_filter_bandpass = bandpass(csi_filter_normal(1,1:end),[fc_breath_low,fc_breath_high],fs);
% plot(timestamp(n_start:n_stop),csi_filter_bandpass),hold on;

% 小波变换分析
N=4;                %Level of wavelet decomposition
SCAL='sln';         %Multiplicative threshold rescaling
SORH='s';           %Type of thresholding
csi_wavelet=wden(csi_filter_normal,'heursure',SORH,SCAL,N,'sym6');  %heursure阈值信号处理；
% csi_wavelet=wden(csi_filter_normal,'rigrsure',SORH,SCAL,N,'sym6');  %rigrsure阈值信号处理；
% csi_wavelet=wden(csi_filter_normal,'sqtwolog',SORH,SCAL,N,'sym6');  %sqtwolog阈值信号处理；
% csi_wavelet=wden(csi_filter_normal,'minimaxi',SORH,SCAL,N,'sym6');  %minimaxi阈值信号处理；


% plot(timestamp(n_start:n_stop),csi_wavelet,'b'),hold off;


% csi_fft = abs(fft(csi_filter_bandpass)); %带通
csi_fft = abs(fft(csi_wavelet)); %小波变换




[max_amp(n),max_index(n)]= max(csi_fft);

n = 0:csi_length-1;
f = n*fs/csi_length;
plot(f(1:csi_length/2),csi_fft(1:csi_length/2)/csi_length),xlim([0.1 1]),hold on;

end


% figure(1),plot(timestamp,phase(csi(4,1:end)));
% figure(2),plot(abs(csi(7,1:end)))