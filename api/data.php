<?php
require_once '../db.php';

$hoi_vien = $conn->query("SELECT * FROM hoi_vien ORDER BY ma_hv DESC")->fetchAll();
$goi_tap = $conn->query("SELECT * FROM goi_tap ORDER BY ma_goi ASC")->fetchAll();
$nhan_vien = $conn->query("SELECT * FROM nhan_vien ORDER BY ma_nv ASC")->fetchAll();
$tai_khoan = $conn->query("SELECT ma_tk, ma_nv, ten_dang_nhap, vai_tro, trang_thai FROM tai_khoan")->fetchAll();

$dang_ky = $conn->query("
    SELECT dk.*, hv.ho_ten AS ten_hv, hv.so_dien_thoai, gt.ten_goi, gt.thoi_han_thang, nv.ho_ten AS ten_nv,
           COALESCE((SELECT SUM(so_tien) FROM thanh_toan tt WHERE tt.ma_dk = dk.ma_dk AND tt.trang_thai = 'THANH_CONG'), 0) AS da_thanh_toan
    FROM dang_ky_goi dk
    JOIN hoi_vien hv ON dk.ma_hv = hv.ma_hv
    JOIN goi_tap gt ON dk.ma_goi = gt.ma_goi
    JOIN nhan_vien nv ON dk.ma_nv = nv.ma_nv
    ORDER BY dk.ma_dk DESC
")->fetchAll();

$thanh_toan = $conn->query("
    SELECT tt.*, dk.ma_hv, hv.ho_ten AS ten_hv, gt.ten_goi, nv.ho_ten AS ten_nv
    FROM thanh_toan tt
    JOIN dang_ky_goi dk ON tt.ma_dk = dk.ma_dk
    JOIN hoi_vien hv ON dk.ma_hv = hv.ma_hv
    JOIN goi_tap gt ON dk.ma_goi = gt.ma_goi
    JOIN nhan_vien nv ON tt.ma_nv = nv.ma_nv
    ORDER BY tt.ma_tt DESC
")->fetchAll();

$diem_danh = $conn->query("
    SELECT dd.*, hv.ho_ten AS ten_hv, hv.so_dien_thoai, nv.ho_ten AS ten_nv
    FROM diem_danh dd
    JOIN hoi_vien hv ON dd.ma_hv = hv.ma_hv
    JOIN nhan_vien nv ON dd.ma_nv = nv.ma_nv
    ORDER BY dd.ma_dd DESC
")->fetchAll();

echo json_encode([
    "hoi_vien" => $hoi_vien,
    "goi_tap" => $goi_tap,
    "nhan_vien" => $nhan_vien,
    "tai_khoan" => $tai_khoan,
    "dang_ky_goi" => $dang_ky,
    "thanh_toan" => $thanh_toan,
    "diem_danh" => $diem_danh
]);
?>