const express = require('express');
var ApiError = require('../api-error');
const KiemTra = require('../services/KiemTra.services');
const Customers = require('../controllers/HoaDonMatBao/customers.controller');
const PaymentMethob = require('../controllers/HoaDonMatBao/paymentMethob.controller');
const CurrencyType = require('../controllers/HoaDonMatBao/CurrencyType.controller');
const ProductProperties = require('../controllers/HoaDonMatBao/ProductProperties.controller');
const TaxPercentage = require('../controllers/HoaDonMatBao/TaxPercentage.controller');

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
        .put(KiemTra.CheckLogin, Customers.UpdateCustomerID);

//3. Lấy thất cả thông tin
router.route('/customers').get(KiemTra.CheckLogin, Customers.GetCustomers);

    //>>>>>>>>>>>>>>>>>>>> 
    //>>> Phương thức thanh toán >>>>>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addpaymentmethob').post(KiemTra.CheckLogin, PaymentMethob.createPaymentMethob);

//2. Lấy/Sửa/xóa theo ID
router.route('/paymentmethob')
        .get(KiemTra.CheckLogin, PaymentMethob.getPaymentMethob_ID)
        .put(KiemTra.CheckLogin, PaymentMethob.updatePaymentMethob_ID)
        .delete(KiemTra.CheckLogin, PaymentMethob.deletePaymentMethob_ID);

//3.Lấy All
router.route('/paymentmethobs')
        .get(KiemTra.CheckLogin, PaymentMethob.getAllPaymentMethob);

    //>>>>>>>>>>>>>>>>>>>> 
    //>>> Đơn vị tiền tệ >>>>>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addcurrencytype').post(KiemTra.CheckLogin, CurrencyType.createCurrencyType);

//2. Lấy/Sửa/xóa theo ID
router.route('/currencytype')
        .get(KiemTra.CheckLogin, CurrencyType.getCurrencyType_ID)
        .put(KiemTra.CheckLogin, CurrencyType.updateCurrencyType_ID)
        .delete(KiemTra.CheckLogin, CurrencyType.deleteCurrencyType_ID);

//3.Lấy All
router.route('/currencytypes')
        .get(KiemTra.CheckLogin, CurrencyType.getAllCurrencyType);

    //>>>>>>>>>>>>>>>>>>>> 
    //>>> Tính chất >>>>>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addproductproperties').post(KiemTra.CheckLogin, ProductProperties.createProductProperties);

//2. Lấy/Sửa/xóa theo ID
router.route('/productproperty')
        .get(KiemTra.CheckLogin, ProductProperties.getProductProperties_ID)
        .put(KiemTra.CheckLogin, ProductProperties.updateProductProperties_ID)
        .delete(KiemTra.CheckLogin, ProductProperties.deleteProductProperties_ID);

//3.Lấy All
router.route('/productproperties')
        .get(KiemTra.CheckLogin, ProductProperties.getAllProductProperties);

    //>>>>>>>>>>>>>>>>>>>> 
    //>> Phần trăm thuế >>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addtaxpercentage').post(KiemTra.CheckLogin, TaxPercentage.createTaxPercentage);

//2. Lấy/Sửa/xóa theo ID
router.route('/taxpercentage')
        .get(KiemTra.CheckLogin, TaxPercentage.getTaxPercentage_ID)
        .put(KiemTra.CheckLogin, TaxPercentage.updateTaxPercentage_ID)
        .delete(KiemTra.CheckLogin, TaxPercentage.deleteTaxPercentage_ID);

//3.Lấy All
router.route('/taxpercentages')
        .get(KiemTra.CheckLogin, TaxPercentage.getAllTaxPercentage);



module.exports = router;