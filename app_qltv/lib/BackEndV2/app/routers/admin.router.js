const express = require('express');
const loaihang = require('../controllers/loaiHang.controllers');
const khachhang = require('../controllers/khachHang.controller');

//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

    // >>>>>>>>     Loại hàng
//1. Thêm loại hàng
router.route('/themloaihang').post(loaihang.Add_LoaiHang);

//2. lấy,Xóa và sửa loại hàng
router.route('/loaihang/:LOAIID')
            .get(loaihang.lay_LoaiHang)
            .put(loaihang.update_LoaiHang)
            .delete(loaihang.Delete_LoaiHang);

//3.Lấy danh sách thông tin loại hàng
router.route('/danhsachloaihang').get(loaihang.list_LoaiHang);

    // >>>>>>>>     NGười dùng
router.route('/themkhachhang').post(khachhang.Add_khachHang);

module.exports = router;