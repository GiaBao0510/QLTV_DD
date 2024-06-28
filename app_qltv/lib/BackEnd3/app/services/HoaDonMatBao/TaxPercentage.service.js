const db  = require('../../config/index_2');

//1. Lấy phầm trăm thuế dựa trên ID
const getTaxPercentage_ID = async (VATRate) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM TaxPercentage WHERE VATRate = "${VATRate}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa phầm trăm thuế dựa trên ID
const deleteTaxPercentage_ID = async (VATRate) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM TaxPercentage WHERE VATRate = "${VATRate}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin phầm trăm thuế thành công"});
            }
        );
    });
}

//3.Cập nhật phầm trăm thuế dựa trên ID
const updateTaxPercentage_ID = async (VATRate, ReqBody) =>{
    const {TenThueSuat} = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM TaxPercentage WHERE VATRate = "${VATRate}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin phầm trăm thuế - Error: ${err}`});
                }else{
                    db.query(`UPDATE TaxPercentage SET TenThueSuat = "${TenThueSuat}" WHERE VATRate = "${VATRate}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin phầm trăm thuế. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin phầm trăm thuế thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getTaxPercentages = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM TaxPercentage`,
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
const addTaxPercentage = async (ReqBody) =>{
    const {TenThueSuat}  = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO TaxPercentage(TenThueSuat) VALUE(?);`,[TenThueSuat],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin phầm trăm thuế - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin phầm trăm thuế thành công"});
            }
        );
    });
}

//6. Kiểm tra ID của phần trăm thuế có tồn tại không
const CheckVATRateAlreadyExists = async (VATRate) =>{
    return new Promise((resolve, reject)=> {
        db.query(`SELECT * FROM TaxPercentage WHERE VATRate = ${VATRate}`, (err, result) => {
            if(err)  return reject({message: "Lỗi khi tìm không điền thông tin phầm trăm thuế."});
            else if(result.length === 0) return resolve(0);
            return resolve(1);
        });
    });
}

module.exports = {
    getTaxPercentage_ID,
    deleteTaxPercentage_ID,
    updateTaxPercentage_ID,
    addTaxPercentage,
    getTaxPercentages,
    CheckVATRateAlreadyExists
}