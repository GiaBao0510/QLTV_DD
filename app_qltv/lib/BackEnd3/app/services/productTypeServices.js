const {db, db2} = require('../config/index_2');

const createProductType = async (userData) => {
  return new Promise((resolve, reject) => {
    db.query('INSERT INTO nhom_hang SET ?', userData, (error, results, fields) => {
      if (error) {
        return reject(error);
      } else {
        db.query('SELECT NHOMHANGID FROM nhom_hang ORDER BY NHOMHANGID DESC LIMIT 1', (err, result) => {
          if (err) {
            console.log(`Lỗi khi lấy ID cuối thông tin loại hàng - ${err}`);
            return reject({message: 'Lỗi khi lấy ID cuối thông tin loại hàng'});
          } else {
            let IDcuoi = Number(result[0].NHOMHANGID);
            // Chuyển ID cuối về chuỗi
            const IDchuoi = String(IDcuoi);
            db.query(`UPDATE nhom_hang SET 	NHOMHANGMA="${IDchuoi}" WHERE NHOMHANGID="${IDcuoi}"`, (err, results) => {
              if (err) {
                console.log(`Lỗi khi cập nhật NHOMHANGID của loại hàng - ${err}`);
                return reject({message: 'Lỗi khi cập nhật NHOMHANGID của loại hàng'});
              } else {
                resolve({message: `Thêm thông tin loại hàng thành công, ID: ${IDcuoi}`});
              }
            });
          }
        });
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
        const formattedResults = results.map(result => ({
          ...result,
          DON_GIA_BAN: parseFloat(result.DON_GIA_BAN),
          DON_GIA_MUA: parseFloat(result.DON_GIA_MUA),
          DON_GIA_VON: parseFloat(result.DON_GIA_VON),
          DON_GIA_CAM: parseFloat(result.DON_GIA_CAM)
        }));
        resolve(formattedResults);
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
