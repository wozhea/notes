figure,plot(timestamp(n_start:n_stop),csi_sub,'g'),hold on;
plot(timestamp(n_start:n_stop),csi_filter_normal,'b'),hold on;
plot(timestamp(n_start:n_stop),csi_wavelet,'r','LineWidth', 2),
legend('csi-raw','csi-hampel','csi-wavelet','FontSize',14);
xlabel('timestamp/us'),ylabel('amplitude');