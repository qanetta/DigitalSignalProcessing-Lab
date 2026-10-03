clc; clear; clf;

n = -2:2;
x = [0, 1, 3, -2, 0];


x_fold = x($:-1:1);
xe = 0.5 * (x + x_fold);
xo = 0.5 * (x - x_fold);

// Ham con ho tro dinh dang
function style_plot(y_min, y_max)
    ax = gca();
    ax.data_bounds = [-2.5, y_min; 2.5, y_max]; 
    ax.x_location = "origin";
    ax.grid = [1, 1] * color("grey70");
endfunction

// Do thi tin hieu goc x(n)
subplot(3, 1, 1);
plot2d3(n, x, 2); 
plot(n, x, "ro"); 
h = gce(); h.children(1).mark_size = 5; 
style_plot(-3, 4);
title("$\text{1. Original Signal: } x(n) = \{1,\, \mathbf{3},\, -2\}$", "fontsize", 3);
ylabel("$x(n)$", "fontsize", 3);

// Do thi thanh phan chan x_e(n)
subplot(3, 1, 2);
plot2d3(n, xe, 2);
plot(n, xe, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-1.5, 3.5);
title("$\text{2. Even Component: } x_e(n) = \frac{1}{2}[x(n) + x(-n)]$", "fontsize", 3);
ylabel("$x_e(n)$", "fontsize", 3);

//Do thi thanh phan le x_o(n)
subplot(3, 1, 3);
plot2d3(n, xo, 2);
plot(n, xo, "ro");
h = gce(); h.children(1).mark_size = 5;
style_plot(-2.5, 2.5);
title("$\text{3. Odd Component: } x_o(n) = \frac{1}{2}[x(n) - x(-n)]$", "fontsize", 3);
ylabel("$x_o(n)$", "fontsize", 3);
xlabel("$\text{Sample index } n$", "fontsize", 3);
