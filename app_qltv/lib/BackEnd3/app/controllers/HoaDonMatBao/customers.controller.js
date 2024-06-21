const CustomersServices = require('../../services/HoaDonMatBao/customers.service');

exports.createCustomer = async(req, res, next) =>{
    try{
        const newCustomer = await CustomersServices.insertKhachHang(req.body);
        res.status(200).json(newCustomer);
    }catch(err){
        next(err); 
    }
}

exports.GetCustomers = async(req, res, next)=>{
    try{
        const get = await CustomersServices.getKhachHang();
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.GetCustomerID = async(req, res, next)=>{
    try{
        const {MaKH} = req.query;
        console.log("Mã KH: ",MaKH);
        console.log("Lấy truy vấn: ",req.query);
        const get = await CustomersServices.getKhachHang_maKH(MaKH);
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.DeleteCustomerID = async(req, res, next) =>{
    try{
        const {MaKH} = req.query;
        const deleteCus = await CustomersServices.deleteKhachHang(MaKH);
        res.status(200).json(deleteCus);
    }catch(err){
        next(err);
    }
}

exports.UpdateCustomerID = async(req, res, next) => {
    try{
        const {MaKH} = req.query;
        const update = await CustomersServices.updateKhachHang(MaKH, req.body);
        res.status(200).json(update);
    }catch(err){
        next(err);
    }
}