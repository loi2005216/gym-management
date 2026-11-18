<?php
require_once '../db.php';

$input = json_decode(file_get_contents("php://input"), true);
$action = $input['action'] ?? '';

try {
    if ($action === 'create_register') {
        $ma_hv = (int)$input['ma_hv'];
        $ma_goi = (int)$input['ma_goi'];
        $ma_nv = (int)$input['ma_nv'];
        $ngay_bat_dau = $input['ngay_bat_dau'];

        $goi = $conn->prepare("SELECT * FROM goi_tap WHERE ma_goi = ?");
        $goi->execute([$ma_goi]);
        $pkg = $goi->fetch();

        $ngay_ket_thuc = date('Y-m-d', strtotime($ngay_bat_dau . " +{$pkg['thoi_han_thang']} months"));
        $tong_tien = $pkg['gia'];

        $stmt = $conn->prepare("INSERT INTO dang_ky_goi (ma_hv, ma_goi, ma_nv, ngay_bat_dau, ngay_ket_thuc, tong_tien, trang_thai) VALUES (?, ?, ?, ?, ?, ?, 'CHO_THANH_TOAN')");
        $stmt->execute([$ma_hv, $ma_goi, $ma_nv, $ngay_bat_dau, $ngay_ket_thuc, $tong_tien]);
        $ma_dk = $conn->lastInsertId();

        // Nếu thu tiền ngay lúc đăng ký
        $so_tien_thu = (float)($input['so_tien_thu'] ?? 0);
        if ($so_tien_thu > 0) {
            $phuong_thuc = $input['phuong_thuc'] ?? 'TIEN_MAT';
            $stmtTT = $conn->prepare("INSERT INTO thanh_toan (ma_dk, ma_nv, so_tien, phuong_thuc, trang_thai) VALUES (?, ?, ?, ?, 'THANH_CONG')");
            $stmtTT->execute([$ma_dk, $ma_nv, $so_tien_thu, $phuong_thuc]);

            if ($so_tien_thu >= $tong_tien) {
                $conn->prepare("UPDATE dang_ky_goi SET trang_thai = 'HOAT_DONG' WHERE ma_dk = ?")->execute([$ma_dk]);
            }
        }
        echo json_encode(["success" => true, "message" => "Tạo đăng ký gói tập thành công!"]);
    } elseif ($action === 'add_payment') {
        $ma_dk = (int)$input['ma_dk'];
        $ma_nv = (int)$input['ma_nv'];
        $so_tien = (float)$input['so_tien'];
        $phuong_thuc = $input['phuong_thuc'] ?? 'TIEN_MAT';

        $stmt = $conn->prepare("INSERT INTO thanh_toan (ma_dk, ma_nv, so_tien, phuong_thuc, trang_thai) VALUES (?, ?, ?, ?, 'THANH_CONG')");
        $stmt->execute([$ma_dk, $ma_nv, $so_tien, $phuong_thuc]);

        // Kiểm tra tổng tiền đã thu đủ chưa (Quy tắc 05)
        $dk = $conn->query("SELECT tong_tien FROM dang_ky_goi WHERE ma_dk = $ma_dk")->fetch();
        $paid = $conn->query("SELECT COALESCE(SUM(so_tien), 0) AS total FROM thanh_toan WHERE ma_dk = $ma_dk AND trang_thai = 'THANH_CONG'")->fetch();

        if ($paid['total'] >= $dk['tong_tien']) {
            $conn->prepare("UPDATE dang_ky_goi SET trang_thai = 'HOAT_DONG' WHERE ma_dk = ?")->execute([$ma_dk]);
        }
        echo json_encode(["success" => true, "message" => "Ghi nhận thanh toán thành công!"]);
    }
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => "Lỗi xử lý: " . $e->getMessage()]);
}
?>