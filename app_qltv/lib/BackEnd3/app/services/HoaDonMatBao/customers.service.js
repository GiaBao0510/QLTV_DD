const db  = require('../../config/index_2');

//1.Lấy thông tin khách hàng dự trên hóa đơn
const getKhachHang_maKH = async (MaKH) =>{
    return new Promise((resolve, reject) => {
        db.query(`
            SELECT *
            FROM Client
            WHERE MaKH = '${MaKH}'
        `, (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        });
    });
}

//2.Xóa thông tin khách hàng thông qua mã sản phẩm
const deleteKhachHang = async (MaKH) =>{
    return new Promise((resolve, reject) => {
        db.query(`
            DELETE 
            FROM Client
            WHERE MaKH = '${MaKH}'
        `, (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        });
    });
} 

//3.Xóa thông tin khách hàng thông qua mã sản phẩm
const getKhachHang = async () =>{
    return new Promise((resolve, reject) => {
        db.query(`
           SELECT * FROM Client
        `, (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        });
    });
}

//4. Thêm thông tin khách hàng 
const insertKhachHang = async (ReqBody) =>{
    const {
        MaKH ,CusName, Buyer, CusAddress, 
        CusPhone, CusTaxCode, CusEmail,
        CusEmailCC, CusBankName, CusBankNo
    } = ReqBody;
    return new Promise((resolve, reject) => {

        //Nếu mã KH rỗng thì báo lỗi
        if(MaKH === ""){
            return reject({message: "Lỗi. Không thể thêm thông tin khách hàng .Vì mã KH để rỗng."});
        }

        //Tìm kiếm xem có mã khách hàng nào bị trùng không, Nếu trùng thì không thêm được
        db.query(`
            SELECT *
            FROM Client
            WHERE MaKH = '${MaKH}'
        `,(err, results) => {
            if(err){
                return reject({message: `Lỗi không thể thêm thông tin khách hàng - Error: ${err}`});
            }else if(results.length > 0){
                return reject({message: "Thông tin khách hàng đã tồn tại."});
            }else{
                db.query(`
                    INSERT INTO Client(MaKH ,CusName, Buyer, CusAddress, CusPhone, CusTaxCode, CusEmail, CusEmailCC, CusBankName, CusBankNo)
	                VALUE(?,?,?,?,?,?,?,?,?,?);
                `,[MaKH ,CusName, Buyer, CusAddress, CusPhone, CusTaxCode, CusEmail,CusEmailCC, CusBankName, CusBankNo], 
                (err, results)=>{
                    if(err){
                        return reject({message: `Lỗi không thể thêm thông tin khách hàng - Error: ${err}`});
                    }
                    resolve({message: "Thêm thông tin khách hàng thành công"});
                });
            }
        });
    });
}

//5.  cập nhật 
const updateKhachHang = async (MaKH ,ReqBody) =>{
    return new Promise((resolve, reject) => {
        //Lấy mã khách hàng và thông tin sắp cập nhật
        const {
            CusName, Buyer, CusAddress, 
            CusPhone, CusTaxCode, CusEmail,
            CusEmailCC, CusBankName, CusBankNo
        } = ReqBody;

        //Tìm kiếm xem thông tin khách hàng đã tồn tại hay chưa
        db.query(`SELECT * FROM Client WHERE MaKH = '${MaKH}'`, (err, results) =>{
            if(err){
                return reject({message: `Lỗi không tìm thấy thông tin khách hàng cần cập nhật - Error: ${err}`});
            }else{
                db.query(`
                UPDATE Client
                SET CusName="${CusName}", Buyer="${Buyer}", CusAddress="${CusAddress}", CusPhone="${CusPhone}", CusTaxCode="${CusTaxCode}", CusEmail="${CusEmail}", CusEmailCC="${CusEmailCC}", CusBankName="${CusBankName}", CusBankNo="${CusBankNo}"
                WHERE MaKH = '${MaKH}'
                `, (err, results) => {
                    if(err){
                        return reject({message: `Lỗi khi cập nhật thông tin khách hàng - Error: ${err}`});
                    }
                    console.log("Cập nhật thông tin khách hàng thành công");
                    resolve({message: "Cập nhật thông tin khách hàng thành công"});
                });
            }
        });
    });
}

const CheckCustomerAlreadyExists = async (MaKH)=>{
    return new Promise((resolve, reject)=>{
        if(MaKH == ""){
            return reject({message: "Lỗi vì không điền mã khách hàng."});
        }

        db.query(`SELECT * FROM Client WHERE MaKH = '${MaKH}'`,(err, result)=>{
            if(err) return reject({message: "Lỗi khi tìm thông tin khách hàng"});
            else if(result.length === 0) return resolve(0);
            return resolve(1);
        })
    } );
}

module.exports = {
    getKhachHang_maKH, deleteKhachHang, getKhachHang,
    insertKhachHang, updateKhachHang,
    CheckCustomerAlreadyExists
}