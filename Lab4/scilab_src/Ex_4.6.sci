clc; clear;

function [yn, yorigin]=conv_fold_shift(xn, xorigin, hn, horigin)
    // Truc thoi gian cho x(n) va h(n)
    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;

    // Mien xac dinh cua y(n): tu nx_dau + nh_dau den nx_cuoi + nh_cuoi
    ny = (nx(1) + nh(1)):(nx($) + nh($));
    yn = zeros(1, length(ny));

    // Gap h(k) thanh h(-k)
    hf = hn($:-1:1);
    nhf = -nh($:-1:1);

    // Voi moi n: dich h(-k) di n mau -> h(n - k), nhan voi x(k) roi cong lai
    for i = 1:length(ny)
        n = ny(i);
        nshift = nhf + n;
        for j = 1:length(nshift)
            idx = find(nx == nshift(j));
            if ~isempty(idx) then
                yn(i) = yn(i) + xn(idx) * hf(j);
            end
        end
    end

    // Goc toa do moi
    yorigin = 1 - ny(1);
endfunction

function [yn, yorigin]=conv_matrix(xn, xorigin, hn, horigin)
    // Chieu dai cua x(n), h(n) va y(n)
    Lx = length(xn);
    Lh = length(hn);
    Ly = Lx + Lh - 1;

    // Ma tran Toeplitz H (Ly x Lx): cot thu j la h(n) dich xuong j - 1 mau
    H = zeros(Ly, Lx);
    for j = 1:Lx
        H(j:j + Lh - 1, j) = hn(:);
    end

    // y = H.x
    yn = (H * xn(:))';

    // Goc toa do moi
    yorigin = xorigin + horigin - 1;
endfunction

function E=energy(xn)
    // Nang luong tin hieu roi rac: E = sum |x(n)|^2
    E = sum(abs(xn).^2);
endfunction

xn = [1, 2, -3, 2, 1];
xorigin = 1;
hn = [1, 0, -1];
horigin = 1;

// 6.3 phuong phap gap va dich
[yn1, yorigin1] = conv_fold_shift(xn, xorigin, hn, horigin);
disp(yn1, "yn (gap va dich) =");
disp(yorigin1, "yorigin =");

// 6.4 phuong phap ma tran
[yn2, yorigin2] = conv_matrix(xn, xorigin, hn, horigin);
disp(yn2, "yn (ma tran) =");
disp(yorigin2, "yorigin =");

// kiem tra voi ham conv co san cua Scilab
disp(conv(xn, hn), "conv(xn, hn) =");

// 6.5 nang luong cua x(n) va y(n)
Ex = energy(xn);
Ey = energy(yn1);
disp(Ex, "Ex =");
disp(Ey, "Ey =");

// Truc thoi gian cho x(n) va y(n)
nx = (1:length(xn)) - xorigin;
ny = (1:length(yn1)) - yorigin1;

// gioi han hien thi truc hoanh va truc tung chung
n_min = min([nx, ny]) - 1;
n_max = max([nx, ny]) + 1;
y_min = min([xn, yn1, 0]) - 1;
y_max = max([xn, yn1, 0]) + 1;

clf();

// x(n)
subplot(3, 1, 1);
ax1 = gca();
ax1.x_location = "origin";
ax1.box = "off";
plot2d3(nx, xn, 2);
plot(nx, xn, 'bo');
// dat gioi han truc sau khi ve de Scilab khong tu co gian lai
ax1.data_bounds = [n_min, y_min; n_max, y_max];
ax1.tight_limits = "on";
ax1.x_ticks = tlist(["ticks", "locations", "labels"], n_min:n_max, string(n_min:n_max));
xgrid(color('gray'));
title("$\text{Input signal } x(n)$", "fontsize", 3);
ylabel("$\text{Amplitude}$", "fontsize", 3);

// y(n) = x(n) * h(n)
subplot(3, 1, 2);
ax2 = gca();
ax2.x_location = "origin";
ax2.box = "off";
plot2d3(ny, yn1, 5);
plot(ny, yn1, 'ro');
ax2.data_bounds = [n_min, y_min; n_max, y_max];
ax2.tight_limits = "on";
ax2.x_ticks = tlist(["ticks", "locations", "labels"], n_min:n_max, string(n_min:n_max));
xgrid(color('gray'));
title("$\text{Linear convolution } y(n) = x(n) * h(n)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$\text{Amplitude}$", "fontsize", 3);

// nang luong E_x va E_y
subplot(3, 1, 3);
bar([1, 2], [Ex, Ey], 0.4, 'green');
ax3 = gca();
ax3.data_bounds = [0, 0; 3, max([Ex, Ey]) + 5];
ax3.x_ticks = tlist(["ticks", "locations", "labels"], [1, 2], ["E_x = " + string(Ex), "E_y = " + string(Ey)]);
xgrid(color('gray'));
title("$\text{Energy of } x(n) \text{ and } y(n)$", "fontsize", 3);
ylabel("$\text{Energy}$", "fontsize", 3);
