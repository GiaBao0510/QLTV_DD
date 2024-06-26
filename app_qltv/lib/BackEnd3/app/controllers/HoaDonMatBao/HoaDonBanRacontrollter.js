const ChiTietHoaDonBanRa = require('../../services/HoaDonMatBao/ChiTietHoaDonBanRa.service');
const CurrencyType = require('../../services/HoaDonMatBao/CurrencyType.service');
const Invoice = require('../../services/HoaDonMatBao/Invoices.service');
const PaymentMethob = require('../../services/HoaDonMatBao/PaymentMethob.service');
const ProductProperties = require('../../services/HoaDonMatBao/ProductProperties.service');
const TaxPercentage = require('../../services/HoaDonMatBao/TaxPercentage.service');
const Customers = require('../../services/HoaDonMatBao/customers.service');
const Products = require('../../services/HoaDonMatBao/Products.service');
const HoaDonBanRa =require('../../services/HoaDonMatBao/HoaDonBanRa.service');
const axios = require('axios');


var tempFkey ="";
    // --- Thêm ----
//Này thêm bên dữ liệu bên mình
exports.AddHoaDonNhap = async (req, res, next) =>{
    
    let InputCondition =  1; //Điều kiện đầu vào: (0: không được tạo), (1: được tạo)

    //Thông tin khách hàng
    const customer = {
        MaKH: req.body.MaKH,
        CusName: req.body.CusName,
        CusAddress: req.body.CusAddress,
        CusPhone: req.body.CusPhone,
        Buyer: req.body.Buyer,
        CusTaxCode: req.body.CusTaxCode,
        CusEmail: req.body.CusEmail,
        CusEmailCC: req.body.CusEmailCC,
        CusBankName: req.body.CusBankName,
        CusBankNo: req.body.CusBankNo, 
    };

    //Thông tin hóa đơn
    const bill = {
        Fkey:  req.body.Fkey || "",
        ApiInvPattern: req.body.ApiInvPattern || "",
        ApiInvSerial: req.body.ApiInvSerial || "", 
        Total: req.body.Total || 0, 
        DiscountAmount: req.body.DiscountAmount || 0, 
        Amount: req.body.Amount || 0,  
        VATAmount: req.body.VATAmount || 0, 
        AmountInWords: req.body.AmountInWords || "", 
        SO: req.body.SO || "", 
        NOTE: req.body.NOTE || "", 
        TyGia: req.body.TyGia || 0, 
        MaKH: req.body.MaKH || "", 
        PaymentMethod: req.body.PaymentMethod || "", 
        SoDVTT: String(req.body.DonViTienTe || "704"),
        InvType: req.body.InvType || 1,
    }

    //Thông tin sản phẩm
    const goods = req.body.Products;
    

    try{
        //Kiểm tra thông tin sản phẩm trước rồi mới thêm
        for(let e of goods){
            let Check_VATRate = await TaxPercentage.CheckVATRateAlreadyExists(e.VATRate || 0),
             Check_ProAttr = await ProductProperties.CheckProductPropertiesAlreadyExists(e.ProdAttr || 0);

            //Hủy thao tác nếu đầu vào sai 
            if(Check_VATRate == 0 || Check_ProAttr == 0){
                return res.status(400).json({message: "Thuế xuất GTGT(VATRate) hoặc Tính chất(ProAttr) không tồn tại."});
            }
        }
        
        //Thêm thông tin hóa đơn
        const ThemHoaDon = await Invoice.addInvoice(bill);
        console.log(`Fkey: ${ThemHoaDon.Fkey}`);

        //Nếu Lấy Fkey của biến thêm hóa đơn mà khác null thì thêm thông tin sản phẩm
        if(ThemHoaDon.Fkey != null){
            
            tempFkey = ThemHoaDon.Fkey;

            //Thêm thông tin khách hàng
            await Customers.updateKhachHang(customer.MaKH,customer);
            
            //Lọc thông tin sản phẩm
            for(let e of goods){
                const product = {
                    Code: e.code,
                    ProdName: e.ProdName || '',
                    ProdUnit: e.ProdUnit || '',
                    ProdQuantity: e.ProdQuantity || 0,
                    DiscountAmount: e.DiscountAmount || 0,
                    Discount: e.Discount || 0,
                    ProdPrice: e.ProdPrice || 0,
                    DiscountedTax: e.DiscountedTax || 0,
                    VATAmount: e.VATAmount || 0,
                    Total: e.Total || 0,
                    Amount: e.Amount || 0,
                    Remark: e.Remark || '',
                }

                //Kiểm tra trên mã sản phẩm có tồn tại hay không
                let check_SP = await Products.CheckProductAlreadyExists(e.code);
                    //Nếu có thì cập nhật
                if(check_SP == 1){
                    await Products.updateProducts_ID(e.code, product);
                }else{//Ngược lại thì thêm mới
                    await Products.addProducts(product);
                }

                //Thêm thông tin chi tiết SP
                const ChiTiet = {
                    Fkey: ThemHoaDon.Fkey, 
                    ProdAttr: e.ProdAttr,
                    VATRate: e.VATRate, 
                    Code: e.code
                };
                await ChiTietHoaDonBanRa.addChiTietHoaDonBanRa(ChiTiet);
            }
            next();
        }else{
            return res.status(200).json({message: "Fkey không tồn tại thêm thông tin hóa đơn bán ra thất bại."});
        }
    }catch(err){
        next(err);
    }
}

//Này thêm dữ liệu bên máy khách
exports.ImportHoaDonNhap = async(req, res, next) => {
    const data = req.body;
    data.Fkey = tempFkey;
    let SentFeedback = false;
    try{

        const response = await axios.post('https://api-demo.matbao.in/api/v3/invoice/importInvTemp',data);

        //Trả về trạng thái
        console.log(` Trạng thái bên thứ 3: ${response.status}`);
        console.log(`Thông tin trả về bên thứ 3: ${JSON.stringify(response.data)}`);
        SentFeedback = true;    //Đánh dấu đã gửi
        res.status(200).json(response.data );
    }catch(err){
        console.log(` Lỗi từ API bên thứ 3: ${err.message}`);
        if(!SentFeedback){  //Chỉ gửi phản hồi nếu chưa gửi
            res.status(err.response ? err.response.status:500).json({message: err.message});
        }
    }
}

    // --- Lấy danh sách hóa đơn ---
exports.DanhSachHoaDonNhap = async(req, res, next) => {
    try{
        const data =  {
            ApiUserName: req.body.ApiUserName,
            ApiPassword: req.body.ApiPassword,
            ApiInvPattern: req.body.ApiInvPattern,
            ApiInvSerial: req.body.ApiInvSerial,
            ArisingDateFrom: req.body.ArisingDateFrom,
            ArisingDateTo: req.body.ArisingDateTo,
        };

        const kq = await axios.post('https://api-demo.matbao.in/api/v2/invoice/SearchInvByDate', data);
        res.status(200).json(kq.data);
    }catch(err){
        next(err);
    }
}
 
    // --- Xóa hóa đơn dựa trên Fkey
//Xóa bên local
exports.XoaHoaDonNhap  = async(req, res, next) => {
    try{
        await HoaDonBanRa.XoaHoaDonNhap(req.body.Fkey);
        next();
    }catch(err){
        next(err);
    }
}

//Xóa bên máy khâch
exports.XoaHoaDonChuaPhatHanh = async(req, res, next) =>{
    let SentFeedback = false;
    const data = req.body;

    try{
        const response = await axios.post('https://api-demo.matbao.in/api/v3/invoice/deleteInvTemp', data);
        console.log(` Trạng thái bên thứ 3: ${response.status}`);
        console.log(`Dữ liệu trả về: ${JSON.stringify(response.data)}`);
        SentFeedback = true;
        res.status(200).json(response.data );
    }catch(err){
        console.log(` Lỗi từ API bên thứ 3: ${err.message}`);
        if(!SentFeedback){  //Chỉ gửi phản hồi nếu chưa gửi
            res.status(err.response ? err.response.status:500).json({message: err.message});
        }
        next(err);
    }
}