clc; clear; clf;

// Ham dinh dang truc toa do
function style_plot(n_min, n_max, y_min, y_max)
    ax = gca();
    ax.data_bounds = [n_min, y_min; n_max, y_max];
    ax.x_location = "origin";
    ax.grid = [1, 1] * color("grey70");
endfunction

// Tin hieu goc x(n)
n_x = -2:1;
x = [1, -2, 3, 6];

// Tin hieu bien doi
n_y1 = -1:2;
y1 = x($:-1:1);

n_y2 = n_x - 3;
y2 = x;

n_y3 = -3:0;
y3 = 2 * [6, 3, -2, 1];

// x(n)
subplot(2, 2, 1);
plot2d3(n_x, x, 2); plot(n_x, x, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-3, 2, -3, 7);
title("$\text{Original: } x(n) = \{1,\, -2,\, \mathbf{3},\, 6\}$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$x(n)$", "fontsize", 3);

// y1(n) = x(-n)
subplot(2, 2, 2);
plot2d3(n_y1, y1, 2); plot(n_y1, y1, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-2, 3, -3, 7);
title("$\text{1. Folding: } y_1(n) = x(-n)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$y_1(n)$", "fontsize", 3);

// y2(n) = x(n + 3)
subplot(2, 2, 3);
plot2d3(n_y2, y2, 2); plot(n_y2, y2, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-6, 1, -3, 7);
title("$\text{2. Advance: } y_2(n) = x(n + 3)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$y_2(n)$", "fontsize", 3);

// y3(n) = 2x(-n - 2)
subplot(2, 2, 4);
plot2d3(n_y3, y3, 2); plot(n_y3, y3, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-4, 1, -5, 14);
title("$\text{3. Scaling \& Shifting: } y_3(n) = 2x(-n - 2)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$y_3(n)$", "fontsize", 3);
