%% 参数设置
f = 2.412e9;          % 工作频率(Hz) 5.24GHz
d = 1;               % Tx-Rx间距(m)
Tx = [-d/2, 0];      % 发射端坐标
Rx = [d/2, 0];       % 接收端坐标
n_max = 12;           % 绘制前n_max个菲涅尔区
% color_map = lines(n_max); % 颜色映射

%% 计算波长
c = 3e8;             % 光速(m/s)
lambda = c/f;

%% 绘制菲涅尔区
figure
hold on

% 绘制Tx/Rx位置
plot(Tx(1), Tx(2), 'ro', 'MarkerSize', 5, 'LineWidth', 8,'DisplayName','T','HandleVisibility','off') 
plot(Rx(1), Rx(2), 'bo', 'MarkerSize', 5, 'LineWidth', 8,'DisplayName','R','HandleVisibility','off')

% 绘制某个子载波菲涅尔区
for n = 1:n_max
    if(mod(n,2)==1)
        color = [255 99 71]/255;
    else
         color = [135 206 250]./255;
    end
    % 椭圆参数
    a = (d + n*lambda/2)/2;    % 长半轴
    c = d/2;                   % 焦距
    b = sqrt(a^2 - c^2);       % 短半轴
    
    % 椭圆参数方程
    theta = linspace(0, 2*pi, 100000);
    x = a*cos(theta);
    y = b*sin(theta);
    
    % 平移椭圆至焦点中间
    ellipse_x = x + (Tx(1)+Rx(1))/2;
    ellipse_y = y + (Tx(2)+Rx(2))/2;
    
    plot(ellipse_x, ellipse_y, '-', ...
         'Color', color, ...
         'LineWidth', 1.5) 
end

%% 图形修饰
axis equal
xlabel('m')
ylabel('m')
title(['Fresnel Zone fc=' num2str(f/1e9) 'GHz, LOS=' num2str(d) 'm'])
% legend('show', 'Location','best')
legend('Boundary of odd Fresnel Zone','Boundary of even Fresnel Zone','FontSize',17);
grid on