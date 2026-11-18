-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: sql109.infinityfree.com
-- Thời gian đã tạo: Th10 18, 2026 lúc 08:23 AM
-- Phiên bản máy phục vụ: 11.4.13-MariaDB
-- Phiên bản PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `if0_43472101_gym`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dang_ky_goi`
--

CREATE TABLE `dang_ky_goi` (
  `ma_dk` int(11) NOT NULL,
  `ma_hv` int(11) NOT NULL,
  `ma_goi` int(11) NOT NULL,
  `ma_nv` int(11) NOT NULL,
  `ngay_dang_ky` timestamp NULL DEFAULT current_timestamp(),
  `ngay_bat_dau` date NOT NULL,
  `ngay_ket_thuc` date NOT NULL,
  `tong_tien` decimal(12,0) NOT NULL,
  `trang_thai` enum('CHO_THANH_TOAN','HOAT_DONG','HET_HAN','HUY') DEFAULT 'CHO_THANH_TOAN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diem_danh`
--

CREATE TABLE `diem_danh` (
  `ma_dd` int(11) NOT NULL,
  `ma_hv` int(11) NOT NULL,
  `ma_nv` int(11) NOT NULL,
  `thoi_gian_vao` datetime NOT NULL,
  `thoi_gian_ra` datetime DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `goi_tap`
--

CREATE TABLE `goi_tap` (
  `ma_goi` int(11) NOT NULL,
  `ten_goi` varchar(100) NOT NULL,
  `thoi_han_thang` int(11) NOT NULL,
  `gia` decimal(12,0) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `trang_thai` enum('HOAT_DONG','NGUNG_BAN') DEFAULT 'HOAT_DONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `goi_tap`
--

INSERT INTO `goi_tap` (`ma_goi`, `ten_goi`, `thoi_han_thang`, `gia`, `mo_ta`, `trang_thai`) VALUES
(1, 'Gói Cơ Bản 1 Tháng', 1, '500000', 'Tập không giới hạn thiết bị cơ bản', 'HOAT_DONG'),
(2, 'Gói Tiêu Chuẩn 3 Tháng', 3, '1350000', 'Tặng kèm 1 buổi đo chỉ số InBody', 'HOAT_DONG'),
(3, 'Gói VIP 6 Tháng', 6, '2500000', 'Full dịch vụ xông hơi, khăn tắm miễn phí', 'HOAT_DONG'),
(4, 'Gói Năm 12 Tháng', 12, '4500000', 'Ưu đãi tiết kiệm 25%, tặng 1 tháng tập', 'HOAT_DONG');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoi_vien`
--

CREATE TABLE `hoi_vien` (
  `ma_hv` int(11) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `gioi_tinh` enum('Nam','Nữ','Khác') DEFAULT NULL,
  `so_dien_thoai` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `ngay_tao` timestamp NULL DEFAULT current_timestamp(),
  `trang_thai` enum('HOAT_DONG','TAM_KHOA') DEFAULT 'HOAT_DONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hoi_vien`
--

INSERT INTO `hoi_vien` (`ma_hv`, `ho_ten`, `ngay_sinh`, `gioi_tinh`, `so_dien_thoai`, `email`, `dia_chi`, `ngay_tao`, `trang_thai`) VALUES
(1, 'Trần Văn Hùng', '1998-05-12', 'Nam', '0912345678', 'hung.tv@gmail.com', 'TP. Bắc Ninh', '2026-11-18 03:58:59', 'HOAT_DONG'),
(2, 'Lê Thị Mai', '2001-09-20', 'Nữ', '0923456789', 'mai.le@gmail.com', 'Từ Sơn, Bắc Ninh', '2026-11-18 03:58:59', 'HOAT_DONG'),
(3, 'Phạm Quốc Bảo', '1995-11-03', 'Nam', '0934567890', 'bao.pq@gmail.com', 'Yên Phong, Bắc Ninh', '2026-11-18 03:58:59', 'HOAT_DONG'),
(4, 'Vũ Tiến Lợi', '2005-06-21', 'Nam', '0836411229', 'vutienloi6@gmail.com', 'Hà Nội', '2026-11-18 09:29:28', 'HOAT_DONG');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhan_vien`
--

CREATE TABLE `nhan_vien` (
  `ma_nv` int(11) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `chuc_vu` varchar(50) DEFAULT NULL,
  `trang_thai` enum('HOAT_DONG','TAM_KHOA') DEFAULT 'HOAT_DONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nhan_vien`
--

INSERT INTO `nhan_vien` (`ma_nv`, `ho_ten`, `so_dien_thoai`, `email`, `chuc_vu`, `trang_thai`) VALUES
(1, 'Vũ Tiến Lợi', '0836411229', 'admin@gym.vn', 'Quản trị viên', 'HOAT_DONG'),
(2, 'Nguyễn Minh Thư', '0988000222', 'letan@gym.vn', 'Nhân viên lễ tân', 'HOAT_DONG');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_khoan`
--

CREATE TABLE `tai_khoan` (
  `ma_tk` int(11) NOT NULL,
  `ma_nv` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau_hash` varchar(255) NOT NULL,
  `vai_tro` enum('ADMIN','LE_TAN') NOT NULL,
  `trang_thai` enum('HOAT_DONG','TAM_KHOA') DEFAULT 'HOAT_DONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_khoan`
--

INSERT INTO `tai_khoan` (`ma_tk`, `ma_nv`, `ten_dang_nhap`, `mat_khau_hash`, `vai_tro`, `trang_thai`) VALUES
(1, 1, 'admin', '123456', 'ADMIN', 'HOAT_DONG'),
(2, 2, 'letan01', '123456', 'LE_TAN', 'HOAT_DONG');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanh_toan`
--

CREATE TABLE `thanh_toan` (
  `ma_tt` int(11) NOT NULL,
  `ma_dk` int(11) NOT NULL,
  `ma_nv` int(11) NOT NULL,
  `so_tien` decimal(12,0) NOT NULL,
  `ngay_thanh_toan` timestamp NULL DEFAULT current_timestamp(),
  `phuong_thuc` enum('TIEN_MAT','CHUYEN_KHOAN','THE') NOT NULL,
  `trang_thai` enum('THANH_CONG','HOAN_TIEN') DEFAULT 'THANH_CONG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `dang_ky_goi`
--
ALTER TABLE `dang_ky_goi`
  ADD PRIMARY KEY (`ma_dk`),
  ADD KEY `ma_hv` (`ma_hv`),
  ADD KEY `ma_goi` (`ma_goi`),
  ADD KEY `ma_nv` (`ma_nv`);

--
-- Chỉ mục cho bảng `diem_danh`
--
ALTER TABLE `diem_danh`
  ADD PRIMARY KEY (`ma_dd`),
  ADD KEY `ma_hv` (`ma_hv`),
  ADD KEY `ma_nv` (`ma_nv`);

--
-- Chỉ mục cho bảng `goi_tap`
--
ALTER TABLE `goi_tap`
  ADD PRIMARY KEY (`ma_goi`);

--
-- Chỉ mục cho bảng `hoi_vien`
--
ALTER TABLE `hoi_vien`
  ADD PRIMARY KEY (`ma_hv`),
  ADD UNIQUE KEY `so_dien_thoai` (`so_dien_thoai`);

--
-- Chỉ mục cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`ma_nv`),
  ADD UNIQUE KEY `so_dien_thoai` (`so_dien_thoai`);

--
-- Chỉ mục cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD PRIMARY KEY (`ma_tk`),
  ADD UNIQUE KEY `ma_nv` (`ma_nv`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`);

--
-- Chỉ mục cho bảng `thanh_toan`
--
ALTER TABLE `thanh_toan`
  ADD PRIMARY KEY (`ma_tt`),
  ADD KEY `ma_dk` (`ma_dk`),
  ADD KEY `ma_nv` (`ma_nv`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `dang_ky_goi`
--
ALTER TABLE `dang_ky_goi`
  MODIFY `ma_dk` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `diem_danh`
--
ALTER TABLE `diem_danh`
  MODIFY `ma_dd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `goi_tap`
--
ALTER TABLE `goi_tap`
  MODIFY `ma_goi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `hoi_vien`
--
ALTER TABLE `hoi_vien`
  MODIFY `ma_hv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `ma_nv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `ma_tk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `thanh_toan`
--
ALTER TABLE `thanh_toan`
  MODIFY `ma_tt` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `dang_ky_goi`
--
ALTER TABLE `dang_ky_goi`
  ADD CONSTRAINT `dang_ky_goi_ibfk_1` FOREIGN KEY (`ma_hv`) REFERENCES `hoi_vien` (`ma_hv`),
  ADD CONSTRAINT `dang_ky_goi_ibfk_2` FOREIGN KEY (`ma_goi`) REFERENCES `goi_tap` (`ma_goi`),
  ADD CONSTRAINT `dang_ky_goi_ibfk_3` FOREIGN KEY (`ma_nv`) REFERENCES `nhan_vien` (`ma_nv`);

--
-- Các ràng buộc cho bảng `diem_danh`
--
ALTER TABLE `diem_danh`
  ADD CONSTRAINT `diem_danh_ibfk_1` FOREIGN KEY (`ma_hv`) REFERENCES `hoi_vien` (`ma_hv`),
  ADD CONSTRAINT `diem_danh_ibfk_2` FOREIGN KEY (`ma_nv`) REFERENCES `nhan_vien` (`ma_nv`);

--
-- Các ràng buộc cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD CONSTRAINT `tai_khoan_ibfk_1` FOREIGN KEY (`ma_nv`) REFERENCES `nhan_vien` (`ma_nv`);

--
-- Các ràng buộc cho bảng `thanh_toan`
--
ALTER TABLE `thanh_toan`
  ADD CONSTRAINT `thanh_toan_ibfk_1` FOREIGN KEY (`ma_dk`) REFERENCES `dang_ky_goi` (`ma_dk`),
  ADD CONSTRAINT `thanh_toan_ibfk_2` FOREIGN KEY (`ma_nv`) REFERENCES `nhan_vien` (`ma_nv`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
