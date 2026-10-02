clc;
clear;
clf;

//xác định biến
f_hz = 50;
T = 1/f_hz;
t_5= 5*T;
// khoảng chu kỳ
t = linspace(0,t_5, 1000);
x_a_t= 3*sin(100*%pi*t);

// sampling
Fs = 300;
N_o = 6;
samples = N_o * 5;
n = 0 : (samples - 1);
x_n = 3*sin((%pi/3)*n);
// lượng tử hóa
delta = 0.1;
x_q = delta*floor(x_n/delta);
;
// đồ thị analog x_a_t
plot(t, x_a_t, "b", "LineWidth", 2);
xlabel("t (s)");
ylabel("Biên độ");
xgrid(1);
// đồ thị rời rạc x_n
plot2d3(n, x_n, 2); 
plot(n, x_n, "ro"); // Đánh dấu điểm mút bằng vòng tròn đỏ
xlabel("Số mẫu n");
ylabel("Biến độ");
xgrid(1);
// đồ thị đã lượng tử hóa
plot2d3(n, x_q, 5); // 5: màu đỏ
plot(n, x_q, "bd"); // Đánh dấu điểm mút bằng hình thoi xanh
title("3. Quantized Signal: x_q(n) with \Delta = 0.1 (Truncation)", "fontsize", 2);
xlabel("Sample index n");
ylabel("Amplitude");
xgrid(1);
