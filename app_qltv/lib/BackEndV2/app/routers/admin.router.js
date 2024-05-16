const express = require('express');
const loaihang = require('../controllers/loaiHang.controllers');

//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

//1. Thêm loại hàng
router.route('/themloaihang').post(loaihang.Add_LoaiHang);

//2. Xóa và sửa loại hành
router.route('/loaihang/:LOAIID')
            .get(loaihang.lay_LoaiHang)
            .put(loaihang.update_LoaiHang)
            .delete(loaihang.Delete_LoaiHang);

//3.Lấy danh sách thông tin loại hàng
router.route('/danhsachloaihang').get(loaihang.list_LoaiHang);

module.exports = router;