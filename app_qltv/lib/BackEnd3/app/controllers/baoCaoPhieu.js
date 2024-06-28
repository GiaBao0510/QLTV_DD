
// //  table cam_phieu_cam_vang

const bao_caoPhieuServices = require('../services/baoCaoPhieuServices');
// create table phx_phieu_xuat

exports.getPhieuXuat = async (req, res, next) => {
  try {
    const {ngayBD, ngayKT, pages} = req.query;
    if(!ngayBD || !ngayKT || !pages){
      return res.status(404).json({message: "Vui lòng nhập ngày bắt đầu, ngày kết thúc và số trang hiển thị"});
    }

    const phieuList = await bao_caoPhieuServices.getPhieuXuat(ngayBD, ngayKT, pages);
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

exports.laySoLuongPhieuXuatTheoThoiDiem = async (req, res, next) =>{
  try{
    const {ngayBD, ngayKT} = req.query;
    if(!ngayBD || !ngayKT){
      return res.status(404).json({message: "Vui lòng nhập ngày bắt đầu và ngày kết thúc"});
    }
    const soluong = await bao_caoPhieuServices.laySoLuongPhieuXuatTheoThoiDiem(ngayBD, ngayKT);
    res.status(200).json(soluong);

  }catch(err){
    next(err);
  }
}

exports.TinhTongPhieuXuatTheoThoiDiem = async (req, res, next) =>{
  try{
    const {ngayBD, ngayKT} = req.query;
    if(!ngayBD || !ngayKT){
      return res.status(404).json({message: "Vui lòng nhập ngày bắt đầu và ngày kết thúc"});
    }
    const soluong = await bao_caoPhieuServices.TinhTongPhieuXuatTheoThoiDiem(ngayBD, ngayKT);
    res.status(200).json(soluong);

  }catch(err){
    next(err);
  }
}

exports.getPhieuXuatByDate = async (req, res, next) => {
  try {
    const { ngayBD, ngayKT  } = req.query;
    if (!ngayBD || !ngayKT) {
      return res.status(400).json({ error: "Ngày bắt đầu và ngày kết thúc là bắt buộc." });
    }

    const phieu = await bao_caoPhieuServices.getPhieuXuatByDate(ngayBD, ngayKT, pages);

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

exports.getKhoVangMuaVaoController = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getKhoVangMuaVao();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};

exports.getBCPhieuMuaVao = async (req, res, next) => {
  try {
   // const phieuList = await bao_caoPhieuServices.getBCPhieuMuaVao();
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    const offset = (page -1 ) *pageSize;
    const usersdata = await bao_caoPhieuServices.getBCPhieuMuaVaoWithPagination(pageSize, offset);
    const total = await bao_caoPhieuServices.getBCPhieuMuaVao();
    const totalPages = Math.ceil(total/pageSize);
    res.status(200).json({
      page,
      pageSize,
      totalPages,
      totalRows:total,
      data: usersdata
    });
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
exports.getBCPhieuMuaVaoById = async (req, res, next) => {
  try {
    const phieu = await bao_caoPhieuServices.getBCPhieuMuaVaoById(req.params.id);
    res.status(200).json(phieu);
  } catch (error) {
    next(error);
  }
};




exports.getPhieuDoiController = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getPhieuDoi();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};

exports.getTopKhachHangController = async (req, res, next) => {
  try {
    const phieuList = await bao_caoPhieuServices.getTopKhachHang();
    res.status(200).json(phieuList);
  } catch (error) {
    next(error);
  }
};