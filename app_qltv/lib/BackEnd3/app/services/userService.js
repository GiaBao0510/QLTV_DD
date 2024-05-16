const mysql = require('mysql');
const config = require('../config/index');
const { use } = require('../routers/userRoutes');
const bcrypt = require('bcrypt');

// Kết nối với MySQL
const connection = mysql.createConnection({
  host: config.development.host,
  user: config.development.user,
  password: config.development.password,
  database: config.development.database
});

const createUser = async (userData) => {
  let USER_TEN = userData.USER_TEN,
    MAT_KHAU = userData.MAT_KHAU,
    USER_MA = userData.USER_MA,
    BIKHOA = userData.BIKHOA,
    NGAY_TAO = userData.NGAY_TAO,
    SU_DUNG = userData.SU_DUNG,
    REALM = userData.REALM,
    EMAIL = userData.EMAIL,
    EMAILVERIFIED = userData.EMAILVERIFIED,
    VERIFICATIONTOKEN = userData.VERIFICATIONTOKEN,
    MAC = userData.MAC,
    LY_DO_KHOA = userData.LY_DO_KHOA;

  let saltRounds = 10;
  let salt = await bcrypt.genSalt(saltRounds);
  MAT_KHAU = await bcrypt.hash(MAT_KHAU, salt);

  return new Promise((resolve, reject) => {
    connection.query('INSERT INTO pq_user(USER_MA,USER_TEN, MAT_KHAU, BIKHOA, LY_DO_KHOA, NGAY_TAO, SU_DUNG, REALM, EMAIL, EMAILVERIFIED, VERIFICATIONTOKEN, MAC) VALUES(?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ', [USER_MA, USER_TEN, MAT_KHAU, BIKHOA, LY_DO_KHOA, NGAY_TAO, SU_DUNG, REALM, EMAIL, EMAILVERIFIED, VERIFICATIONTOKEN, MAC], (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const updateUser = async (id, userData) => {
  try {
    if (userData.MAT_KHAU) {
      const saltRounds = 10;
      const hashP = await bcrypt.hash(userData.MAT_KHAU, saltRounds);
      userData.MAT_KHAU = hashP;
    }
    return new Promise((resolve, reject) => {
      connection.query('UPDATE pq_user SET ? WHERE USER_ID = ?', [userData, id], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  } catch (error) {
    next(error);
  }

}
const deleteUser = async (id) => {
  return new Promise((resolve, reject) => {
    connection.query('DELETE FROM pq_user WHERE USER_ID = ?', id, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const getUserById = (id) => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM pq_user WHERE USER_ID = ?', [id], (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllUsers = () => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM pq_user', (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

module.exports = {
  createUser,
  updateUser,
  deleteUser,
  getUserById,
  getAllUsers,
};