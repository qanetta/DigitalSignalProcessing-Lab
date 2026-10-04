# Digital Signal Processing - Lab Assignments

Kho lưu trữ chứa toàn bộ mã nguồn thực hành (Scilab), báo cáo và tài liệu cho môn học **Xử lý tín hiệu số (Digital Signal Processing)**.

---

## 📁 Cấu trúc thư mục (Repository Structure)

Dự án được tổ chức theo từng bài thực hành hoặc nhóm bài thực hành (`LabX`), bên trong bao gồm mã nguồn mô phỏng và tài liệu báo cáo:

```text
DigitalSignalProcessing-Lab/
├── LabX/                               # Thư mục thực hành tổng quát (ví dụ: Lab12, Lab34, ...)
│   ├── scilab_src/                     # Chứa toàn bộ mã nguồn mô phỏng Scilab
│   │   ├── LabA/                       # Script thực hành cho từng phần/bài cụ thể
│   │   │   ├── Ex_A.1.sci
│   │   │   └── Ex_A.2.sci
│   │   └── LabB/
│   │       ├── Ex_B.1.sci
│   │       └── ...
│   ├── report/                         # Báo cáo thực hành (LaTeX source & Assets)
│   │   ├── figures/                    # Hình ảnh, đồ thị mô phỏng xuất từ Scilab
│   │   ├── main.tex                    # Mã nguồn chính của báo cáo LaTeX
│   │   └── ...                         # Các gói phụ trợ hoặc cấu hình style
│   └── HK261_Report_L01_LabX_<StudentID>.pdf        # File báo cáo PDF hoàn chỉnh sau khi biên dịch
└── README.md                           # Hướng dẫn tổng quan về repository

```

---

## 🛠️Công cụ mô phỏng:** [Scilab](https://www.scilab.org/)

---

## 📌 Nội dung các bài thực hành

* **Lab 1: Làm quen với Scilab, Lấy mẫu & Lượng tử hóa tín hiệu:**
  - Thao tác đại số vector/ma trận, khảo sát tín hiệu tương tự và tín hiệu thời gian rời rạc.
  - Phân tích hiện tượng răng cưa (aliasing) và sai số lượng tử hóa bằng phương pháp cắt cụt (*truncation*).


* **Lab 2: Tín hiệu rời rạc cơ bản & Các phép biến đổi thời gian:**
  - Khảo sát các hàm cơ sở: xung đơn vị $\delta(n)$, bước nhảy đơn vị $u(n)$, dốc đơn vị $u_r(n)$.
  - Thực nghiệm phân tách thành phần chẵn/lẻ (*even/odd decomposition*).
  - Khảo sát các phép toán trên biến độc lập: cộng, nhân, đảo thời gian (*folding*), trễ/sớm (*delay/advance*).


* **Lab tiếp theo (Lab 3+):**
  - Hệ thống LTI, tích chập rời rạc (*linear convolution*).
  - Biến đổi Fourier rời rạc (DFT/FFT) và thiết kế các bộ lọc số (FIR/IIR).



---

## 👤 Tác giả (Author)

* **Họ và tên:** Trần Minh Quang
* **Môn học:** Xử lý tín hiệu số (CO2036)

```
