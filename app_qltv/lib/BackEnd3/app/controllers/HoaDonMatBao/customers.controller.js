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
        const MaKH = String(req.query);
        const get = await CustomersServices.getKhachHang_maKH(MaKH);
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.DeleteCustomerID = async(req, res, next) =>{
    try{
        const MaKH = String(req.query);
        const deleteCus = await CustomersServices.deleteKhachHang(MaKH);
        res.status(200).json(deleteCus);
    }catch(err){
        next(err);
    }
}