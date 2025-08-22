%% 参数设置
f = 5.24e9;          % 工作频率(Hz)
d = 1;               % Tx-Rx间距(m)
Tx = [-d/2, 0];      % 发射端坐标
Rx = [d/2, 0];       % 接收端坐标
n_max = 5;           % 绘制菲涅尔区数量
odd_color = [1 0 0]; % 奇数区颜色(RGB红色)
even_color = [0 0 1];% 偶数区颜色(RGB蓝色)

%% 计算波长
c = 3e8;             % 光速(m/s)
lambda = c/f;

%% 绘制菲涅尔区
figure
hold on

% 绘制设备位置
plot(Tx(1), Tx(2), 'ko', 'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor','k') 
plot(Rx(1), Rx(2), 'k^', 'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor','k')

% 绘制菲涅尔区边界
for n = 1:n_max
    % 椭圆参数计算
    delta = n*lambda/2;       % 路径差阈值
    a = (d + delta)/2;        % 长半轴
    c = d/2;                  % 焦距
    b = sqrt(a^2 - c^2);      % 短半轴
    
    % 生成椭圆坐标
    theta = linspace(0, 2*pi, 1000);
    x = a*cos(theta);
    y = b*sin(theta);
    ellipse_x = x + (Tx(1)+Rx(1))/2;
    ellipse_y = y + (Tx(2)+Rx(2))/2;
    
    % 奇偶区颜色选择
    if mod(n,2) == 1
        line_color = odd_color;
        zone_type = '奇数区';
    else
        line_color = even_color;
        zone_type = '偶数区';
    end
    
    % 绘制边界线
    plot(ellipse_x, ellipse_y, '-', 'Color', line_color, 'LineWidth', 1.5,...
         'DisplayName', sprintf('第%d区 (%s)',n,zone_type))
    
    % 填充区域（可选）
    fill(ellipse_x, ellipse_y, line_color, 'FaceAlpha',0.1, 'EdgeColor','none')
end

%% 图形修饰
axis equal
xlabel('横向距离 (m)')
ylabel('纵向距离 (m)')
title(sprintf('菲涅尔区分色图 (%.1fGHz, %dm间距)', f/1e9, d))
legend('show', 'Location','northeastoutside')
grid on
set(gca, 'FontSize',12)