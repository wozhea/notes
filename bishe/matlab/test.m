fs = 8e6;
qm = 12;
fc = [1e6 2e6];
mag = [1 0];
a1 = 0.1;a2 = 0.01;
dev = [a1 a2];
[n,wn,beta,ftye] = kaiserord(fc,mag,dev,fs);
fpm = [0 fc(1)*2/fs fc(2)*2/fs 1];
magpm = [1 1 0 0 ];
h_pm = firpm(n,fpm,magpm);
q_pm = round(h_pm/max(abs(h_pm))*(2^(qm)-1));


m_pm = 20*log10(abs(fft(h_pm,1024))); m_pm = m_pm - max(m_pm);
% plot(m_pm);
q_pm = 20*log10(abs(fft(q_pm,1024))); q_pm = q_pm - max(q_pm);
plot(q_pm);