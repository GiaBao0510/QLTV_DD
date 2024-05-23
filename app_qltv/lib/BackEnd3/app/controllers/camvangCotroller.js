
// //  table cam_phieu_cam_vang

const camvangServices = require('../services/camvangServices');

exports.getPhieuDangCam = async (req, res, next) => {
  try {
    const phieuList = await camvangServices.getPhieuDangCam();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
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
  exports.getChiTietPhieuCamById = async (req, res, next) => {
    try {
      const phieu = await camvangServices.getChiTietPhieuCamById(req.params.id);
      res.status(200).json(phieu);
    } catch (error) {
      next(error);
    }
  };
