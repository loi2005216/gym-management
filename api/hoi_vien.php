<?php
require_once '../db.php';

$input = json_decode(file_get_contents("php://input"), true);
$action = $input['action'] ?? '';

try {
    if ($action === 'save_member') {
        $ma_hv = $input['ma_hv'] ?? null;
        $ho_ten = trim($input['ho_ten']);
        $ngay_sinh = $input['ngay_sinh'] ?: null;
        $gioi_tinh = $input['gioi_tinh'] ?? 'Nam';
        $sdt = trim($input['so_dien_thoai']);
        $email = trim($input['email'] ?? '');
        $dia_chi = trim($input['dia_chi'] ?? '');
        $trang_thai = $input['trang_thai'] ?? 'HOAT_DONG';

        if ($ma_hv) {
            $stmt = $conn->prepare("UPDATE hoi_vien SET ho_ten=?, ngay_sinh=?, gioi_tinh=?, so_dien_thoai=?, email=?, dia_chi=?, trang_thai=? WHERE ma_hv=?");
            $stmt->execute([$ho_ten, $ngay_sinh, $gioi_tinh, $sdt, $email, $dia_chi, $trang_thai, $ma_hv]);
        } else {
            $stmt = $conn->prepare("INSERT INTO hoi_vien (ho_ten, ngay_sinh, gioi_tinh, so_dien_thoai, email, dia_chi, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$ho_ten, $ngay_sinh, $gioi_tinh, $sdt, $email, $dia_chi, $trang_thai]);
        }
        echo json_encode(["success" => true, "message" => "Lưu hồ sơ hội viên thành công!"]);
    } elseif ($action === 'save_package') {
        $ma_goi = $input['ma_goi'] ?? null;
        $ten_goi = trim($input['ten_goi']);
        $thoi_han = (int)$input['thoi_han_thang'];
        $gia = (float)$input['gia'];
        $mo_ta = trim($input['mo_ta'] ?? '');
        $trang_thai = $input['trang_thai'] ?? 'HOAT_DONG';

        if ($ma_goi) {
            $stmt = $conn->prepare("UPDATE goi_tap SET ten_goi=?, thoi_han_thang=?, gia=?, mo_ta=?, trang_thai=? WHERE ma_goi=?");
            $stmt->execute([$ten_goi, $thoi_han, $gia, $mo_ta, $trang_thai, $ma_goi]);
        } else {
            $stmt = $conn->prepare("INSERT INTO goi_tap (ten_goi, thoi_han_thang, gia, mo_ta, trang_thai) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$ten_goi, $thoi_han, $gia, $mo_ta, $trang_thai]);
        }
        echo json_encode(["success" => true, "message" => "Lưu thông tin gói tập thành công!"]);
    }
} catch (PDOException $e) {
    if ($e->getCode() == 23000) {
        echo json_encode(["success" => false, "message" => "Số điện thoại đã tồn tại trong hệ thống!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi CSDL: " . $e->getMessage()]);
    }
}
?>