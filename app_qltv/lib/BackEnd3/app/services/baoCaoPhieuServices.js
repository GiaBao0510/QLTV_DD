const db = require('../config/index_2');
//  table phx_phieu_xuat
const getPhieuXuat = async (ngayBD, ngayKT) => {
  return new Promise((resolve, reject) => {
    
    //Liệt kê từng phiếu mã trên phiếu xuất
    db.query( `
      SELECT PHIEU_XUAT_MA 
      FROM phx_phieu_xuat
      WHERE NGAY_XUAT BETWEEN "${ngayBD}" AND "${ngayKT}"
    `  
    , async (error, results) => {
      if (error) {
        reject(error);
      } else {

        let output = [];  //Đầu ra

        //Truy xuất thông tin trên từng phiếu mã
        const TimKiemTheoMaPhieuXuat = (query) => {
          return new Promise((resolve, reject) => {
            db.query(query, (err, result) =>{
              if(err){
                reject(err);
              }
              resolve(result);
            });
          });
        }

        for(const item of results){
          let PhieuXuatMa = item.PHIEU_XUAT_MA;
          let KetQuaTungItem = await TimKiemTheoMaPhieuXuat(`
            SELECT px.PHIEU_XUAT_MA, ctpx.HANGHOAMA, dmhh.HANG_HOA_TEN, ctpx.LOAIVANG,
                dmhh.CAN_TONG, dmhh.TL_HOT, (dmhh.CAN_TONG - dmhh.TL_HOT) TL_Vang,
                px.NGAY_XUAT, ctpx.DON_GIA, ctpx.THANH_TIEN, dmhh.CONG_GOC GiaGoc,
                (ctpx.THANH_TIEN - dmhh.CONG_GOC) LaiLo, px.TIEN_BOT, px.TIEN_VANG_THEM,
                kh.KH_TEN, ctpx.SO_LUONG, dmhh.GIA_CONG, px.TONG_TIEN, px.THANH_TOAN, 
                IFNULL(pd.TRI_GIA_MUA,0) as TRI_GIA_MUA 
            FROM phx_phieu_xuat px
              INNER JOIN phx_khach_hang kh ON kh.KH_ID = px.KH_ID
              JOIN phx_chi_tiet_phieu_xuat ctpx ON ctpx.PHIEU_XUAT_ID = px.PHIEU_XUAT_ID
              JOIN danh_muc_hang_hoa dmhh ON dmhh.HANGHOAID = ctpx.HANGHOAID
              left JOIN phd_phieu_doi pd ON px.PHIEU_XUAT_ID = pd.PHIEU_XUAT_ID
            WHERE px.PHIEU_XUAT_MA="${PhieuXuatMa}"
          `);

          //Tinh chỉnh lại kết quả truy xuất của từng phiếu mã
          let customKetQuaTruyVan = KetQuaTungItem.map((e) => ({
            "PHIEU_XUAT_MA": e.PHIEU_XUAT_MA,
          "HANGHOAMA": e.HANGHOAMA,
          "HANG_HOA_TEN": e.HANG_HOA_TEN,
          "LOAIVANG": e.LOAIVANG,
          "CAN_TONG": e.CAN_TONG,
          "TL_HOT": e.TL_HOT,
          "TL_Vang": e.TL_Vang,
          "NGAY_XUAT": new Date(e.NGAY_XUAT).toLocaleDateString('vi-VN'),
          "DON_GIA": e.DON_GIA,
          "THANH_TIEN": e.THANH_TIEN,
          "GiaGoc": e.GiaGoc,
          "LaiLo": e.LaiLo,
          "KH_TEN": e.KH_TEN,
          "TIEN_BOT": Number(e.TIEN_BOT),
          "SO_LUONG": Number(e.SO_LUONG),
          "GIA_CONG": Number(e.GIA_CONG),
          "TONG_TIEN": Number(e.TONG_TIEN),
          "THANH_TOAN": Number(e.THANH_TOAN),
          "TRI_GIA_MUA": Number(e.TRI_GIA_MUA),
          }));

          let KQ = {
            PhieuXuatMa: PhieuXuatMa,
            data: customKetQuaTruyVan
          }

          //Ép vào mảng
          output.push(KQ);
        }

        resolve(output);
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

///////Kho_vang_mua_vao
const getKhoVangMuaVao = async () => {
  return new Promise((resolve, reject) => {
    db.query(`
      SELECT khmv.TEN_HANG_HOA, nh.NHOM_TEN, khmv.CAN_TONG, khmv.TL_LOC, khmv.TL_HOT, khmv.TL_THUC, khmv.SO_LUONG, khmv.DON_GIA 
      FROM phm_kho_vang_mua_vao khmv 
      JOIN nhom_hang nh 
      WHERE khmv.NHOMHANGID = nh.NHOMHANGID`, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

///////phm_chi_tiet_phieu_mua_vao
const getBCPhieuMuaVao = async () => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT pmv.PHIEU_MUA_VAO_ID, pmv.PHIEU_MA, pmv.KHACH_HANG_ID, pmv.USER_ID, pmv.CAN_TONG, pmv.TL_HOT, pmv.THANH_TOAN,
             pmv.NGAY_PHIEU, pmv.NGAY_NHAP, pmv.SU_DUNG, pmv.GHI_CHU, pmv.PHIEU_DOI,
             ctpv.CHI_TIET_ID, ctpv.HANG_HOA_MA, ctpv.HANG_HOA_TEN, ctpv.DVT_ID, ctpv.NHOM_ID,
ctpv.CAN_TONG AS CTPV_CAN_TONG, ctpv.TL_HOT AS CTPV_TL_HOT, ctpv.SO_LUONG, 
             ctpv.DON_GIA, ctpv.THANH_TIEN AS CTPV_THANH_TIEN, ctpv.SU_DUNG AS CTPV_SU_DUNG, 
             ctpv.GHI_CHU AS CTPV_GHI_CHU, ctpv.TL_LOC,
             nh.NHOM_TEN
      FROM phm_phieu_mua_vao pmv
      JOIN phm_chi_tiet_phieu_mua_vao ctpv ON pmv.PHIEU_MUA_VAO_ID = ctpv.PHIEU_MUA_VAO_ID
      LEFT JOIN nhom_hang nh ON ctpv.NHOM_ID = nh.NHOMHANGID
    `;
    db.query(query, (error, results) => {
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
      SELECT pmv.PHIEU_MA, ctpv.HANG_HOA_MA, ctpv.HANG_HOA_TEN, pmv.NGAY_NHAP, pmv.NGAY_PHIEU,
             ctpv.CAN_TONG AS CTPV_CAN_TONG, ctpv.TL_HOT AS CTPV_TL_HOT, 
             (ctpv.CAN_TONG - ctpv.TL_HOT) AS TL_VANG, 
             ctpv.DON_GIA, ctpv.THANH_TIEN AS CTPV_THANH_TIEN,
             nh.NHOM_TEN
      FROM phm_phieu_mua_vao pmv
      JOIN phm_chi_tiet_phieu_mua_vao ctpv ON pmv.PHIEU_MUA_VAO_ID = ctpv.PHIEU_MUA_VAO_ID
      LEFT JOIN nhom_hang nh ON ctpv.NHOM_ID = nh.NHOMHANGID
      WHERE DATE(pmv.NGAY_NHAP) BETWEEN ? AND ?
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
const getBCPhieuMuaVaoById = async (id) => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT pmv.*, ctpv.*, nh.NHOM_TEN
      FROM phm_phieu_mua_vao pmv
      JOIN phm_chi_tiet_phieu_mua_vao ctpv ON pmv.PHIEU_MUA_VAO_ID = ctpv.PHIEU_MUA_VAO_ID
      LEFT JOIN nhom_hang nh ON ctpv.NHOM_ID = nh.NHOMHANGID
      WHERE pmv.PHIEU_MUA_VAO_ID = ?
    `;
    db.query(query, [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getPhieuDoi = async () => {
  return new Promise((resolve, reject) => {
    db.query(`
      SELECT * FROM phd_phieu_doi`, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getTopKhachHang = async () => {
  return new Promise((resolve, reject) => {
    db.query(`
      SELECT kh.KH_TEN, SUM(px.TONG_TIEN) AS KH_TONG_TIEN
      FROM phx_phieu_xuat px
      JOIN phx_khach_hang kh ON px.KH_ID = kh.KH_ID
      GROUP BY kh.KH_TEN
      ORDER BY KH_TONG_TIEN DESC; `, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
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
  getKhoVangMuaVao,
  getBCPhieuMuaVao,
  getBCPhieuMuaVaoByDate,
  getBCPhieuMuaVaoById,
  getPhieuDoi,
  getTopKhachHang
};