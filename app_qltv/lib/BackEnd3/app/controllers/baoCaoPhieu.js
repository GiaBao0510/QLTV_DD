
// //  table cam_phieu_cam_vang

const bao_caoPhieuServices = require('../services/baoCaoPhieuServices');
// create table phx_phieu_xuat

exports.getPhieuXuat = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getPhieuXuat();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
exports.getPhieuXuatById = async (req, res, next) => {
  try {
    const phieu = await bao_caoPhieuServices.getPhieuXuatById(req.params.id);
    res.status(200).json(phieu);
  } catch (error) {
    next(error);
  }
};

// Table: ton_kho

exports.getTonKho = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getTonKho();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
exports.getTonKhoById = async (req, res, next) => {
  try {
    const phieu = await bao_caoPhieuServices.getTonKhoById(req.params.id);
    res.status(200).json(phieu);
  } catch (error) {
    next(error);
  }
};
