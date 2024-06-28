const express = require('express');
var ApiError = require('../api-error');
const KiemTra = require('../services/KiemTra.services');
const GiaoDich = require('../controllers/GiaoDich/GiaoDich.controller');

//0. Tạo 1 router để quản lý các tuyến
const router = express.Router();

//1. Kiểm tra sự tồn tại của mã hàng hóa
router.route('/kiemtramahanghoa').get(KiemTra.CheckLogin, GiaoDich.KiemTraMaHangHoa);

//2. Thực hiện giao dịch bán vàng
router.route('/giaodichbanvang').post(KiemTra.CheckLogin, GiaoDich.ThucHienGiaoDich);

module.exports = router;