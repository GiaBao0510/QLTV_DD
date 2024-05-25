const db = require('../config/index_2');

// // table cam_phieu_cam_vang

const getPhieuDangCam = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM cam_phieu_cam_vang', (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
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
