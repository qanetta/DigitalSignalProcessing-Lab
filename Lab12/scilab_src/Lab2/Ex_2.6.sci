clc; clear; clf;
n = -2:4;

x1 = [0,  0, 0, 1, 3, -2, 0];

x2 = [0,  0, 1, 2, 3,  0, 0];

y = x1 + x2;

// Ham dinh dang truc toa do
function style_plot(y_min, y_max)
    ax = gca();
    ax.data_bounds = [-2.5, y_min; 4.5, y_max];
    ax.x_location = "origin";
    ax.grid = [1, 1] * color("grey70");
endfunction

// Do thi tin hieu x1(n)
subplot(3, 1, 1);
plot2d3(n, x1, 2);
plot(n, x1, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-3, 4);
title("$\text{1. Signal: } x_1(n) = \{\mathbf{0},\, 1,\, 3,\, -2\}$", "fontsize", 3);
ylabel("$x_1(n)$", "fontsize", 3);

// Do thi tin hieu x2(n)
subplot(3, 1, 2);
plot2d3(n, x2, 2);
plot(n, x2, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-1, 4);
title("$\text{2. Signal: } x_2(n) = \{0,\, \mathbf{1},\, 2,\, 3\}$", "fontsize", 3);
ylabel("$x_2(n)$", "fontsize", 3);

// Do thi tin hieu tong y(n)
subplot(3, 1, 3);
plot2d3(n, y, 2);
plot(n, y, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-3, 7);
title("$\text{3. Output Signal: } y(n) = x_1(n) + x_2(n)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
ylabel("$y(n)$", "fontsize", 3);
