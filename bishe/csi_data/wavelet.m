%%% wden函数：用小波进行一维信号的消噪或压缩
%%%  XD = wden(X,TPTR,SORH,SCAL,N,'wname')
%1.输入参数SORH=s，软阈值;Sorh=h，硬阈值；
%2.输入参数scal规定了阈值处理随噪声水平的变化：
%SCAL=one，不随噪声水平变化。
%SCAL=mln，根据每一层小波分解的噪声水平估计进行调整。
%SCAL=sln，根据第一层小波分解的噪声水平估计进行调整。
%3.wname是小波函数类型的选用
clc;close all;clear all;
rng('default');                            %随机种子重新设置
seed=2055415866;
snr=3;                                     %设置信噪比;
[xref,x]=wnoise(1,11,snr,seed);            %产生非平稳含噪信号;
N=4;
SCAL='sln';
SORH='s';
xdH=wden(x,'heursure',SORH,SCAL,N,'sym6');  %heursure阈值信号处理；
xdR=wden(x,'rigrsure',SORH,SCAL,N,'sym6');  %rigrsure阈值信号处理；
xdS=wden(x,'sqtwolog',SORH,SCAL,N,'sym6');  %sqtwolog阈值信号处理；
xdM=wden(x,'minimaxi',SORH,SCAL,N,'sym6');  %minimaxi阈值信号处理；
subplot(3,2,1);
plot(xref);title('原始信号');
axis([1,2048,-10,15]);
subplot(3,2,2);
plot(x);title('含噪信号');
axis([1,2048,-10,15]);
subplot(3,2,3);
plot(xdH);xlabel('heursure阈值消噪处理后的信号');
axis([1,2048,-10,15]);
subplot(3,2,4);
plot(xdR);xlabel('rigrsure阈值消噪处理后的信号');
axis([1,2048,-10,15]);
subplot(3,2,5);
plot(xdS);xlabel('sqtwolog阈值消噪处理后的信号');
axis([1,2048,-10,15]);
subplot(3,2,6);
plot(xdM);xlabel('minimaxi阈值消噪处理后的信号');
axis([1,2048,-10,15]);
