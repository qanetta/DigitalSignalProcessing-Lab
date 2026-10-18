function [yn, yorigin]=advance(xn, xorigin, k)
    // check k
    if k <= 0 then error("k phai > 0"); end
    
    // doi goc toa do (phep lam som dich sang phai k vi tri trong mang)
    yn = xn;
    yorigin = xorigin + k;
    
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
    
    // y(n) = x(n + k)
    subplot(2, 1, 2);
    ax2 = gca();
    ax2.x_location = "origin";
    ax2.box = "off";
    ax2.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, yn, 5);
    plot(ny, yn, 'ro');
    xgrid(color('gray'));
    title("$\text{Advance signal } y(n) = x(n + " + string(k) + ")$", "fontsize", 3);
    xlabel("$\text{Sample index } n$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
endfunction

xn = [1, -2, 3, 6];
xorigin = 3;
k = 1;

[yn, yorigin] = advance(xn, xorigin, k);
disp(yn, "yn =");
disp(yorigin, "yorigin =");
