const db = require('../config/index_2');

const createGroupUser = async (userData) => {
  return new Promise((resolve, reject) => {
    db.query('INSERT INTO pq_group SET ?', userData, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const updateGroupUser = async (id, userData) => {
  return new Promise((resolve, reject) => {
    db.query('UPDATE pq_group SET ? WHERE GROUP_ID = ?', [userData, id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const deleteGroupUser = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('UPDATE pq_group SET SU_DUNG = 0 WHERE GROUP_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

const getGroupUserById = async (id) => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM pq_group WHERE GROUP_ID = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results[0]);
      }
    });
  });
};

const getAllGroupUsers = async () => {
  return new Promise((resolve, reject) => {
    db.query('SELECT * FROM pq_group WHERE SU_DUNG = 1', (error, results) => {
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
