clear;
clc;
clf

n = -5:5;
u_r = n .* bool2s(n >= 0);
plot2d3(n, u_r);
