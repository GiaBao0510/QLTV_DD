const db  = require('../../config/index_2');

//1. Lấy sản phẩm dựa trên ID
const getProducts_ID = async (Code) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM Products WHERE Code = "${Code}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa sản phẩm dựa trên ID
const deleteProducts_ID = async (Code) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM Products WHERE Code = "${Code}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin sản phẩm thành công"});
            }
        );
    });
}

//3.Cập nhật sản phẩm dựa trên ID
const updateProducts_ID = async (Code, ReqBody) =>{
    const {
        ProdName, ProdUnit, ProdQuantity, DiscountAmount,
        Discount, ProdPrice, DiscountedTax, VATAmount, Total,
        Amount, Remark
    } = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM Products WHERE Code = "${Code}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin sản phẩm - Error: ${err}`});
                }else{
                    db.query(`
                        UPDATE Products 
                        SET ProdName="${ProdName}", ProdUnit="${ProdUnit}", ProdQuantity="${ProdQuantity}",
                            DiscountAmount="${DiscountAmount}", Discount="${Discount}", ProdPrice="${ProdPrice}", 
                            DiscountedTax="${DiscountedTax}", VATAmount="${VATAmount}", Total="${Total}", 
                            Amount="${Amount}", Remark="${Remark}"
                        WHERE Code = "${Code}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin sản phẩm. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin sản phẩm thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const getProductss = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM Products`,
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
const addProducts = async (ReqBody) =>{
    const {Code, ProdName, ProdUnit, ProdQuantity, DiscountAmount,
        Discount, ProdPrice, DiscountedTax, VATAmount, Total,
        Amount, Remark}  = ReqBody;

    return new Promise((resolve, reject) => {
        db.query(
            `INSERT INTO Products(Code, ProdName, ProdUnit, ProdQuantity, DiscountAmount,Discount, ProdPrice, DiscountedTax, VATAmount, Total,Amount, Remark) 
            VALUE(?,?);`,
            [Code, ProdName, ProdUnit, ProdQuantity, DiscountAmount,Discount, ProdPrice, DiscountedTax, VATAmount, Total,Amount, Remark],
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi khi thêm thông tin sản phẩm - ERROR: ${err}`});
                }
                return resolve({mesage: "Thêm thông tin sản phẩm thành công"});
            }
        );
    });
}

module.exports = {
    getProducts_ID,
    deleteProducts_ID,
    updateProducts_ID,
    addProducts,
    getProductss
}