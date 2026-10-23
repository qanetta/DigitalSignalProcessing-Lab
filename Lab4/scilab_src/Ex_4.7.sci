clc; clear;

function yn=circonv_fold_shift(xn, hn)
    // Chu ky N cua x(n) va chieu dai M cua h(n)
    N = length(xn);
    M = length(hn);
    yn = zeros(1, N);

    // y(n) = sum_{k=0}^{M-1} h(k).x((n - k) mod N), n = 0..N-1
    // gap x(k) thanh x(-k), dich n mau; chi so vuot ra ngoai [0, N-1] thi quay vong lai
    for n = 0:N - 1
        for k = 0:M - 1
            yn(n + 1) = yn(n + 1) + hn(k + 1) * xn(pmodulo(n - k, N) + 1);
        end
    end
endfunction

function yn=circonv_matrix(xn, hn)
    // Chu ky N cua x(n) va chieu dai M cua h(n)
    N = length(xn);
    M = length(hn);

    // Ma tran vong C (N x N): moi cot la x(n) dich vong xuong k mau
    C = zeros(N, N);
    for k = 0:N - 1
        for n = 0:N - 1
            C(n + 1, k + 1) = xn(pmodulo(n - k, N) + 1);
        end
    end

    // Bu 0 cho h(n) neu M < N, sau do y = C.h
    hpad = zeros(N, 1);
    hpad(1:M) = hn(:);
    yn = (C * hpad)';
endfunction

function E=energy(xn)
    // Nang luong tin hieu roi rac: E = sum |x(n)|^2
    E = sum(abs(xn).^2);
endfunction

// Ca x(n) va h(n) deu co goc tai phan tu dau tien (n = 0)
xn = [1, 2, -3, 2, 1];
hn = [1, 0, -1, -1, 1];

// 7.2 phuong phap gap va dich
yn1 = circonv_fold_shift(xn, hn);
disp(yn1, "yn (gap va dich) =");

// 7.3 phuong phap ma tran
yn2 = circonv_matrix(xn, hn);
disp(yn2, "yn (ma tran) =");

// 7.4 nang luong cua x(n) va y(n)
Ex = energy(xn);
Ey = energy(yn1);
disp(Ex, "Ex =");
disp(Ey, "Ey =");

// Truc thoi gian n = 0..N-1
n = 0:length(xn) - 1;

// gioi han hien thi truc hoanh va truc tung chung
n_min = -1;
n_max = length(xn);
y_min = min([xn, yn1, 0]) - 1;
y_max = max([xn, yn1, 0]) + 1;

clf();

// x(n)
subplot(3, 1, 1);
ax1 = gca();
ax1.x_location = "origin";
ax1.box = "off";
plot2d3(n, xn, 2);
plot(n, xn, 'bo');
// dat gioi han truc sau khi ve de Scilab khong tu co gian lai
ax1.data_bounds = [n_min, y_min; n_max, y_max];
ax1.tight_limits = "on";
ax1.x_ticks = tlist(["ticks", "locations", "labels"], n_min:n_max, string(n_min:n_max));
xgrid(color('gray'));
title("$\text{Periodic signal } x(n), N = " + string(length(xn)) + "$", "fontsize", 3);
ylabel("$\text{Amplitude}$", "fontsize", 3);

// y(n) = x(n) (N) h(n)
subplot(3, 1, 2);
ax2 = gca();
ax2.x_location = "origin";
ax2.box = "off";
plot2d3(n, yn1, 5);
plot(n, yn1, 'ro');
ax2.data_bounds = [n_min, y_min; n_max, y_max];
ax2.tight_limits = "on";
ax2.x_ticks = tlist(["ticks", "locations", "labels"], n_min:n_max, string(n_min:n_max));
xgrid(color('gray'));
title("$\text{Circular convolution } y(n) = x(n) \circledast h(n)$", "fontsize", 3);
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
