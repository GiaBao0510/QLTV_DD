const GiaoDichServices = require('../../services/GiaoDich/BanVang.service');

exports.KiemTraMaHangHoa = async(req, res, next) =>{
    try{
        const {HANGHOAMA} = req.query;
        const kq = await GiaoDichServices.KiemTraMaHangHoa(HANGHOAMA);
        res.status(kq[0]).json(kq[1]);
    }catch(err){
        next(err);
    }
}

exports.ThucHienGiaoDich = async(req, res, next) =>{
    try{
        const kq = await GiaoDichServices.ThucHienGiaoDich(req.body);
        res.status(kq[0]).json(kq[1]);
    }catch(err){
        next(err);
    }
}