const db = require('../config/index_2');
const bcrypt = require('bcrypt');

const createUser = async (userData) => {
  let { USER_TEN, MAT_KHAU, USER_MA, BIKHOA, NGAY_TAO, SU_DUNG, REALM, EMAIL, EMAILVERIFIED, VERIFICATIONTOKEN, MAC, LY_DO_KHOA } = userData;

  let saltRounds = 10;
  let salt = await bcrypt.genSalt(saltRounds);
  MAT_KHAU = await bcrypt.hash(MAT_KHAU, salt);

  return new Promise((resolve, reject) => {
    db.query('INSERT INTO pq_user(USER_MA,USER_TEN, MAT_KHAU, BIKHOA, LY_DO_KHOA, NGAY_TAO, SU_DUNG, REALM, EMAIL, EMAILVERIFIED, VERIFICATIONTOKEN, MAC) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)', 
    [USER_MA, USER_TEN, MAT_KHAU, BIKHOA, LY_DO_KHOA, NGAY_TAO, SU_DUNG, REALM, EMAIL, EMAILVERIFIED, VERIFICATIONTOKEN, MAC], 
    (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const updateUser = async (id, userData) => {
  try {
    if (userData.MAT_KHAU) {
      const saltRounds = 10;
      const hashP = await bcrypt.hash(userData.MAT_KHAU, saltRounds);
      userData.MAT_KHAU = hashP;
    }
    return new Promise((resolve, reject) => {
      db.query('UPDATE pq_user SET ? WHERE USER_ID = ?', [userData, id], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  } catch (error) {
    throw error;
  }
};

const deleteUser = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('UPDATE pq_user SET SU_DUNG = 0 WHERE USER_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getUserById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM pq_user WHERE USER_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllUsers = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM pq_user WHERE SU_DUNG = 1', (error, results) => {
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
