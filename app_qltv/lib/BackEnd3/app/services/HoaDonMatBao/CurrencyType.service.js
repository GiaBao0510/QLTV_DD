const db  = require('../../config/index_2');

//1. Lấy loại tiền tệ dựa trên ID
const getCurrencyType_ID = async (SoDVTT) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM CurrencyType WHERE SoDVTT = "${SoDVTT}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa loại tiền tệ dựa trên ID
const deleteCurrencyType_ID = async (SoDVTT) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM CurrencyType WHERE SoDVTT = "${SoDVTT}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin loại tiền tệ thành công"});
            }
        );
    });
}

//3.Cập nhật loại tiền tệ dựa trên ID
const updateCurrencyType_ID = async (SoDVTT, ReqBody) =>{
    const {Ma,DongTien } = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM CurrencyType WHERE SoDVTT = "${SoDVTT}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin loại tiền tệ - Error: ${err}`});
                }else{
                    db.query(`UPDATE CurrencyType SET Ma = "${Ma}", DongTien = "${DongTien}"  WHERE SoDVTT = "${SoDVTT}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin loại tiền tệ. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin loại tiền tệ thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getCurrencyTypes = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM CurrencyType`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}


//5.Thêm
const addCurrencyTypes = async (ReqBody) =>{
    const {SoDVTT,Ma,DongTien } = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO CurrencyType(SoDVTT,Ma,DongTien) VALUE(?,?,?);`,[SoDVTT,Ma,DongTien],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin loại tiền tệ - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin loại tiền tệ thành công"});
            }
        );
    });
}

module.exports = {
    getCurrencyType_ID,
    deleteCurrencyType_ID,
    updateCurrencyType_ID,
    addCurrencyTypes,
    getCurrencyTypes
}