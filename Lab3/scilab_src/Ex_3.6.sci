function [yn, yorigin]=convolution(xn, xorigin, hn, horigin)
    // Chieu dai cua x(n), h(n) va y(n)
    Lx = length(xn);
    Lh = length(hn);
    Ly = Lx + Lh - 1;

    // Tich chap: y(n) = sum_k x(k).h(n - k)
    yn = zeros(1, Ly);
    for i = 1:Lx
        for j = 1:Lh
            yn(i + j - 1) = yn(i + j - 1) + xn(i) * hn(j);
        end
    end

    // Goc toa do moi (chi so bat dau cua y = tong chi so bat dau cua x va h)
    yorigin = xorigin + horigin - 1;

    // Truc thoi gian cho x(n), h(n) va y(n)
    nx = (1:Lx) - xorigin;
    nh = (1:Lh) - horigin;
    ny = (1:Ly) - yorigin;

    // gioi han hien thi truc hoanh va truc tung chung
    n_min = min([nx, nh, ny]) - 1;
    n_max = max([nx, nh, ny]) + 1;
    y_min = min([xn, hn, yn, 0]) - 1;
    y_max = max([xn, hn, yn, 0]) + 1;

    clf();

    // x(n)
    subplot(3, 1, 1);
    ax1 = gca();
    ax1.x_location = "origin";
    ax1.box = "off";
    ax1.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(nx, xn, 2);
    plot(nx, xn, 'bo');
    xgrid(color('gray'));
    title("$\text{Input signal } x(n)$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);

    // h(n)
    subplot(3, 1, 2);
    ax2 = gca();
    ax2.x_location = "origin";
    ax2.box = "off";
    ax2.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(nh, hn, 2);
    plot(nh, hn, 'bo');
    xgrid(color('gray'));
    title("$\text{Impulse response } h(n)$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);

    // y(n) = x(n) * h(n)
    subplot(3, 1, 3);
    ax3 = gca();
    ax3.x_location = "origin";
    ax3.box = "off";
    ax3.data_bounds = [n_min, y_min; n_max, y_max];
    plot2d3(ny, yn, 5);
    plot(ny, yn, 'ro');
    xgrid(color('gray'));
    title("$\text{Output signal } y(n) = x(n) * h(n)$", "fontsize", 3);
    xlabel("$\text{Sample index } n$", "fontsize", 3);
    ylabel("$\text{Amplitude}$", "fontsize", 3);
endfunction

xn = [1, 2, 3];
xorigin = 2;
hn = [1, -1, 2];
horigin = 1;

[yn, yorigin] = convolution(xn, xorigin, hn, horigin);
disp(yn, "yn =");
disp(yorigin, "yorigin =");
