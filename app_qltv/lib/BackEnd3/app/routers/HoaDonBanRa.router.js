const express = require('express');
var ApiError = require('../api-error');
const KiemTra = require('../services/KiemTra.services');
const Customers = require('../controllers/HoaDonMatBao/customers.controller');

//0. Tạo 1 router để quản lý tuyến đường
const router = express.Router();

    //>>>>>>>>>>>>>>>>>>>>
    //>>> Khách hàng >>>>>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addcustomer').post(KiemTra.CheckLogin, Customers.createCustomer);

//2. Lấy thông tin/ xóa theo MaKH từ query
router.route('/customer')
        .get(KiemTra.CheckLogin, Customers.GetCustomerID)
        .delete(KiemTra.CheckLogin, Customers.DeleteCustomerID)

//3. Lấy thất cả thông tin
router.route('/customers').get(KiemTra.CheckLogin, Customers.GetCustomers);

module.exports = router;