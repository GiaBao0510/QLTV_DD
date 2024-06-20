const db= require('../config/index_2');

const createGroupUser = async (userData) => {
  // return new Promise((resolve, reject) => {
  //   db.query('INSERT INTO pq_group SET ?', userData, (error, results) => {
  //     if (error) {
  //       reject(error);
  //     } else {
  //       resolve(results);
  //     }
  //   });
  // });
  const defaultData = {
    BIKHOA: 0,
    SU_DUNG: 1,
    ...userData
  };
  return new Promise((resolve, reject) => {
    db.query('INSERT INTO pq_group SET ?', defaultData, (error, results) => {
      if (error) {
        reject(error);
      } else {
        db.query('select GROUP_ID from pq_group order by GROUP_ID DESC LIMIT 1',(err, result) =>{
          if (err) {
            console.log(`Lỗi khi lấy ID cuối thông tin nhóm người dung - ${err}`);
            return reject({message: 'Lỗi khi lấy ID cuối'});
          }else{
            let IDcuoi = Number(result[0].GROUP_ID);
            const IDchuoi = String(IDcuoi);
            db.query(`update pq_group set GROUP_MA="${IDchuoi}" where GROUP_ID="${IDcuoi}"`,(err, results)=> {
              if (err) {
                console.log(`Lỗi khi cập nhật GROUP_ID nhóm - ${err}`);
                return reject({message: 'Lỗi khi cập nhật GROUP_ID'});
              } else {
                resolve({message: `Thêm thông tin nhóm thành công, ID: ${IDcuoi}`});
              }
            })
          }
        })
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
