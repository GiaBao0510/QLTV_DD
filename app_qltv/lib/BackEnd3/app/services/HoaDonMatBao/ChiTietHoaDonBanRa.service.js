const { query } = require('express');
const db  = require('../../config/index_2');
const { param } = require('../../routers/HoaDonBanRa.router');

//1. Lấy chi tiết hóa đơn dựa trên ID
const getChiTietHoaDonBanRa_ID = async (Fkey) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM ChiTietHoaDonBanRa WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa chi tiết hóa đơn dựa trên ID
const deleteChiTietHoaDonBanRa_ID = async (Fkey) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM ChiTietHoaDonBanRa WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin chi tiết hóa đơn thành công"});
            }
        );
    });
}

//3.Cập nhật chi tiết hóa đơn dựa trên ID
const updateChiTietHoaDonBanRa_ID = async (Fkey, ReqBody) =>{
    const {
        ProdAttr, VATRate, Code
    } = ReqBody;

    const TempFkey = Fkey;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM ChiTietHoaDonBanRa WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin chi tiết hóa đơn - Error: ${err}`});
                }else{
                    db.query(`
                        UPDATE ChiTietHoaDonBanRa 
                        SET Fkey="${Fkey}", ProdAttr="${ProdAttr}", VATRate="${VATRate}",
                            Code="${Code}"
                        WHERE Fkey = "${TempFkey}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin chi tiết hóa đơn. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin chi tiết hóa đơn thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const  getChiTietHoaDonBanRas = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM ChiTietHoaDonBanRa`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//Hàm thực hiện truy vấn
const queryDB = (query) =>{
    return new Promise((resolve, reject) => {
        db.query(query, (err, results)=>{
            if(err) return reject(err);
            resolve(results);
        });
    });
}

//5.Thêm
const addChiTietHoaDonBanRa = async (ReqBody) =>{
    const {Fkey, ProdAttr, VATRate, Code}  = ReqBody;

    try{

        //ĐK đầu vào Tìm trước các khóa ngoại xem có tồn tại hay không
        const tim_Fkey = await queryDB(`SELECT * FROM Invoice WHERE Fkey = "${Fkey}"`);
        if(tim_Fkey.length === 0){
            console.log("Lỗi. không tìm thấy Fkey.");
            throw new Error('không tìm thấy Fkey');
        }
        
        const tim_Code = await queryDB(`SELECT * FROM Products WHERE Code = "${Code}"`);
        if(tim_Code.length === 0){
            console.log("Lỗi. không tìm thấy Code.");
            throw new Error('không tìm thấy Code');
        }

        const tim_ProdAttr  = await queryDB(`SELECT * FROM ProductProperties  WHERE ProdAttr  = "${ProdAttr}"`);
        if(tim_ProdAttr.length === 0){
            console.log("Lỗi. không tìm thấy ProdAttr.");
            throw new Error('Lỗi. không tìm thấy ProdAttr');
        }

        const tim_VATRate   = await queryDB(`SELECT * FROM TaxPercentage  WHERE VATRate  = "${VATRate}"`);
        if(tim_VATRate.length === 0){
            console.log("Lỗi. không tìm thấy VATRate.");
            throw new Error("Lỗi. không tìm thấy VATRate.");
        }

        //Thêm thông tin 
        await queryDB(`INSERT INTO ChiTietHoaDonBanRa(Fkey, ProdAttr, VATRate, Code) VALUE('${Fkey}', ${ProdAttr}, ${VATRate}, '${Code}');`);

        return {message: "Thêm thông tin chi tiết hóa đơn thành công"};

    }catch(err){
        return {message: `Lỗi: ${err.message}`};
    }
}

module.exports = {
    getChiTietHoaDonBanRa_ID,
    deleteChiTietHoaDonBanRa_ID,
    updateChiTietHoaDonBanRa_ID,
    addChiTietHoaDonBanRa,
    getChiTietHoaDonBanRas
}