clc; clear;

// Cac ham xu ly am thanh co san trong Scilab (khong can cai toolbox):
//   wavread / wavwrite  : doc / ghi file .wav
//   loadwave / savewave : doc / ghi file .wav (dang cu)
//   auread / auwrite    : doc / ghi file .au
//   sound / playsnd     : phat am thanh ra loa
//   analyze             : ve pho tan so cua tin hieu
//   mapsound            : ve spectrogram (pho theo thoi gian)
//   lin2mu / mu2lin     : nen / giai nen mu-law

function [y, fs]=load_audio(wav_path)
    // doc file .wav, neu khong co file thi tao tin hieu thu
    if wav_path <> "" then
        [y, fs, bits] = wavread(wav_path);
        disp(bits, "so bit moi mau =");
    else
        // tin hieu thu: tong 2 song sin 440 Hz va 880 Hz trong 1 giay
        fs = 8000;
        t = 0:1/fs:1 - 1/fs;
        y = 0.5*sin(2*%pi*440*t) + 0.3*sin(2*%pi*880*t);

        // ghi ra file .wav roi doc lai de thu wavwrite / wavread
        tmp_file = TMPDIR + "/ex4_4.wav";
        wavwrite(y, fs, tmp_file);
        [y, fs] = wavread(tmp_file);
    end

    // chi lay kenh dau tien va dua ve vector hang
    if size(y, 1) > 1 & size(y, 2) > 1 then
        if size(y, 1) < size(y, 2) then
            y = y(1, :);
        else
            y = y(:, 1)';
        end
    end
    y = matrix(y, 1, -1);
endfunction

// Duong dan file .wav (de trong "" de dung tin hieu thu)
wav_path = "";

[y, fs] = load_audio(wav_path);
N = length(y);
disp(fs, "tan so lay mau fs =");
disp(N / fs, "thoi luong (s) =");

// Truc thoi gian va pho bien do (FFT)
t = (0:N - 1) / fs;
Y = abs(fft(y)) / N;
f = (0:N - 1) * fs / N;
half = 1:floor(N / 2);

clf();

// dang song theo thoi gian (chi ve 20 ms dau cho de nhin)
subplot(2, 1, 1);
n_show = min(N, round(0.02 * fs));
plot(t(1:n_show), y(1:n_show), 'b');
xgrid(color('gray'));
title("$\text{Audio waveform } x(t)$", "fontsize", 3);
xlabel("$\text{Time (s)}$", "fontsize", 3);
ylabel("$\text{Amplitude}$", "fontsize", 3);

// pho bien do (nua duong tan so 0 -> fs/2)
subplot(2, 1, 2);
plot(f(half), 2 * Y(half), 'r');
xgrid(color('gray'));
title("$\text{Magnitude spectrum } |X(f)|$", "fontsize", 3);
xlabel("$\text{Frequency (Hz)}$", "fontsize", 3);
ylabel("$\text{Magnitude}$", "fontsize", 3);

// bo comment dong duoi de nghe thu am thanh
// playsnd(y, fs);
