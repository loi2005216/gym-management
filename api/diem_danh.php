<?php
require_once '../db.php';

$input = json_decode(file_get_contents("php://input"), true);
$action = $input['action'] ?? '';

if ($action === 'checkin') {
    $keyword = trim($input['keyword'] ?? '');
    $ma_nv = (int)$input['ma_nv'];

    $stmt = $conn->prepare("SELECT * FROM hoi_vien WHERE ma_hv = ? OR so_dien_thoai = ? LIMIT 1");
    $stmt->execute([$keyword, $keyword]);
    $hv = $stmt->fetch();

    if (!$hv) {
        echo json_encode(["success" => false, "message" => "Không tìm thấy hội viên với mã/SĐT này!"]);
        exit;
    }
    if ($hv['trang_thai'] !== 'HOAT_DONG') {
        echo json_encode(["success" => false, "message" => "Tài khoản hội viên đang bị tạm khóa!"]);
        exit;
    }

    // Kiểm tra gói tập còn hạn & đang hoạt động (Quy tắc 04)
    $today = date('Y-m-d');
    $stmtGoi = $conn->prepare("SELECT * FROM dang_ky_goi WHERE ma_hv = ? AND trang_thai = 'HOAT_DONG' AND ngay_ket_thuc >= ? LIMIT 1");
    $stmtGoi->execute([$hv['ma_hv'], $today]);
    if (!$stmtGoi->fetch()) {
        echo json_encode(["success" => false, "message" => "Hội viên chưa có gói tập HOẠT ĐỘNG hoặc gói đã hết hạn!"]);
        exit;
    }

    // Kiểm tra chưa check-out lượt trước
    $stmtOpen = $conn->prepare("SELECT * FROM diem_danh WHERE ma_hv = ? AND thoi_gian_ra IS NULL");
    $stmtOpen->execute([$hv['ma_hv']]);
    if ($stmtOpen->fetch()) {
        echo json_encode(["success" => false, "message" => "Hội viên đang ở trong phòng tập (chưa check-out lượt trước)!"]);
        exit;
    }

    $ins = $conn->prepare("INSERT INTO diem_danh (ma_hv, ma_nv, thoi_gian_vao, ghi_chu) VALUES (?, ?, NOW(), 'Check-in hợp lệ')");
    $ins->execute([$hv['ma_hv'], $ma_nv]);
    echo json_encode(["success" => true, "message" => "Check-in thành công cho hội viên: " . $hv['ho_ten']]);

} elseif ($action === 'checkout') {
    $ma_dd = (int)$input['ma_dd'];
    $conn->prepare("UPDATE diem_danh SET thoi_gian_ra = NOW() WHERE ma_dd = ?")->execute([$ma_dd]);
    echo json_encode(["success" => true, "message" => "Đã ghi nhận Check-out!"]);
}
?>