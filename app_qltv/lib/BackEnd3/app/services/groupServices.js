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
const deleteGroupUser = async (id) => {
  return new Promise((resolve, reject) => {
    connection.query('DELETE FROM pq_group WHERE GROUP_ID = ?', id, (error, results) => {
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
    connection.query('SELECT * FROM pq_group', (error, results, fields) => {
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