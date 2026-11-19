clc; clear;

function X=dtft(xn, xorigin, w)
    // Bien doi Fourier thoi gian roi rac: X(w) = sum x(n).e^(-jwn)
    n = (1:length(xn)) - xorigin;
    X = xn * exp(-%i * n' * w);
endfunction

function set_pi_ticks(ax)
    // vach chia truc hoanh theo boi so cua pi, gioi han truc [-pi, pi]
    ax.x_ticks = tlist(["ticks", "locations", "labels"], [-%pi, -%pi/2, 0, %pi/2, %pi], ["-pi", "-pi/2", "0", "pi/2", "pi"]);
    b = ax.data_bounds;
    b(:, 1) = [-%pi; %pi];
    ax.data_bounds = b;
endfunction

function plot_spectrum(w, X, r, nr, name)
    // pho bien do |X(w)| (cot trai) va pho pha arg X(w) (cot phai)
    subplot(nr, 2, 2*r - 1);
    plot(w, abs(X), 'b');
    xgrid(color('gray'));
    set_pi_ticks(gca());
    title("$\text{Amplitude spectrum } |" + name + "(\omega)|$", "fontsize", 3);

    subplot(nr, 2, 2*r);
    plot(w, atan(imag(X), real(X)), 'r');
    xgrid(color('gray'));
    set_pi_ticks(gca());
    title("$\text{Phase spectrum } \angle " + name + "(\omega) \text{ (rad)}$", "fontsize", 3);
endfunction

// Tin hieu vao x(n) = 0.5^n.u(n) (lay 40 mau dau) va dap ung xung h(n) = d(n) + d(n-1)
N = 40;
n = 0:N - 1;
xn = 0.5 .^ n;
hn = [1, 1];

// Ngo ra tinh truc tiep bang tich chap (lay N mau dau)
y_conv = conv(xn, hn);
y_conv = y_conv(1:N);

// Ngo ra tinh tu bien doi Fourier: y(n) = 3.(0.5)^n.u(n) - 2.d(n)
y_ft = 3 * 0.5 .^ n - 2 * (n == 0);
disp(y_conv(1:6), "y(0..5) tinh bang tich chap =");
disp(y_ft(1:6), "y(0..5) tinh tu bien doi Fourier =");
disp(max(abs(y_conv - y_ft)), "sai lech lon nhat =");

// Pho cua X(w), H(w) va Y(w) = H(w).X(w)
w = linspace(-%pi, %pi, 1001);
X = 1 ./ (1 - 0.5 * exp(-%i * w));
H = 1 + exp(-%i * w);
Y = H .* X;
disp(max(abs(Y - dtft(y_ft, 1, w))), "sai lech giua Y(w) = H.X va DTFT cua y(n) =");

// Hinh 1: pho bien do va pho pha cua X, H, Y
f1 = scf(0);
clf(f1);
plot_spectrum(w, X, 1, 3, "X");
plot_spectrum(w, H, 2, 3, "H");
plot_spectrum(w, Y, 3, 3, "Y");

// Hinh 2: tin hieu vao x(n) va ngo ra y(n)
f2 = scf(1);
clf(f2);
subplot(2, 1, 1);
plot2d3(n(1:12), xn(1:12), 2);
plot(n(1:12), xn(1:12), 'bo');
ax1 = gca();
ax1.data_bounds = [-1, 0; 12, 1.2];
xgrid(color('gray'));
title("$\text{Input signal } x(n) = 0.5^n u(n)$", "fontsize", 3);

subplot(2, 1, 2);
plot2d3(n(1:12), y_ft(1:12), 5);
plot(n(1:12), y_ft(1:12), 'ro');
ax2 = gca();
ax2.data_bounds = [-1, 0; 12, 1.8];
xgrid(color('gray'));
title("$\text{Output signal } y(n) = x(n) * h(n)$", "fontsize", 3);
xlabel("$n$", "fontsize", 3);
