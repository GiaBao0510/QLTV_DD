const db  = require('../../config/index_2');

//1. Lấy phương thức thanh toán dựa trên ID
const getPaymentMethob_ID = async (ID_PM) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM PaymentMethod WHERE ID_PM = "${ID_PM}"`,
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
const deletePaymentMethob_ID = async (ID_PM) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM PaymentMethod WHERE ID_PM = "${ID_PM}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin hình thức thanh toán thành công"});
            }
        );
    });
}

//3.Cập nhật phương thức thanh toán dựa trên ID
const updatePaymentMethob_ID = async (ID_PM, ReqBody) =>{
    const {phuongthucthanhtoan} = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM PaymentMethod WHERE ID_PM = "${ID_PM}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin hình thức thanh toán - Error: ${err}`});
                }else{
                    db.query(`UPDATE PaymentMethod SET phuongthucthanhtoan = "${phuongthucthanhtoan}" WHERE ID_PM = "${ID_PM}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin phương thức thanh toán. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin hình thức thanh toán thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getPaymentMethobs = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM PaymentMethod`,
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
const addPaymentMethobs = async (ReqBody) =>{
    const {phuongthucthanhtoan} = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO PaymentMethod(phuongthucthanhtoan) VALUE(?);`,[phuongthucthanhtoan],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin hình thức thanh toán - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin hình thức thanh toán thành công"});
            }
        );
    });
}

module.exports = {
    getPaymentMethob_ID,
    deletePaymentMethob_ID,
    updatePaymentMethob_ID,
    addPaymentMethobs,
    getPaymentMethobs
}