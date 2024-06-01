const express = require('express');
const loaihang = require('../controllers/loaiHang.controllers');
const khachhang = require('../controllers/khachHang.controller');
const nhacungcap = require('../controllers/nhaCungCap.controller');
const kho = require('../controllers/warehouseController');
const ns_don_vi = require('../controllers/ns_donVi.controller');
const danh_muc_hang_hoa = require('../controllers/hangHoa.controller');
const BC_TonKhoTheoNhomVang = require('../controllers/baoCaoTonKhoTheoNhom');
const BC_TonKhoLoaiVang = require('../controllers/baoCaoTonKhoLoaiVang');
const BC_TonKho = require('../controllers/BaoCaoTonKho');
var mysql = require('mysql');
var db = require('../config/index_2');
var ApiError = require('../api-error');
const KiemTra = require('../services/KiemTra.servie');



//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

    // >>>>>>>>     Loại hàng
//1. Thêm loại hàng
router.route('/themloaihang').post( KiemTra.authenticationToken,loaihang.Add_LoaiHang);

//2. lấy,Xóa và sửa loại hàng
router.route('/loaihang/:LOAIID')
            .get(loaihang.lay_LoaiHang)
            .put(loaihang.update_LoaiHang)
            .delete(loaihang.Delete_LoaiHang);

//3.Lấy danh sách thông tin loại hàng
router.route('/danhsachloaihang').get( KiemTra.authenticationToken,loaihang.list_LoaiHang);

    // >>>>>>>>     Khách hàng
//Thêm
router.route('/themkhachhang').post( KiemTra.authenticationToken,khachhang.Add_khachHang);

//Lấy thông tin, xóa sửa
router.route('/khachhang/:KH_MA')
        .get( KiemTra.authenticationToken,khachhang.lay_KhachHang)
        .put( KiemTra.authenticationToken,khachhang.Update_KhachHang)
        .delete( KiemTra.authenticationToken,khachhang.Delete_KhachHang);
    
//Lấy danh sách thông tin khách hàng
router.route('/danhsachkhachhang').get( KiemTra.authenticationToken,khachhang.list_KhachHang);

    // >>>>>>>>     Nhà cung cấp
//Lấy thông tin, xóa sửa
router.route('/nhacungcap/:NCCMA')
        .put( KiemTra.authenticationToken,nhacungcap.Update_NhaCungCap)
        .delete( KiemTra.authenticationToken,nhacungcap.delete_NhaCungCap)
        .get( KiemTra.authenticationToken,nhacungcap.lay_NhaCungCap);
   
//Lấy danh sách thông tin Nhà cung cấp
router.route('/danhsachnhacungcap').get( KiemTra.authenticationToken,nhacungcap.list_NhaCungCap);

//Thêm nhà cung cấp
router.route('/themnhacungcap').post( KiemTra.authenticationToken,nhacungcap.Add_NhaCungCap);

    // >>>>>>>>    Kho
//Liệt kê kho
router.route('/danhsachkho').get( KiemTra.authenticationToken,kho.list_wareHouse);

//Thêm 
// router.route('/themkho').post(kho.Add_wareHouse);

//Tìm, sửa ,xóa kho
router.route('/kho/:KHOMA')
        .put( KiemTra.authenticationToken,kho.Update_wareHouse)
        .delete( KiemTra.authenticationToken,kho.delete_wareHouse)
        .get( KiemTra.authenticationToken,kho.lay_wareHouse);

    // >>>>>>>>    ns_don_vi
//Lấy ds đơn vị
router.route('/danhsachNSdonvi').get( KiemTra.authenticationToken,ns_don_vi.list_nsDonVi);

//Lấy, xóa, sửa
router.route('/nsDonVi/:DON_VI_MA')
            .get( KiemTra.authenticationToken,ns_don_vi.lay_nsDonVi)
            .put( KiemTra.authenticationToken,ns_don_vi.Update_nsDonVi)
            .delete( KiemTra.authenticationToken,ns_don_vi.delete_nsDonVi);

//Thêm
router.route('/themNSdonvi').post( KiemTra.authenticationToken,ns_don_vi.Add_nsDonVi);

    // >>>>>>>>    hàng hóa
//list
router.route('/danhsachhanghoa').get( KiemTra.authenticationToken,danh_muc_hang_hoa.list_hangHoa)
//Thêm
router.route('/themhanghoa').post( KiemTra.authenticationToken,danh_muc_hang_hoa.Add_hangHoa);
//Lấy ,Sửa ,xóa
router.route('/hanghoa/:HANGHOAMA')
        .get( KiemTra.authenticationToken,danh_muc_hang_hoa.lay_hangHoa)
        .put( KiemTra.authenticationToken,danh_muc_hang_hoa.Update_hangHoa)
        .delete( KiemTra.authenticationToken,danh_muc_hang_hoa.delete_hangHoa);


    //  >>>>>> Báo cáo tồn kho theo từng nhóm

//Lấy danh sách báo cáo tồn kho theo nhóm vàng được sắp xếp theo tên loại
router.route('/baocaotonkhotheonhomvang').get( KiemTra.authenticationToken,BC_TonKhoTheoNhomVang.baoCaoTonKhoTheoNhom)

//Lấy danh sách báo cáo tồn kho theo nhóm vàng được lấy theo tên loại cụ thể
router.route('/baocaotonkhotheonhomvang/:LOAI_TEN').get( KiemTra.authenticationToken,BC_TonKhoTheoNhomVang.baoCaoTonKhoTheoNhom_TenNhom);

    //  >>>>>> Báo cáo tồn kho loại vàng
//Lấy danh sách báo cáo tồn kho loại vàng được sắp xếp theo tên nhóm vàng
router.route('/baocaotonkholoaivang').get(KiemTra.authenticationToken,BC_TonKhoLoaiVang.baoCaoTonKhoLoaiVang);

//Lấy danh sách báo cáo tồn kho loại vàng được lấy theo tên nhóm cụ thể
router.route('/baocaotonkholoaivang/:NHOM_TEN').get( KiemTra.authenticationToken,BC_TonKhoLoaiVang.baoCaoTonKhoLoaiVang_TenLoaiVang);

    //  >>>>>> Báo cáo tồn kho
router.route('/baocaotonkho').get( KiemTra.authenticationToken,BC_TonKho.baoCaoTonKho);

module.exports = router;