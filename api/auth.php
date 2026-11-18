<?php
require_once '../db.php';

$input = json_decode(file_get_contents("php://input"), true);
$user = trim($input['username'] ?? '');
$pass = trim($input['password'] ?? '');

if (!$user || !$pass) {
    echo json_encode(["success" => false, "message" => "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!"]);
    exit;
}

$stmt = $conn->prepare("
    SELECT tk.ma_tk, tk.ma_nv, tk.ten_dang_nhap, tk.mat_khau_hash, tk.vai_tro, tk.trang_thai, nv.ho_ten, nv.chuc_vu
    FROM tai_khoan tk
    JOIN nhan_vien nv ON tk.ma_nv = nv.ma_nv
    WHERE tk.ten_dang_nhap = ?
");
$stmt->execute([$user]);
$account = $stmt->fetch();

if (!$account || $account['mat_khau_hash'] !== $pass) {
    echo json_encode(["success" => false, "message" => "Sai tên đăng nhập hoặc mật khẩu!"]);
    exit;
}

if ($account['trang_thai'] !== 'HOAT_DONG') {
    echo json_encode(["success" => false, "message" => "Tài khoản này đang bị tạm khóa!"]);
    exit;
}

unset($account['mat_khau_hash']);
echo json_encode(["success" => true, "user" => $account]);
?>