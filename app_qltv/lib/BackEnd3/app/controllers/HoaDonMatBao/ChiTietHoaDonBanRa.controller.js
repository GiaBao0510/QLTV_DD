const ChiTietHoaDonBanRaServices = require('../../services/HoaDonMatBao/ChiTietHoaDonBanRa.service');

exports.createChiTietHoaDonBanRa = async(req, res, next) =>{
    try{
        const newChiTietHoaDonBanRa = await ChiTietHoaDonBanRaServices.addChiTietHoaDonBanRa(req.body);
        res.status(200).json(newChiTietHoaDonBanRa);
    }catch(err){
        next(err); 
    }
}

exports.GetChiTietHoaDonBanRa = async(req, res, next)=>{
    try{
        const get = await ChiTietHoaDonBanRaServices.getChiTietHoaDonBanRas();
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.GetChiTietHoaDonBanRaID = async(req, res, next)=>{
    try{
        const {Fkey} = req.query;
        const get = await ChiTietHoaDonBanRaServices.getChiTietHoaDonBanRa_ID(Fkey);
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.DeleteChiTietHoaDonBanRaID = async(req, res, next) =>{
    try{
        const {Fkey} = req.query;
        const deleteCus = await ChiTietHoaDonBanRaServices.deleteChiTietHoaDonBanRa_ID(Fkey);
        res.status(200).json(deleteCus);
    }catch(err){
        next(err);
    }
}

exports.UpdateChiTietHoaDonBanRaID = async(req, res, next) => {
    try{
        const {Fkey} = req.query;
        const update = await ChiTietHoaDonBanRaServices.updateChiTietHoaDonBanRa_ID(Fkey, req.body);
        res.status(200).json(update);
    }catch(err){
        next(err);
    }
}