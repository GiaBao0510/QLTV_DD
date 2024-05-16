const express = require('express');
const loaihang = require('../controllers/loaiHang.controllers');
const khachhang = require('../controllers/khachHang.controller');
const nhacungcap = require('../controllers/nhaCungCap.controller');
const kho = require('../controllers/warehouseController');

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

    // >>>>>>>>     Khách hàng
//Thêm
router.route('/themkhachhang').post(khachhang.Add_khachHang);

//Lấy thông tin, xóa sửa
router.route('/khachhang/:KH_MA')
        .get(khachhang.lay_KhachHang)
        .put(khachhang.Update_KhachHang)
        .delete(khachhang.Delete_KhachHang);
    
//Lấy danh sách thông tin khách hàng
router.route('/danhsachkhachhang').get(khachhang.list_KhachHang);

    // >>>>>>>>     Nhà cung cấp
//Lấy thông tin, xóa sửa
router.route('/nhacungcap/:NCCMA')
        .put(nhacungcap.Update_NhaCungCap)
        .delete(nhacungcap.delete_NhaCungCap)
        .get(nhacungcap.lay_NhaCungCap);
   
//Lấy danh sách thông tin Nhà cung cấp
router.route('/danhsachnhacungcap').get(nhacungcap.list_NhaCungCap);

//Thêm nhà cung cấp
router.route('/themnhacungcap').post(nhacungcap.Add_NhaCungCap);

    // >>>>>>>>    Kho
//Liệt kê kho
router.route('/danhsachkho').get(kho.list_wareHouse);

//Thêm 
router.route('/themkho').post(kho.Add_wareHouse);

//Tìm, sửa ,xóa kho
router.route('/kho/:KHOMA')
        .put(kho.Update_wareHouse)
        .delete(kho.delete_wareHouse)
        .get(kho.lay_wareHouse);

module.exports = router;