
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


exports.getPhieuXuatByDate = async (req, res, next) => {
  try {
    const { ngayBD, ngayKT } = req.query;
    if (!ngayBD || !ngayKT) {
      return res.status(400).json({ error: "Ngày bắt đầu và ngày kết thúc là bắt buộc." });
    }

    const phieu = await bao_caoPhieuServices.getPhieuXuatByDate(ngayBD, ngayKT);

    res.status(200).json(phieu);
  } catch(err) {
    next(err);
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

exports.getTonKhoGroupProduct = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getTonKhoGroupProduct();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
exports.getTonKhoGroupProductById = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getTonKhoGPById();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
exports.getBCPhieuMuaVao = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getBCPhieuMuaVao();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};
exports.getBCPhieuMuaVaoById = async (req, res, next) => {
  try {
    const phieu = await bao_caoPhieuServices.getBCPhieuMuaVaoById(req.params.id);
    res.status(200).json(phieu);
  } catch (error) {
    next(error);
  }
};


exports.getBCPhieuMuaVaoByDate = async (req, res, next) => {
  try {
    const { ngayBD, ngayKT } = req.query;
    if (!ngayBD || !ngayKT) {
      return res.status(400).json({ error: "Ngày bắt đầu và ngày kết thúc là bắt buộc." });
    }

    const phieu = await bao_caoPhieuServices.getBCPhieuMuaVaoByDate(ngayBD, ngayKT);

    res.status(200).json(phieu);
  } catch(err) {
    next(err);
  }
};