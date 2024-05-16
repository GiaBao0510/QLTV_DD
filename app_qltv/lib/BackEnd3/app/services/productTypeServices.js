const mysql = require('mysql');
const config = require('../config/index');
//const { use } = require('../routers/userRoutes');

// Kết nối với MySQL
const connection = mysql.createConnection({
  host: config.development.host,
  user: config.development.user,
  password: config.development.password,
  database: config.development.database
});
// NHOMHANGID           int zerofill not null auto_increment,
// NHOMHANGMA           varchar(3),
// NHOMCHAID            int,
// NHOM_TEN             national varchar(50),
// DON_GIA_BAN          numeric(18,5),
// DON_GIA_MUA          numeric(18,5),
// MUA_BAN              bool,
// DON_GIA_VON          numeric(18,5),
// DON_GIA_CAM          numeric(18,5),
// SU_DUNG              bool,
// GHI_CHU              varchar(50),

const createProductType = async (userData) => {
  return new Promise((resolve, reject) => {
    connection.query('INSERT INTO nhom_hang SET ?', userData, (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const updateProductType = async (id, userData) => {
  return new Promise((resolve, reject) => {
    connection.query('UPDATE nhom_hang SET ? WHERE NHOMHANGID = ?', [userData, id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });

}
const deleteProductType = async (id) => {
  return new Promise((resolve, reject) => {
    connection.query('DELETE FROM nhom_hang WHERE NHOMHANGID = ?', id, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const getProductTypeById = (id) => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM nhom_hang WHERE NHOMHANGID = ?', [id], (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllProductType = () => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM nhom_hang', (error, results, fields) => {
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