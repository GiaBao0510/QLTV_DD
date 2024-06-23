const express = require('express');
var ApiError = require('../api-error');
const KiemTra = require('../services/KiemTra.services');
const Customers = require('../controllers/HoaDonMatBao/customers.controller');
const PaymentMethob = require('../controllers/HoaDonMatBao/paymentMethob.controller');
const CurrencyType = require('../controllers/HoaDonMatBao/CurrencyType.controller');
const ProductProperties = require('../controllers/HoaDonMatBao/ProductProperties.controller');
const TaxPercentage = require('../controllers/HoaDonMatBao/TaxPercentage.controller');
const Products = require('../controllers/HoaDonMatBao/Products.controller');
const Invoice= require('../controllers/HoaDonMatBao/Invoices.controller');
const ChiTietHoaDonBanRa = require('../controllers/HoaDonMatBao/ChiTietHoaDonBanRa.controller');
const HoaDonBanRa = require('../controllers/HoaDonMatBao/HoaDonBanRacontrollter')

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

//3. Kiểm tra xem khách hàng có tồn tại không , từ mã khách hàng
router.route('/cumstomeralready').get(KiemTra.CheckLogin, Customers.CheckCustomerAlreadyExists);

//4. Lấy thất cả thông tin
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
    //>>> Đơn vị tiền tệ >
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
    //>>> Tính chất >>>>>>
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

//4. Kiểm tra tính chất sản phẩm xem có tồn tại không
router.route('/checkproductproperty').get(KiemTra.CheckLogin, ProductProperties.CheckProductPropertiesAlreadyExists);

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

//4. Kiêm tra xem phần trăm thuế có tồn tại hay không dựa trên VATRate
router.route('/checktaxpercentage').get(KiemTra.CheckLogin, TaxPercentage.CheckVATRateAlreadyExists);

    //>>>>>>>>>>>>>>>>>>>> 
    //>>>> Sản phẩm >>>>>>
    //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addproduct').post(KiemTra.CheckLogin, Products.createProducts);

//2. Lấy/Sửa/xóa theo ID
router.route('/product')
        .get(KiemTra.CheckLogin, Products.getProducts_ID)
        .put(KiemTra.CheckLogin, Products.updateProducts_ID)
        .delete(KiemTra.CheckLogin, Products.deleteProducts_ID);

//3.Lấy All
router.route('/products')
        .get(KiemTra.CheckLogin, Products.getAllProducts);

//4. Kiểm tra sản phẩm có tồn tại không
router.route('/checkproductcode').get(KiemTra.CheckLogin, Products.CheckProductAlreadyExists);

        //>>>>>>>>>>>>>>>>>>>> 
        //>>>> hóa đơn >>>>>>
        //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addinvoice').post(KiemTra.CheckLogin, Invoice.createInvoice);

//2. Lấy/Sửa/xóa theo ID
router.route('/invoice')
        .get(KiemTra.CheckLogin, Invoice.GetInvoiceID)
        .put(KiemTra.CheckLogin, Invoice.UpdateInvoiceID)
        .delete(KiemTra.CheckLogin, Invoice.DeleteInvoiceID);

//3.Lấy All
router.route('/invoices')
        .get(KiemTra.CheckLogin, Invoice.GetInvoices);

        //>>>>>>>>>>>>>>>>>>>> 
        //> chi tiết hóa đơn>>
        //>>>>>>>>>>>>>>>>>>>>
//1. Thêm
router.route('/addinvoicedetail').post(KiemTra.CheckLogin, ChiTietHoaDonBanRa.createChiTietHoaDonBanRa);

//2. Lấy/Sửa/xóa theo ID
router.route('/invoicedetail')
        .get(KiemTra.CheckLogin, ChiTietHoaDonBanRa.GetChiTietHoaDonBanRaID)
        .put(KiemTra.CheckLogin, ChiTietHoaDonBanRa.UpdateChiTietHoaDonBanRaID)
        .delete(KiemTra.CheckLogin, ChiTietHoaDonBanRa.DeleteChiTietHoaDonBanRaID);

//3.Lấy All
router.route('/invoicedetails')
        .get(KiemTra.CheckLogin, ChiTietHoaDonBanRa.GetChiTietHoaDonBanRa);

        //>>>>>>>>>>>>>>>>>>>> 
        //1.Them hoa don nhap>
        //>>>>>>>>>>>>>>>>>>>>
router.route('/addHoaDonNhap')
        .post(KiemTra.CheckLogin, async(req, res, next) => {
                try{
                        await HoaDonBanRa.AddHoaDonNhap(req, res, next);
                        await HoaDonBanRa.ImportHoaDonNhap(req, res, next);
                        
                        res.status(200).json({message: "Thêm thông tin hóa đơn bán ra thành công."});
                }catch(err){
                        next(err);
                }
        });
        

module.exports = router;