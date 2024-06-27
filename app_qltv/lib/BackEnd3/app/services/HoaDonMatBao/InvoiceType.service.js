const db  = require('../../config/index_2');

//1. Lấy phương thức thanh toán dựa trên ID
const getInvoiceType_ID = async (InvType) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM InvoiceType WHERE InvType = "${InvType}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa phương thức thanh toán dựa trên ID
const deleteInvoiceType_ID = async (InvType) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM InvoiceType WHERE InvType = "${InvType}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin loại hóa đơn thành công"});
            }
        );
    });
}

//3.Cập nhật phương thức thanh toán dựa trên ID
const updateInvoiceType_ID = async (InvType, ReqBody) =>{
    const {TenLoaiHoaDon} = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM InvoiceType WHERE InvType = "${InvType}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin loại hóa đơn - Error: ${err}`});
                }else{
                    db.query(`UPDATE InvoiceType SET TenLoaiHoaDon = "${TenLoaiHoaDon}" WHERE InvType = "${InvType}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin phương thức thanh toán. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin loại hóa đơn thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getInvoiceTypes = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM InvoiceType`,
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
const addInvoiceTypes = async (ReqBody) =>{
    const {TenLoaiHoaDon} = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO InvoiceType(TenLoaiHoaDon) VALUE(?);`,[TenLoaiHoaDon],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin loại hóa đơn - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin loại hóa đơn thành công"});
            }
        );
    });
}

module.exports = {
    getInvoiceType_ID,
    deleteInvoiceType_ID,
    updateInvoiceType_ID,
    addInvoiceTypes,
    getInvoiceTypes
}