const { query } = require('express');
const db  = require('../../config/index_2');

//1. Lấy hóa đơn dựa trên ID
const getInvoice_ID = async (Fkey) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM Invoice WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

//2.Xóa hóa đơn dựa trên ID
const deleteInvoice_ID = async (Fkey) =>{
    return new Promise((resolve, reject) => {
        db.query(
            `DELETE FROM Invoice WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve({message: "Xóa thông tin hóa đơn thành công"});
            }
        );
    });
}

//3.Cập nhật hóa đơn dựa trên ID
const updateInvoice_ID = async (Fkey, ReqBody) =>{
    const {
        ApiInvPattern, ApiInvSerial, Total, DiscountAmount,
        Amount, VATAmount, AmountInWords, 
        SO, NOTE, TyGia, MaKH, ID_PM, SoDVTT
    } = ReqBody;

    return new Promise((resolve, reject) => {

        //Tìm kiếm xem có tìm thấy thông tin payment có sẵn không, nếu có thì cập nhập. Ngược lại thì không
        db.query(
            `SELECT * FROM Invoice WHERE Fkey = "${Fkey}"`,
            (err, result) =>{
                if(err){
                    return reject({mesage: `Lỗi không tìm thấy thông tin hóa đơn - Error: ${err}`});
                }else{
                    db.query(`
                        UPDATE Invoice 
                        SET ApiInvPattern="${ApiInvPattern}", ApiInvSerial="${ApiInvSerial}", Total="${Total}",
                            DiscountAmount="${DiscountAmount}", Amount="${Amount}", VATAmount="${VATAmount}", 
                            AmountInWords="${AmountInWords}", SO="${SO}", NOTE="${NOTE}", 
                            TyGia="${TyGia}", MaKH="${MaKH}", ID_PM="${ID_PM}", SoDVTT="${SoDVTT}"
                        WHERE Fkey = "${Fkey}" `,
                        (err, result) =>{
                            if(err){
                                return reject({mesage: `Lỗi khi cập nhật thông tin hóa đơn. Error: ${err}`});
                            }
                            resolve({message: "Cập nhật thông tin hóa đơn thành công"});
                        }
                    );
                }
                
            }
        );
    });
}

//4. Lấy tất cả
const  getInvoices = async () =>{
    return new Promise((resolve, reject) => {
        db.query(
            `SELECT * FROM Invoice`,
            (err, result) =>{
                if(err){
                    reject(err);
                }
                resolve(result);
            }
        );
    });
}

const queryDB = (query) =>{
    return new Promise((resolve, reject) => {
        db.query(query, (err, result)=>{
            if(err) reject(err);
            resolve(result);
        });
    });
}

//5.Thêm
const addInvoice = async (ReqBody) =>{
    let {Fkey,ApiInvPattern, ApiInvSerial, Total, DiscountAmount,
        Amount, VATAmount, AmountInWords,
        SO, NOTE, TyGia, MaKH, PaymentMethod, SoDVTT}  = ReqBody;
    Fkey = String(Fkey);
    let ID_PM = 0;

    //Kiểm tra xem Fkey có null không, nếu null thì tạo mới, ngược lại thì không
    if(Fkey.length === 0){
        //Lấy ngày/tháng/năm, Giờ:phút:Giấy:mili giây hiện tại đưa về chuỗi
        let ngay = new Date().getDate(),
        thang = new Date().getMonth()+1,
        nam = new Date().getFullYear(),
        gio = new Date().getHours(),
        phut = new Date().getMinutes(),
        giay = new Date().getSeconds(),
        miligiay = new Date().getMilliseconds();
        let chuoi = String(ngay) +String(thang) +String(nam) 
            +String(gio) + String(phut) + String(giay) 
            + String(miligiay);

        //Tạo 1 chuỗi random 4 ký tự 
        let StringRandom = (Math.random()+1).toString(36).substring(4).slice(0,4);
        Fkey = StringRandom+chuoi;
    }

    try{
        //1.Kiểm tra Mã KH có tồn tại hay không
        const DK1 = await queryDB(`SELECT * FROM Client WHERE MaKH="${MaKH}"`);
        if(DK1.length === 0) throw Error("Mã khách hàng không tồn tại");

        //2.Kiểm tra Đơn vị tiền tệ có tồn tại hay không
        const DK2 = await queryDB(`SELECT * FROM CurrencyType WHERE SoDVTT="${SoDVTT}"`);
        if(DK2.length === 0) throw Error("Mã đơn vị tiền tệ không tồn tại");

        //3.Kiểm tra mã phương thức thanh toán có tồn tại không. Nếu không thì tạo mới
        const DK3 = await queryDB(`SELECT * FROM PaymentMethod WHERE (STRCMP(phuongthucthanhtoan,"${PaymentMethod}")=0) `);
        if(DK3.length === 0){
            //Tạo mới
            await queryDB(`INSERT INTO PaymentMethod(phuongthucthanhtoan) VALUE("${String(PaymentMethod) }");`);
        }
            //Lấy ID_PM cuối 
        const IDcuoi = await queryDB(`SELECT ID_PM FROM PaymentMethod ORDER BY ID_PM DESC LIMIT 1`);
        ID_PM = Number(IDcuoi[0].ID_PM);

        //4.Kiểm tra xem Fkey có bị trùng không
        const DK4 = await queryDB(`SELECT * FROM Invoice WHERE Fkey="${Fkey}"`);
        if(DK4.length > 0)throw Error("Fkey đã tồn tại. Vui lòng điền Fkey khác");


        //Thực hiện thêm vào
        await queryDB(`
            INSERT INTO Invoice(Fkey,ApiInvPattern,ApiInvSerial,Total,DiscountAmount,Amount,VATAmount,AmountInWords,SO,NOTE,TyGia,MaKH,ID_PM,SoDVTT) 
            VALUE(
                "${Fkey}" ,"${ApiInvPattern}" ,"${ApiInvSerial}" ,${Total} ,
                ${DiscountAmount} ,${Amount} ,${VATAmount} ,"${AmountInWords}" ,
                "${SO}" , "${NOTE}", ${TyGia}, "${MaKH}", ${ID_PM}, "${SoDVTT}"
            );
        `);
        console.log('Thêm thông tin hóa đơn thành công');
        return {
            Fkey: Fkey ,
            message: "Thêm thông tin hóa đơn thành công."
        };

    }catch(err){
        console.log(`Lỗi thêm hóa đơn: ${err.message}`);
        return {message: `Lỗi thêm hóa đơn: ${err.message}`};
    }
}

module.exports = {
    getInvoice_ID,
    deleteInvoice_ID,
    updateInvoice_ID,
    addInvoice,
    getInvoices
}