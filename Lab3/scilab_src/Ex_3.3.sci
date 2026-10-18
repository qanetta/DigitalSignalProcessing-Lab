function [yn, yorigin]=fold(xn, xorigin)
    // Dao nguoc thu tu mang va cap nhat goc toa do moi
    yn = xn($:-1:1);
    yorigin = length(xn) - xorigin + 1;
    
    // Truc thoi gian cho x(n) va y(n)
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    // gioi han hien thi truc hoanh va truc tung chung
    n_min = min(min(nx), min(ny)) - 1;
    n_max = max(max(nx), max(ny)) + 1;
    y_min = min([xn, yn, 0]) - 1;
    y_max = max([xn, yn, 0]) + 1;
    
    clf();
    
    // x(n)
    subplot(2, 1, 1);
    ax1 = gca();
    ax1.x_location = "origin";
    ax1.box = "off";
    ax1.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(nx, xn, 2);
    plot(nx, xn, 'bo');
    xgrid(color('gray'));
    title("$\text{Signal } x(n)$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
    
    // y(n) = x(-n)
    subplot(2, 1, 2);
    ax2 = gca();
    ax2.x_location = "origin";
    ax2.box = "off";
    ax2.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, yn, 5);
    plot(ny, yn, 'ro');
    xgrid(color('gray'));
    title("$\text{Folded signal } y(n) = x(-n)$", "fontsize", 3);
    xlabel("$\text{Sample index } n$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
endfunction

xn = [1, -2, 3, 6];
xorigin = 3;

[yn, yorigin] = fold(xn, xorigin);
disp(yn, "yn =");
disp(yorigin, "yorigin =");
