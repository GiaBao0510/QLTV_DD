const db = require('../config/index_2');

const createProductType = async (userData) => {
  return new Promise((resolve, reject) => {
    db.query('INSERT INTO nhom_hang SET ?', userData, (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const updateProductType = async (id, userData) => {
  return new Promise((resolve, reject) => {
    db.query('UPDATE nhom_hang SET ? WHERE NHOMHANGID = ?', [userData, id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const deleteProductType = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('UPDATE nhom_hang SET SU_DUNG = 0 WHERE NHOMHANGID = ?', id, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getProductTypeById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM nhom_hang WHERE NHOMHANGID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllProductType = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM nhom_hang WHERE SU_DUNG = 1', (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

module.exports = {
  createProductType,
  updateProductType,
  deleteProductType,
  getProductTypeById,
  getAllProductType
};
