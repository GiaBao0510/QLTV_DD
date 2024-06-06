const db = require('../config/index_2');
//  table phx_phieu_xuat
const getPhieuXuat = async () => {
  return new Promise((resolve, reject) => {
    db.query(
    `
    SELECT px.PHIEU_XUAT_MA, ctpx.HANGHOAMA, dmhh.HANG_HOA_TEN, ctpx.LOAIVANG,
        ctpx.CAN_TONG, ctpx.TL_HOT, (ctpx.CAN_TONG - ctpx.TL_HOT) TL_Vang,
        px.NGAY_XUAT, ctpx.DON_GIA, ctpx.THANH_TIEN, ctpx.GIA_GOC,
        (ctpx.THANH_TIEN -  ctpx.GIA_GOC) LaiLo
    FROM phx_phieu_xuat px
      INNER JOIN phx_khach_hang kh ON kh.KH_ID = px.KH_ID
      JOIN phx_chi_tiet_phieu_xuat ctpx ON ctpx.PHIEU_XUAT_ID = px.PHIEU_XUAT_ID
      JOIN danh_muc_hang_hoa dmhh ON dmhh.HANGHOAID = ctpx.HANGHOAID
    `  
    , (error, results) => {
      if (error) {
        reject(error);
      } else {

        let ketQua = results.map(e => ({
          "PHIEU_XUAT_MA": (e.PHIEU_XUAT_MA !=null ? e.PHIEU_XUAT_MA :"null" ),
          "HANGHOAMA": e.HANGHOAMA,
          "HANG_HOA_TEN": e.HANG_HOA_TEN,
          "LOAIVANG": e.LOAIVANG,
          "CAN_TONG": Number(e.CAN_TONG),
          "TL_HOT": Number(e.TL_HOT),
          "TL_Vang": Number(e.TL_Vang),
          "NGAY_XUAT": new Date(e.NGAY_XUAT).toLocaleDateString('vi-VN'),
          "DON_GIA": Number(e.DON_GIA),
          "THANH_TIEN": Number(e.THANH_TIEN),
          "GiaGoc": Number(e.GiaGoc),
          "LaiLo": Number(e.LaiLo),
          "KH_TEN": e.KH_TEN,
          "TIEN_BOT": Number(e.TIEN_BOT),
          "SO_LUONG": Number(e.SO_LUONG),
          "GIA_CONG": Number(e.GIA_CONG),
          "TONG_TIEN": Number(e.TONG_TIEN),
          "THANH_TOAN": Number(e.THANH_TOAN),
        }));
        resolve(ketQua);
      }
    });
  });
};
const getPhieuXuatByDate = async (ngayBD, ngayKT) => {
  return new Promise((resolve, reject) => {
    const query = `
    SELECT px.PHIEU_XUAT_ID, px.PHIEU_XUAT_MA, px.NGAY_XUAT,
      ctpx.HANGHOAMA, ctpx.HANG_HOA_TEN, ctpx.LOAIVANG, 
      ctpx.CAN_TONG, ctpx.TL_HOT, (ctpx.CAN_TONG - ctpx.TL_HOT) AS TL_VANG, 
      ctpx.DON_GIA, ctpx.THANH_TIEN, ctpx.GIA_GOC,
      (ctpx.THANH_TIEN - ctpx.GIA_GOC) AS LAI_LO
    FROM phx_phieu_xuat px
    JOIN phx_chi_tiet_phieu_xuat ctpx ON px.PHIEU_XUAT_ID = ctpx.PHIEU_XUAT_ID
    WHERE px.NGAY_XUAT BETWEEN ? AND ?

    `;
    db.query(query, [ngayBD, ngayKT], (error, results) => {
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
// Table: ton_kho
const getTonKho = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM ton_kho', (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getTonKhoById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM ton_kho WHERE HANGHOAID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};
// // Table nhom_hang

const getTonKhoGroupProduct = async () => {
  return new Promise((resolve, reject) => {
    db.query(`
      SELECT hanghoa.HANGHOAID, hanghoa.LOAIID, hanghoa.SO_LUONG, loai.LOAI_TEN
      FROM danh_muc_hang_hoa AS hanghoa
      INNER JOIN loai_hang AS loai ON hanghoa.LOAIID = loai.LOAIID
      WHERE hanghoa.SU_DUNG = 1`, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};
// const getTonKhoGPById = async (id) => {
//   return new Promise((resolve, reject) => {
//     db.query(`
//       SELECT hanghoa.HANGHOAID, hanghoa.LOAIID, hanghoa.SO_LUONG, loai.LOAI_TEN
//       FROM danh_muc_hang_hoa AS hanghoa
//       INNER JOIN loai_hang AS loai ON hanghoa.LOAIID = loai.LOAIID
//       WHERE hanghoa.HANGHOAID = ? AND hanghoa.SU_DUNG = 1`, [id], (error, results) => {
//       if (error) {
//         reject(error);
//       } else {
//         resolve(results[0]);
//       }
//     });
//   });
// };
///////phm_kho_vang_mua_vao

const getBCPhieuMuaVao = async () => {
  return new Promise((resolve, reject) => {
    db.query(
    `
    SELECT *
    FROM phm_kho_vang_mua_vao`
    , (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};
const getBCPhieuMuaVaoByDate = async (ngayBD, ngayKT) => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT km.PHIEU_MA, km.MA_HANG_HOA, km.TEN_HANG_HOA, km.NGAY_NHAP, km.NGAY_PHIEU,
             km.CAN_TONG, km.TL_HOT, (km.CAN_TONG - km.TL_HOT) AS TL_VANG, 
             km.DON_GIA, km.THANH_TIEN
      FROM phm_kho_vang_mua_vao km
      WHERE DATE(km.NGAY_NHAP) BETWEEN ? AND ?
    `;
    // console.log('Query:', query); // In ra query
    // console.log('Parameters:', [ngayBD, ngayKT]); // In ra tham số

    db.query(query, [ngayBD, ngayKT], (error, results) => {
      if (error) {
        reject(error);
      } else {
        console.log('Results:', results); // In ra kết quả
        resolve(results);
      }
    });
  });
};

const getBCPhieuMuaVaoById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM phm_kho_vang_mua_vao WHERE KHO_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};
module.exports = {
  getPhieuXuat,
  getPhieuXuatById,
  getTonKho,
  getTonKhoById,
  getTonKhoGroupProduct,
  getPhieuXuatByDate,
  // getTonKhoGPById
  getBCPhieuMuaVao,
  getBCPhieuMuaVaoByDate,
  getBCPhieuMuaVaoById
};
