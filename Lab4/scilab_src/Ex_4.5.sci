clc; clear;

// Cac toolbox xu ly anh cho Scilab (cai qua ATOMS):
//   IPCV : Image Processing and Computer Vision, dang duoc bao tri
//          cai dat: atomsInstall("IPCV"), sau do khoi dong lai Scilab
//          ham hay dung: imread, imshow, imwrite, rgb2gray, imhist, imfilter, imresize
//   SIVP : toolbox cu, khong con duoc cap nhat cho Scilab moi
// Neu chua cai IPCV, script tu tao 1 anh xam de demo, cac phep xu ly
// ben duoi chi dung ham co san cua Scilab (conv2, cumsum, Matplot)

function img=load_gray_image(img_path)
    // doc anh bang IPCV (neu co), nguoc lai tao anh thu
    if img_path <> "" & exists("imread") then
        im = double(imread(img_path));
        if ndims(im) == 3 then
            // chuyen anh mau sang anh xam
            img = 0.299*im(:, :, 1) + 0.587*im(:, :, 2) + 0.114*im(:, :, 3);
        else
            img = im;
        end
    else
        // anh thu 128x128: nen gradient do tuong phan thap + hinh tron sang
        [c, r] = meshgrid(1:128, 1:128);
        img = 70 + 40 * c / 128;
        img(((r - 64).^2 + (c - 64).^2) < 30^2) = 140;
    end
    img = round(img);
endfunction

function h=gray_hist(img)
    // dem so pixel cho tung muc xam 0..255
    h = zeros(1, 256);
    for v = 0:255
        h(v + 1) = sum(img == v);
    end
endfunction

function out=hist_equalize(img)
    // can bang histogram: anh xa muc xam qua ham phan bo tich luy (CDF)
    h = gray_hist(img);
    cdf = cumsum(h) / sum(h);
    map = round(255 * cdf);
    out = matrix(map(img(:) + 1), size(img));
endfunction

function out=blur(img, w)
    // lam mo bang bo loc trung binh kich thuoc w x w
    kernel = ones(w, w) / (w * w);
    out = round(conv2(img, kernel, "same"));
endfunction

function [marked, extracted]=lsb_watermark(img, wm)
    // giau watermark nhi phan (0/1) vao bit thap nhat (LSB) cua anh
    marked = img - modulo(img, 2) + wm;
    // tach watermark ra lai tu bit thap nhat
    extracted = modulo(marked, 2);
endfunction

function show_img(img, ttl)
    // hien thi anh xam (gia tri 0..255) bang Matplot
    Matplot(img + 1);
    ax = gca();
    ax.isoview = "on";
    ax.axes_visible = ["off", "off", "off"];
    title(ttl, "fontsize", 3);
endfunction

// Duong dan anh (de trong "" de dung anh thu)
img_path = "";

img = load_gray_image(img_path);
[nr, nc] = size(img);

// Watermark: khung chu nhat o giua anh
wm = zeros(nr, nc);
r1 = round(nr/4); r2 = round(3*nr/4);
c1 = round(nc/4); c2 = round(3*nc/4);
wm(r1:r2, [c1:c1+3, c2-3:c2]) = 1;
wm([r1:r1+3, r2-3:r2], c1:c2) = 1;

// Thuc hien cac phep xu ly
img_eq = hist_equalize(img);
img_blur = blur(img, 5);
[img_marked, wm_out] = lsb_watermark(img, wm);

disp(max(abs(img_marked - img)), "sai lech lon nhat sau khi giau watermark =");
disp(and(wm_out == wm), "tach watermark dung =");

// Hien thi anh
f1 = scf(0);
clf(f1);
f1.color_map = gray(256);
subplot(2, 3, 1); show_img(img, "$\text{Original}$");
subplot(2, 3, 2); show_img(img_eq, "$\text{Histogram equalized}$");
subplot(2, 3, 3); show_img(img_blur, "$\text{Blur } 5 \times 5$");
subplot(2, 3, 4); show_img(img_marked, "$\text{Watermarked (LSB)}$");
subplot(2, 3, 5); show_img(255 * wm_out, "$\text{Extracted watermark}$");

// Hien thi histogram truoc va sau khi can bang
f2 = scf(1);
clf(f2);
h_orig = gray_hist(img);
h_eq = gray_hist(img_eq);
h_max = max([h_orig, h_eq]) * 1.1;

// ve dang thanh (plot2d3) thay vi bar de truc hoanh 256 muc xam khong bi dinh chu
subplot(2, 1, 1);
plot2d3(0:255, h_orig, 2);
ax1 = gca();
ax1.data_bounds = [0, 0; 255, h_max];
ax1.tight_limits = "on";
xgrid(color('gray'));
title("$\text{Histogram of original image}$", "fontsize", 3);
ylabel("$\text{Pixel count}$", "fontsize", 3);

subplot(2, 1, 2);
plot2d3(0:255, h_eq, 5);
ax2 = gca();
ax2.data_bounds = [0, 0; 255, h_max];
ax2.tight_limits = "on";
xgrid(color('gray'));
title("$\text{Histogram after equalization}$", "fontsize", 3);
xlabel("$\text{Gray level}$", "fontsize", 3);
ylabel("$\text{Pixel count}$", "fontsize", 3);
