const express = require('express');
const loaihang = require('../controllers/loaiHang.controllers');

//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

//1. Thêm loại hàng
router.route('/loaihang').post(loaihang.Add_LoaiHang);

//2. Xóa và sửa loại hành
router.route('/loaihang/:LOAIID')
            .delete(loaihang.Delete_LoaiHang);

module.exports = router;