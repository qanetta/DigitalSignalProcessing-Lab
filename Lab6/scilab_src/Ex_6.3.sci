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
    xlabel("$\omega \text{ (rad/sample)}$", "fontsize", 3);

    subplot(nr, 2, 2*r);
    plot(w, atan(imag(X), real(X)), 'r');
    xgrid(color('gray'));
    set_pi_ticks(gca());
    title("$\text{Phase spectrum } \angle " + name + "(\omega) \text{ (rad)}$", "fontsize", 3);
    xlabel("$\omega \text{ (rad/sample)}$", "fontsize", 3);
endfunction

// Truc tan so w trong mot chu ky [-pi, pi]
w = linspace(-%pi, %pi, 1001);

// 3.1 x1(n) = 0.1^n.u(n), cat bot con 30 mau dau (0.1^30 xap xi 0)
n1 = 0:29;
x1 = 0.1 .^ n1;
X1 = dtft(x1, 1, w);

// so sanh voi cong thuc giai tich X1(w) = 1/(1 - 0.1.e^(-jw))
X1_ct = 1 ./ (1 - 0.1 * exp(-%i * w));
disp(max(abs(X1 - X1_ct)), "sai lech lon nhat giua X1 tinh so va cong thuc =");
disp(abs(dtft(x1, 1, 0)), "|X1(0)| =");
disp(abs(dtft(x1, 1, %pi)), "|X1(pi)| =");

// 3.2 x2(n) = d(n) + d(n-1) + d(n-2) + d(n-3)
x2 = [1, 1, 1, 1];
X2 = dtft(x2, 1, w);
disp(abs(dtft(x2, 1, 0)), "|X2(0)| =");
disp(abs(dtft(x2, 1, [%pi/2, %pi])), "|X2(pi/2)|, |X2(pi)| =");

clf();
plot_spectrum(w, X1, 1, 2, "X_1");
plot_spectrum(w, X2, 2, 2, "X_2");
