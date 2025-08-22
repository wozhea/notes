function [detected_packet,packet_detected] = sync_short(rx_signal)

% 用于捕获数据包，粗频偏估计和同步

search_win = 600;
D = 16; %自相关窗长
avg_D = 16; %平均长度

% Calculate the delayd correlation
delay_xcorr = rx_signal(1:search_win+2*D).*conj(rx_signal(1*D+1:search_win+3*D));
% figure(1),plot(abs(delay_xcorr));
% Moving average of the delayed correlation
% a = abs(sum(delay_xcorr(1:32)))/32;
% mvg_delay_xcorr = abs(filter(ones(1,avg_D), 1, delay_xcorr));%%平均,求幅度
% figure(1),plot(mvg_delay_xcorr);
for i = 1:search_win
mvg_delay_xcorr(i) = abs(sum(delay_xcorr(i:i+avg_D)));%%平均,求幅度
mvg_rx_pwr(i) = sum(abs(rx_signal(i:i+avg_D).^2));
end


% Moving average of received power
% mvg_rx_pwr = filter(ones(1,avg_D), 1, abs(rx_signal(1*D+1:search_win+3*D)).^2);
% mvg_rx_pwr = filter(ones(1,avg_D), 1, abs(rx_signal(1:search_win+2*D)).^2);


% The decision variable
delay_len = length(mvg_delay_xcorr);
mvg_M = mvg_delay_xcorr(1:delay_len)./mvg_rx_pwr(1:delay_len);

% remove delay samples
% mvg_M(1:avg_D) = [];
% figure(1),plot(abs(mvg_M));

thres_idx = zeros(1,1);

threshold = 0.8;
count = sum(mvg_M>threshold);
if count>=100
    packet_detected =1;
    thres_idx = find(mvg_M > threshold);
else
    packet_detected =0;
end

if thres_idx(1) == 0 
  thres_idx = 1;
else
  thres_idx = thres_idx(1);
end


detected_packet = rx_signal(thres_idx:length(rx_signal));
