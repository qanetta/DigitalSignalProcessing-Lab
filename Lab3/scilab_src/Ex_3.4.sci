function [yn, yorigin]=add(x1n, x1origin, x2n, x2origin)
    // Truc thoi gian cho x1(n) va x2(n)
    n1 = (1:length(x1n)) - x1origin;
    n2 = (1:length(x2n)) - x2origin;
    
    // Mien xac dinh chung n cho phep cong
    n_start = min(min(n1), min(n2));
    n_end = max(max(n1), max(n2));
    ny = n_start:n_end;
    
    // Dong bo chieu dai va bu 0 cho hai tin hieu
    x1_aligned = zeros(1, length(ny));
    x2_aligned = zeros(1, length(ny));
    
    // Dien gia tri vao dung vi tri chi so thoi gian
    idx1 = (n1 - n_start + 1);
    idx2 = (n2 - n_start + 1);
    x1_aligned(idx1) = x1n;
    x2_aligned(idx2) = x2n;
    
    // Tin hieu tong va goc toa do moi
    yn = x1_aligned + x2_aligned;
    yorigin = 1 - n_start;
    
    // gioi han hien thi truc hoanh va truc tung
    n_min = n_start - 1;
    n_max = n_end + 1;
    y_min = min([x1_aligned, x2_aligned, yn, 0]) - 1;
    y_max = max([x1_aligned, x2_aligned, yn, 0]) + 1;
    
    clf();
    
    // x1(n)
    subplot(3, 1, 1);
    ax1 = gca();
    ax1.x_location = "origin";
    ax1.box = "off";
    ax1.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, x1_aligned, 2);
    plot(ny, x1_aligned, 'bo');
    xgrid(color('gray'));
    title("$\text{Signal } x_1(n)$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
    
    // x2(n)
    subplot(3, 1, 2);
    ax2 = gca();
    ax2.x_location = "origin";
    ax2.box = "off";
    ax2.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, x2_aligned, 2);
    plot(ny, x2_aligned, 'bo');
    xgrid(color('gray'));
    title("$\text{Signal } x_2(n)$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
    
    // y(n) = x1(n) + x2(n)
    subplot(3, 1, 3);
    ax3 = gca();
    ax3.x_location = "origin";
    ax3.box = "off";
    ax3.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, yn, 5);
    plot(ny, yn, 'ro');
    xgrid(color('gray'));
    title("$\text{Output signal } y(n) = x_1(n) + x_2(n)$", "fontsize", 3);
    xlabel("$\text{Sample index } n$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
endfunction

x1n = [0, 1, 3, -2];
x1origin = 1;
x2n = [1, 1, 2, 3];
x2origin = 2;

[yn, yorigin] = add(x1n, x1origin, x2n, x2origin);
disp(yn, "yn =");
disp(yorigin, "yorigin =");
