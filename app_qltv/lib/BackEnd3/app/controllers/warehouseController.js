var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
var ApiError = require('../api-error');

//1. danh sách thông tin kho
exports.list_wareHouse = async (req, res, next) =>{
    try{
        db.query(`SELECT * FROM gd_kho where SU_DUNG="1"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi lấy danh sách thông tin kho - ${err}`);
                return res.status(404).json({message: `Loi khi lấy danh sách thong tin kho`});
            }else{
                let KetQua = results.map(result =>({
                    "KHOID": Number(result.KHOID),
                    "KHOMA": result.KHOMA,
                    "KHO_TEN": result.KHO_TEN,
                    "SU_DUNG": result.SU_DUNG
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa danh sách kho: ${err.message}`));
    }
}

//2. lấy thông tin kho theo ID
exports.lay_wareHouse= async (req, res, next) =>{
    try{
        const KHOMA = req.params.KHOMA;
    
        db.query(`select * from gd_kho where KHOMA = "${KHOMA}" AND  SU_DUNG="1"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi tìm thông tin kho - ${err}`);
                return res.status(404).json({message: `Loi khi tìm thong tin kho - ${KHOMA}`});
            }else{
                let KetQua = results.map(result =>({
                    "KHOID": Number(result.KHOID),
                    "KHOMA": result.KHOMA,
                    "KHO_TEN": result.KHO_TEN,
                    "SU_DUNG": result.SU_DUNG
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi tìm kho: ${err.message}`));
    }
}

//3.Thêm thông tin  kho
exports.Add_wareHouse= async (req, res, next) =>{
    try{
        const KHO_TEN = req.body.KHO_TEN,
        SU_DUNG = 1;
    
        //Thêm trước mớ thông tin ngoại trừ ID và mã NCC
        db.query('insert into gd_kho(KHO_TEN,SU_DUNG) values(?,?)',[KHO_TEN,SU_DUNG],(err, result)=>{
            if(err){
                console.log(`Lỗi khi gửi thông tin kho - ${err}`);
                return res.status(404).json({message: `Loi khi gui thong tin kho`});
            }else{

                //lấy ID cuối
                db.query("SELECT KHOID FROM gd_kho ORDER BY KHOID DESC LIMIT 1",(err, result)=> {
                    if(err){
                        console.log(`Lỗi khi lấy ID cuối thông tin kho - ${err}`);
                        return res.status(404).json({message: `Loi khi lấy ID cuối thong tin kho`});
                    }else{
                        let IDcuoi = Number(result[0].KHOID);

                        //Chuyển ID cuối về chuỗi
                        const IDchuoi = String(IDcuoi);
                        
                        db.query(`update gd_kho set KHOMA="${IDchuoi}" where KHOID = "${IDcuoi}"`, (err, results)=>{
                            if (err) {
                                console.log(`Lỗi khi cập nhật KHOMA của kho - ${err}`);
                                return res.status(404).json({message: `Loi khi cập nhật KHOMA của kho`});
                            } else {
                                return res.status(200).json({message: `Thêm thong tin kho thanh cong, ID: ${IDcuoi}`});
                            }
                        })
                    }
                })
            }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them kho: ${err.message}`));
    }
}

//4. xóa thông tin kho
exports.delete_wareHouse= async (req, res, next) =>{
    try{
        const KHOMA = req.params.KHOMA;
    
        db.query(`update gd_kho set SU_DUNG="0" where KHOMA = "${KHOMA}"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin kho - ${err}`);
                return res.status(404).json({message: `Loi khi xóa thong tin kho - ${KHOMA}`});
            }else{
                
                return res.status(200).json({message: `xóa thong tin kho thanh cong- ${KHOMA}`});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa kho: ${err.message}`));
    }
}

//5. sửa thông tin kho
exports.Update_wareHouse= async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let KHOMA = req.params.KHOMA;
        KHOMA = String(KHOMA);

        //Thông tin sửa
        const KHO_TEN = req.body.KHO_TEN,
            SU_DUNG = 1;
    
        db.query(`update gd_kho
                set KHO_TEN="${KHO_TEN}", SU_DUNG="${SU_DUNG}"
                where KHOMA="${KHOMA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi cập nhật thông tin kho - ${err}`);
                return res.status(404).json({message: `Không tìm thấy ID kho`});
            }else{

                return res.status(200).json({message: `cập nhật thong tin kho thanh cong ,ID: ${KHOMA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi cap nhat thong tin kho: ${err.message}`));
    }
}