const mysql = require('mysql');
const config = require('../config/index');
const { use } = require('../routers/userRoutes');

// Kết nối với MySQL
const connection = mysql.createConnection({
  host: config.development.host,
  user: config.development.user,
  password: config.development.password,
  database: config.development.database
});
const createGroupUser = async (userData) => {
  return new Promise((resolve, reject) => {
    connection.query('INSERT INTO pq_group SET ?', userData, (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const updateGroupUser = async (id, userData) => {
  return new Promise((resolve, reject) => {
    connection.query('UPDATE pq_group SET ? WHERE GROUP_ID = ?', [userData, id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });

}
// create table pq_group
// (
//    GROUP_ID             int zerofill not null auto_increment,
//    GROUP_MA             varchar(50),
//    GROUP_TEN            national varchar(50),
//    BIKHOA               bool,
//    LY_DO_KHOA           national varchar(50),
//    SU_DUNG              bool,
//    NGAY_TAO             datetime,
//    primary key (GROUP_ID)
// );

const deleteGroupUser = async (id) => {
  return new Promise((resolve, reject) => {
    connection.query('UPDATE pq_group SET SU_DUNG = 0 WHERE GROUP_ID = ?', id, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}
const getGroupUserById = (id) => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM pq_group WHERE GROUP_ID = ?', [id], (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllGroupUsers = () => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM pq_group WHERE SU_DUNG = 1', (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

module.exports = {
  createGroupUser,
  updateGroupUser,
  deleteGroupUser,
  getGroupUserById,
  getAllGroupUsers
};