const express = require('express');
const pt_user = require('../controllers/pt_user_controller');

//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

//1. Lấy danh sách phân quyền user
router.route('/DanhSachPhanQuyenNguoiDung').get(pt_user.DSphanQuyen_user);


// ------------------------------
module.exports = router;