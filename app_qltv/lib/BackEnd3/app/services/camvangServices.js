const { json } = require('body-parser');
const db= require('../config/index_2');

// // table cam_phieu_cam_vang

const getPhieuDangCam = async (ngayBD, ngayKT, limit, offset) => {
  console.log('Ngày bắt đầu: ',ngayBD);
  console.log('Ngày ket thúc: ',ngayKT);
  console.log('limit: ',limit);
  console.log('Offset: ',offset);

  return new Promise((resolve, reject) => {
    db.query(`
     SELECT cam_phieu_cam_vang.PHIEU_CAM_VANG_ID,cam_phieu_cam_vang.PHIEU_MA, 
      phx_khach_hang.KH_TEN,DATE_FORMAT(cam_phieu_cam_vang.TU_NGAY, '%d/%m/%Y') AS 
      TU_NGAY,DATE_FORMAT(cam_phieu_cam_vang.DEN_NGAY, '%d/%m/%Y') as DEN_NGAY,
      cam_phieu_cam_vang.CAN_TONG,cam_phieu_cam_vang.TL_HOT,
      cam_phieu_cam_vang.CAN_TONG - cam_phieu_cam_vang.TL_HOT as TL_THUC ,
      cam_phieu_cam_vang.TONG_GIA_TRI DINH_GIA,cam_phieu_cam_vang.TIEN_KHACH_NHAN,cam_phieu_cam_vang.LAI_XUAT ,
      IF(cam_nhan_tien_them.TIEN_THEM is null, 0, cam_nhan_tien_them.TIEN_THEM) as 'TIEN_THEM'
      , cam_phieu_cam_vang.TIEN_KHACH_NHAN + IF(cam_nhan_tien_them.TIEN_THEM is null, 0, 
      cam_nhan_tien_them.TIEN_THEM) as'TIEN_MOI',
      phx_khach_hang.DIEN_THOAI, phx_khach_hang.DIA_CHI, cam_phieu_cam_vang.NGAY_LAP,
      cam_phieu_cam_vang.NGAY_CAM, cam_phieu_cam_vang.LY_DO_MAT_PHIEU, cam_phieu_cam_vang.MAT_PHIEU,
      DATEDIFF(cam_phieu_cam_vang.DEN_NGAY ,cam_phieu_cam_vang.NGAY_LAP) AS SO_NGAY_HET_HAN,
      DATEDIFF( CURDATE() ,cam_phieu_cam_vang.NGAY_LAP) AS SO_NGAY_TINH_DUOC,
      cam_chi_tiet_phieu_cam_vang.THANH_TIEN, cam_phieu_cam_vang.GHI_CHU, 
      cam_chi_tiet_phieu_cam_vang.LOAI_VANG, cam_chi_tiet_phieu_cam_vang.TEN_HANG_HOA, 
      cam_chi_tiet_phieu_cam_vang.DON_GIA
    FROM cam_phieu_cam_vang
        left join cam_chi_tiet_phieu_cam_vang on cam_phieu_cam_vang.PHIEU_CAM_VANG_ID = cam_chi_tiet_phieu_cam_vang.PHIEU_CAM_VANG_ID
        left join phx_khach_hang on cam_phieu_cam_vang.KH_ID = phx_khach_hang.KH_ID
        LEFT join cam_nhan_tien_them on cam_phieu_cam_vang.PHIEU_CAM_VANG_ID = cam_nhan_tien_them.PHIEU_CAM_ID
    WHERE cam_phieu_cam_vang.DA_THANH_TOAN is null 
        and cam_phieu_cam_vang.THANH_LY is null
        AND cam_chi_tiet_phieu_cam_vang.SU_DUNG = 1
        AND DATE(cam_phieu_cam_vang.TU_NGAY) BETWEEN  '${ngayBD}' AND '${ngayKT}'
    GROUP BY cam_phieu_cam_vang.PHIEU_CAM_VANG_ID order by cam_phieu_cam_vang.PHIEU_CAM_VANG_ID DESC
    LIMIT ${limit} OFFSET ${offset}
    `, (error, results) => {
      if (error) {
        reject(error);
      } else {
        let ketqua = results.map(e =>({
            "PHIEU_CAM_VANG_ID": String(e.PHIEU_CAM_VANG_ID),
            "PHIEU_MA": e.PHIEU_MA,
            "KH_TEN": e.KH_TEN,
            "TU_NGAY": e.TU_NGAY,
            "DEN_NGAY": e.DEN_NGAY,
            "CAN_TONG": parseFloat(e.CAN_TONG),
            "TL_HOT": parseFloat(e.TL_HOT),
            "TL_THUC": parseFloat(e.TL_THUC),
            "DINH_GIA": parseFloat(e.DINH_GIA),
            "TIEN_KHACH_NHAN": parseFloat(e.TIEN_KHACH_NHAN),
            "LAI_XUAT": parseFloat(e.LAI_XUAT),
            "TIEN_THEM": parseFloat(e.TIEN_THEM),
            "TIEN_MOI": parseFloat(e.TIEN_MOI),
            "DIEN_THOAI": e.DIEN_THOAI,
            "DIA_CHI":e.DIA_CHI,
            "NGAY_LAP": new Date(e.NGAY_LAP).toLocaleDateString('vi-VN'),
            "NGAY_CAM": new Date(e.NGAY_CAM).toLocaleDateString('vi-VN'),
            "LY_DO_MAT_PHIEU": e.LY_DO_MAT_PHIEU,
            "MAT_PHIEU": e.MAT_PHIEU,
            "SO_NGAY_HET_HAN": parseInt(e.SO_NGAY_HET_HAN),
            "SO_NGAY_TINH_DUOC": parseInt(e.SO_NGAY_TINH_DUOC),
            "THANH_TIEN": parseFloat(e.THANH_TIEN),
            "GHI_CHU": e.GHI_CHU,
            "LOAI_VANG": e.LOAI_VANG,
            "TEN_HANG_HOA": e.TEN_HANG_HOA,
            "DON_GIA": e.DON_GIA
          })
        );
        resolve(ketqua);
      }
    });
  });
};

//Tính tổng phiếu đang cầm
const getThongTinTinhTongPhieuDangCam = async(ngayBD, ngayKT)=>{
  return new Promise((resolve, reject) => {
    db.query(
      `
        SELECT COUNT(dem) SoLuong, SUM(CanTong) TongCanTong, SUM(TLthuc) Tong_TLthuc, SUM(TL_HOT) Tong_TL_HOT,SUM(DinhGia) TongDinhGia,
	        SUM(TienKhachNhan) TongTienKhachNhan, SUM(TIEN_THEM) TongTienThem, SUM(TIEN_MOI) TongTienMoi
        FROM (
          	SELECT COUNT(*) dem, cam_phieu_cam_vang.CAN_TONG CanTong, cam_phieu_cam_vang.TL_HOT,
              cam_phieu_cam_vang.TL_HOT Tong_TLhot, (cam_phieu_cam_vang.CAN_TONG - cam_phieu_cam_vang.TL_HOT) TLthuc,
              cam_phieu_cam_vang.TONG_GIA_TRI DinhGia, cam_phieu_cam_vang.TIEN_KHACH_NHAN TienKhachNhan,
              IF(cam_nhan_tien_them.TIEN_THEM is null, 0, cam_nhan_tien_them.TIEN_THEM) as 'TIEN_THEM'
            , cam_phieu_cam_vang.TIEN_KHACH_NHAN + IF(cam_nhan_tien_them.TIEN_THEM is null, 0, 
            cam_nhan_tien_them.TIEN_THEM) as'TIEN_MOI'
          FROM cam_phieu_cam_vang
            left join cam_chi_tiet_phieu_cam_vang on cam_phieu_cam_vang.PHIEU_CAM_VANG_ID = cam_chi_tiet_phieu_cam_vang.PHIEU_CAM_VANG_ID
            left join phx_khach_hang on cam_phieu_cam_vang.KH_ID = phx_khach_hang.KH_ID
            LEFT join cam_nhan_tien_them on cam_phieu_cam_vang.PHIEU_CAM_VANG_ID = cam_nhan_tien_them.PHIEU_CAM_ID
          WHERE cam_phieu_cam_vang.DA_THANH_TOAN is null 
            and cam_phieu_cam_vang.THANH_LY is null
            AND cam_chi_tiet_phieu_cam_vang.SU_DUNG = 1
            AND DATE(cam_phieu_cam_vang.TU_NGAY) BETWEEN  '${ngayBD}' AND '${ngayKT}'
          GROUP BY cam_phieu_cam_vang.PHIEU_CAM_VANG_ID order by cam_phieu_cam_vang.PHIEU_CAM_VANG_ID DESC
        ) AS bang1
      `,(error ,results) => {
        if(error){
          reject(error);
        }else{
          let ketQua = results.map(e => ({
            "SoLuong": parseInt(e.SoLuong),
            "TongCanTong": Number(e.TongCanTong),
            "Tong_TLthuc": Number(e.Tong_TLthuc),
            "Tong_TL_HOT": Number(e.Tong_TL_HOT),
            "TongDinhGia": Number(e.TongDinhGia),
            "TongTienKhachNhan": Number(e.TongTienKhachNhan),
            "TongTienThem": Number(e.TongTienThem),
            "TongTienMoi": Number(e.TongTienMoi),
          }));
          resolve(ketQua);
        }
      }
    );
  });
}
 
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
      //Lấy tên từng thể loại vàng trước
      db.query(
      `
        SELECT DISTINCT ctcv.LOAI_VANG 
        FROM cam_phieu_cam_vang cv
          INNER JOIN cam_chi_tiet_phieu_cam_vang ctcv ON cv.PHIEU_CAM_VANG_ID = ctcv.PHIEU_CAM_VANG_ID
      `, async (error, results) => {
        if (error) {
          reject(error);
        } else {
          
          let output = [];

          //Tìm kiếm thông tin chi tiết phiếu cầm vàng liên qua đến từng loại vàng
          try{
            const promise = results.map(i =>{
              return new Promise((resolve, reject) =>{
                //Thực hiện truy vấn từng thông tin phiếu đang cầm có liên quan đến loại vàng
                db.query(
                `
                  SELECT cv.PHIEU_CAM_VANG_ID, kh.KH_TEN, kh.DIEN_THOAI, kh.DIA_CHI,
                      cv.NGAY_LAP, cv.NGAY_CAM, cv.PHIEU_MA, cv.CAN_TONG, cv.TONG_GIA_TRI DINHGIA,
                      cv.TU_NGAY ,cv.DEN_NGAY NGAY_QUA_HAN, cv.TIEN_KHACH_NHAN, cnt.TIEN_THEM,
                      (cv.CAN_TONG - cv.TL_HOT) TL_THUC, cv.TL_HOT, cv.LY_DO_MAT_PHIEU,
                      ( cv.TIEN_KHACH_NHAN +  IFNULL(cnt.TIEN_THEM,0)) TIEN_CAM_MOI, cv.LAI_XUAT,
                      DATEDIFF(cv.DEN_NGAY, cv.NGAY_LAP) AS SO_NGAY_HET_HAN, cv.MAT_PHIEU,
                      DATEDIFF( CURDATE() ,cv.NGAY_LAP) SO_NGAY_TINH_DUOC,ctcv.THANH_TIEN,
                      cv.GHI_CHU, ctcv.LOAI_VANG, ctcv.TEN_HANG_HOA, ctcv.DON_GIA
                  FROM cam_phieu_cam_vang cv
                    INNER JOIN cam_chi_tiet_phieu_cam_vang ctcv ON cv.PHIEU_CAM_VANG_ID = ctcv.PHIEU_CAM_VANG_ID
                    JOIN phx_khach_hang kh ON cv.KH_ID = kh.KH_ID
                    left JOIN cam_nhan_tien_them cnt ON cnt.PHIEU_CAM_ID = cv.PHIEU_CAM_VANG_ID
                  WHERE cv.SU_DUNG=1 AND ctcv.SU_DUNG=1 AND kh.SU_DUNG=1 AND ctcv.LOAI_VANG = "${i.LOAI_VANG}"
                `, (err, result) => {
                  if(err){
                    reject(err);
                  }

                  //Thực hiện chuyển đổi
                  const ketqua = result.map( e =>({
                    "PHIEU_CAM_VANG_ID": e.PHIEU_CAM_VANG_ID,
                    "KH_TEN": e.KH_TEN,
                    "TEN_HANG_HOA": e.TEN_HANG_HOA,
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
                    "DON_GIA": Number(e.DON_GIA),
                    "SO_NGAY_TINH_DUOC": e.SO_NGAY_TINH_DUOC,
                    "SO_NGAY_HET_HAN": e.SO_NGAY_HET_HAN,
                    "THANH_TIEN": Number(e.THANH_TIEN),
                    "MAT_PHIEU": e.MAT_PHIEU,
                    "LY_DO_MAT_PHIEU": e.LY_DO_MAT_PHIEU,
                    "GHI_CHU": e.GHI_CHU,
                    "LOAI_VANG": e.LOAI_VANG
                  }));

                  //Lưu
                  const data = {LOAI_VANG: i.LOAI_VANG, data:ketqua};
                  resolve(data);
                });
              });
            });
            
            output = await Promise.all(promise);
            resolve(output);
          }catch(err){
            reject(err);
          }
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
  getPhieuXuatById,
  getThongTinTinhTongPhieuDangCam
};
