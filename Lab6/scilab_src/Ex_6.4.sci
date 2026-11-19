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

// He LTI: y(n) + 0.1y(n-1) + 0.2y(n-2) = x(n)
a = [1, 0.1, 0.2];
b = 1;

// Dap ung xung h(n): cho x(n) = d(n) qua he (tinh de quy bang filter), lay 40 mau
N = 40;
d = [1, zeros(1, N - 1)];
hn = filter(b, a, d);
disp(hn(1:6), "h(0..5) =");

// Dap ung tan so tu cong thuc H(w) = 1/(1 + 0.1e^(-jw) + 0.2e^(-j2w))
w = linspace(-%pi, %pi, 1001);
H = 1 ./ (a(1) + a(2) * exp(-%i * w) + a(3) * exp(-2 * %i * w));

// kiem tra lai bang DTFT cua h(n) da tinh
H_so = dtft(hn, 1, w);
disp(max(abs(H - H_so)), "sai lech lon nhat giua H tinh so va cong thuc =");
disp(abs(1 / sum(a)), "|H(0)| =");
disp(abs(1 / (a(1) - a(2) + a(3))), "|H(pi)| =");

clf();

// h(n)
subplot(3, 1, 1);
n = 0:N - 1;
plot2d3(n(1:15), hn(1:15), 2);
plot(n(1:15), hn(1:15), 'bo');
ax1 = gca();
ax1.data_bounds = [-1, -0.4; 15, 1.2];
xgrid(color('gray'));
title("$\text{Impulse response } h(n)$", "fontsize", 3);
xlabel("$n$", "fontsize", 3);

// pho bien do |H(w)|
subplot(3, 1, 2);
plot(w, abs(H), 'b');
xgrid(color('gray'));
set_pi_ticks(gca());
title("$\text{Amplitude spectrum } |H(\omega)|$", "fontsize", 3);

// pho pha arg H(w)
subplot(3, 1, 3);
plot(w, atan(imag(H), real(H)), 'r');
xgrid(color('gray'));
set_pi_ticks(gca());
title("$\text{Phase spectrum } \angle H(\omega) \text{ (rad)}$", "fontsize", 3);
xlabel("$\omega \text{ (rad/sample)}$", "fontsize", 3);
