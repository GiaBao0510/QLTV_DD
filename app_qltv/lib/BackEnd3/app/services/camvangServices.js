const db = require('../config/index_2');

// // table cam_phieu_cam_vang

const getPhieuDangCam = async () => {
  return new Promise((resolve, reject) => {
    db.query(`
    SELECT cv.PHIEU_CAM_VANG_ID, kh.KH_TEN, kh.DIEN_THOAI, kh.DIA_CHI,
        cv.NGAY_LAP, cv.NGAY_CAM, cv.PHIEU_MA, cv.CAN_TONG, cv.TONG_GIA_TRI DINHGIA,
        cv.TU_NGAY ,cv.DEN_NGAY NGAY_QUA_HAN, cv.TIEN_KHACH_NHAN, cnt.TIEN_THEM,
        (cv.CAN_TONG - cv.TL_HOT) TL_THUC, cv.TL_HOT, cv.LY_DO_MAT_PHIEU,
        ( cv.TIEN_KHACH_NHAN +  IFNULL(cnt.TIEN_THEM,0)) TIEN_CAM_MOI, cv.LAI_XUAT,
        DATEDIFF(cv.DEN_NGAY, cv.NGAY_LAP) AS SO_NGAY_HET_HAN, cv.MAT_PHIEU,
        DATEDIFF( CURDATE() ,cv.NGAY_LAP) SO_NGAY_TINH_DUOC ,ctcv.THANH_TIEN,
        cv.GHI_CHU 
    FROM cam_phieu_cam_vang cv 
      INNER JOIN cam_chi_tiet_phieu_cam_vang ctcv ON cv.PHIEU_CAM_VANG_ID = ctcv.PHIEU_CAM_VANG_ID
      JOIN phx_khach_hang kh ON cv.KH_ID = kh.KH_ID
      left JOIN cam_nhan_tien_them cnt ON cnt.PHIEU_CAM_ID = cv.PHIEU_CAM_VANG_ID
    WHERE cv.SU_DUNG=1 AND ctcv.SU_DUNG=1 AND kh.SU_DUNG=1
    `, (error, results) => {
      if (error) {
        reject(error);
      } else {
        let ketqua = results.map(e =>({
            "PHIEU_CAM_VANG_ID": e.PHIEU_CAM_VANG_ID,
            "KH_TEN": e.KH_TEN,
            "DIEN_THOAI": e.DIEN_THOAI,
            "DIA_CHI": e.DIA_CHI,
            "NGAY_LAP": String( new Date(e.NGAY_LAP).toLocaleDateString('vi-VN') ),
            "NGAY_CAM": String( new Date(e.NGAY_CAM).toLocaleDateString('vi-VN') ),
            "PHIEU_MA": e.PHIEU_MA,
            "CAN_TONG": Number(e.CAN_TONG),
            "DINHGIA": Number(e.DINHGIA),
            "TU_NGAY": String( new Date(e.TU_NGAY).toLocaleDateString('vi-VN') ),
            "NGAY_QUA_HAN": String( new Date(e.NGAY_QUA_HAN).toLocaleDateString('vi-VN') ),
            "TIEN_KHACH_NHAN": Number(e.TIEN_KHACH_NHAN),
            "TIEN_THEM": Number(e.TIEN_THEM),
            "TL_THUC": Number(e.TL_THUC),
            "TL_HOT": Number(e.TL_HOT),
            "TIEN_CAM_MOI": Number(e.TIEN_CAM_MOI),
            "LAI_XUAT": Number(e.LAI_XUAT),
            "SO_NGAY_TINH_DUOC": e.SO_NGAY_TINH_DUOC,
            "SO_NGAY_HET_HAN": e.SO_NGAY_HET_HAN,
            "THANH_TIEN": Number(e.THANH_TIEN),
            "MAT_PHIEU": e.MAT_PHIEU,
            "LY_DO_MAT_PHIEU": e.LY_DO_MAT_PHIEU,
            "GHI_CHU": e.GHI_CHU

          })
        );
        resolve(ketqua);
      }
    });
  });
};

const getPhieuDangCamById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM cam_phieu_cam_vang WHERE PHIEU_CAM_VANG_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};
// //  table cam_chi_tiet_phieu_cam_vang

const getChiTietPhieuCam = async () => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM cam_chi_tiet_phieu_cam_vang', (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  };
  
const getChiTietPhieuCamById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM cam_chi_tiet_phieu_cam_vang WHERE PHIEU_CAM_VANG_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};
// create table phx_phieu_xuat

const getPhieuXuat = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM phx_phieu_xuat', (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getPhieuXuatById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM phx_phieu_xuat WHERE PHIEU_XUAT_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};
module.exports = {

  getPhieuDangCam,
  getPhieuDangCamById,
  getChiTietPhieuCam,
  getChiTietPhieuCamById,
  getPhieuXuat,
  getPhieuXuatById
};
