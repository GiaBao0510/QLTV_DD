
// //  table cam_phieu_cam_vang
const camvangServices = require('../services/camvangServices');

exports.getPhieuDangCam = async (req, res, next) => {
  try { 
    const {ngayBD, ngayKT, pages} =  req.query;
    if(!ngayBD || !ngayKT || !pages){
      return res.status(404).json({message: "Vui lòng thêm tham số ngày bắt đầu, ngày kết thúc, pages để lấy thông tin hiển thị."});
    }
    const phieuList = await camvangServices.getPhieuDangCam(ngayBD,ngayKT,pages);
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};

exports.getThongTinTinhTongPhieuDangCam = async (req, res, next) => {
  try {
    const {ngayBD, ngayKT} =  req.query;
    if(!ngayBD || !ngayKT ){
      return res.status(404).json({message: "Vui lòng thêm tham số ngày bắt đầu và ngày kết thúc để lấy thông tin hiển thị."});
    }
    const phieuList = await camvangServices.getThongTinTinhTongPhieuDangCam(ngayBD,ngayKT);
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};

exports.getAllPhieuDangCam_byDate = async(req, res, next) =>{
  const {ngayBD, ngayKT} = req.query;
  try{
    if(!ngayBD || !ngayKT){
      return res.status(400).json({message: 'Vui lòng điền các thông số ngayBD và ngày KT để lấy thông tin'});
    }
    const result = await camvangServices.getAllPhieuDangCam_byDate(ngayBD, ngayKT);
    res.status(200).json(result);
  }catch(err){
    next(err);
  }
}

exports.getPhieuDangCamById = async (req, res, next) => {
  try {
    const phieu = await camvangServices.getPhieuDangCamById(req.params.id);
    res.status(200).json(phieu);
  } catch (error) {
    next(error);
  }
};
// //  table cam_chi_tiet_phieu_cam_vang
exports.getChiTietPhieuCam = async (req, res, next) => {
    try {
      
      const phieuList = await camvangServices.getChiTietPhieuCam();
      res.status(200).json(phieuList);
    } catch (error) {
      next(error);
    }
  };
  exports.getChiTietPhieuCamByLoaiVang = async (req, res, next) => {
    try {
      const loaivang = String( req.query.loaivang || '');
      const page = parseInt(req.query.page) || 1;
      const pageSize = parseInt(req.query.pageSize) || 10;
      const offset = (page - 1) * pageSize;
      const phieuList = await camvangServices.getChiTietPhieuCamByLoaiVang(loaivang,pageSize,offset);
      res.status(200).json(phieuList);
    } catch (error) {
      next(error);
    }
  };
  exports.getChiTietPhieuCamById = async (req, res, next) => {
    try {
      const phieu = await camvangServices.getChiTietPhieuCamById(req.params.id);
      res.status(200).json(phieu);
    } catch (error) {
      next(error);
    } 
  };
