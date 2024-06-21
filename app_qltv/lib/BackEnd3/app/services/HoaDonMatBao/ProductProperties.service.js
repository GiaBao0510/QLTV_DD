const db  = require('../../config/index_2');

//1. Lấy tính chất dựa trên ID
const getProductProperties_ID = async (ProdAttr) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM ProductProperties WHERE ProdAttr = "${ProdAttr}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa tính chất dựa trên ID
const deleteProductProperties_ID = async (ProdAttr) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM ProductProperties WHERE ProdAttr = "${ProdAttr}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin tính chất thành công"});
            }
        );
    });
}

//3.Cập nhật tính chất dựa trên ID
const updateProductProperties_ID = async (ProdAttr, ReqBody) =>{
    const {TenHinhThucThanhToan} = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM ProductProperties WHERE ProdAttr = "${ProdAttr}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin tính chất - Error: ${err}`});
                }else{
                    db.query(`UPDATE ProductProperties SET TenHinhThucThanhToan = "${TenHinhThucThanhToan}" WHERE ProdAttr = "${ProdAttr}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin tính chất. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin tính chất thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getProductProperties = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM ProductProperties`,
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
const addProductProperties = async (ReqBody) =>{
    const {TenHinhThucThanhToan}  = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO ProductProperties(TenHinhThucThanhToan) VALUE(?);`,[TenHinhThucThanhToan],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin tính chất - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin tính chất thành công"});
            }
        );
    });
}

module.exports = {
    getProductProperties_ID,
    deleteProductProperties_ID,
    updateProductProperties_ID,
    addProductProperties,
    getProductProperties
}