var mysql = require('mysql');
var express = require('express');
var {db, db2} = require('../config/index_2');
var ApiError = require('../api-error');

//1.xóa danh sách thông tin nhà cung cấp 
exports.list_NhaCungCap = async (req, res, next) =>{
    try{

        db.query(`SELECT * FROM phn_nha_cung_cap WHERE SU_DUNG = 1`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi xóa danh sách thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin nhà cung cấp`});
            }else{
                let KetQua = results.map(result =>({
                        "NCCID": Number(result.NCCID),
                        "NCCMA": result.NCCMA,
                        "NCC_TEN": result.NCC_TEN,
                        "NGAYBD": new Date(result.NGAYBD).toLocaleDateString('vi-VN'),//.getDate() + "/"+ Number(new Date(result.NGAYBD).getMonth() + 1) +'/'+ new Date(result.NGAYBD).getFullYear() ),
                        "GIO_BD": new Date(result.NGAYBD).toLocaleTimeString('vi-VN'),
                        "GHI_CHU": result.GHI_CHU,
                        "SU_DUNG": result.SU_DUNG
                    })
                );
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa danh sách nhà cung cấp: ${err.message}`));
    }
}

//2. lấy thông tin nhà cung cấp theo ID
exports.lay_NhaCungCap = async (req, res, next) =>{
    try{
        const NCCMA = req.params.NCCMA;
    
        db.query(`select * from phn_nha_cung_cap where NCCMA = "${NCCMA}"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi xóa thong tin nhà cung cấp - ${NCCMA}`});
            }else{
                let KetQua = results.map(result =>({
                    "NCCID": Number(result.NCCID),
                    "NCCMA": result.NCCMA,
                    "NCC_TEN": result.NCC_TEN,
                    "NGAYBD": new Date(result.NGAYBD).toLocaleDateString('vi-VN'),//.getDate() + "/"+ Number(new Date(result.NGAYBD).getMonth() + 1) +'/'+ new Date(result.NGAYBD).getFullYear() ),
                    "GIO_BD": new Date(result.NGAYBD).toLocaleTimeString('vi-VN'),
                    "GHI_CHU": result.GHI_CHU,
                    "SU_DUNG": result.SU_DUNG
                })
            );
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa nhà cung cấp: ${err.message}`));
    }
}

//3.Thêm thông tin  nhà cung cấp
exports.Add_NhaCungCap = async (req, res, next) =>{
    try{
        const NCC_TEN = req.body.NCC_TEN,
        GHI_CHU = req.body.GHI_CHU,
        SU_DUNG = 1,
        NGAYBD = req.body.NGAYBD;
    
        //Thêm trước mớ thông tin ngoại trừ ID và mã NCC
        db.query('insert into phn_nha_cung_cap(SU_DUNG,NCC_TEN,GHI_CHU,NGAYBD) values(?,?,?,?)',[SU_DUNG,NCC_TEN,GHI_CHU,NGAYBD],(err, result)=>{
            if(err){
                console.log(`Lỗi khi gửi thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi gui thong tin nhà cung cấp`});
            }else{

                //xóa ID cuối
                db.query("SELECT NCCID FROM phn_nha_cung_cap ORDER BY NCCID DESC LIMIT 1",(err, result)=> {
                    if(err){
                        console.log(`Lỗi khi xóa ID cuối thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi xóa ID cuối thong tin nhà cung cấp`});
                    }else{
                        let IDcuoi = Number(result[0].NCCID);

                        //Chuyển ID cuối về chuỗi
                        const IDchuoi = String(IDcuoi);
                        
                        db.query(`update phn_nha_cung_cap set NCCMA="${IDchuoi}" where NCCID = "${IDcuoi}"`, (err, results)=>{
                            if (err) {
                                console.log(`Lỗi khi cập nhật NCCMA của nha cung cap - ${err}`);
                                return res.status(404).json({message: `Loi khi cập nhật NCCMA của nha cung cap`});
                            } else {
                                return res.status(200).json({message: `Thêm thong tin nha cung cap thanh cong, ID: ${IDcuoi}`});
                            }
                        })
                    }
                })
            }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them nhà cung cấp: ${err.message}`));
    }
}

//4. xóa thông tin nhà cung cấp
exports.delete_NhaCungCap = async (req, res, next) =>{
    try{
        const NCCMA = req.params.NCCMA;
    
        db.query(`UPDATE phn_nha_cung_cap SET SU_DUNG=0 WHERE NCCMA = "${NCCMA}"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi xóa thong tin nhà cung cấp - ${NCCMA}`});
            }else{
                
                return res.status(200).json({message: `xóa thong tin nhà cung cấp thanh cong- ${NCCMA}`});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa nhà cung cấp: ${err.message}`));
    }
}

//5. sửa thông tin nha cung cap
exports.Update_NhaCungCap = async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let NCCMA = req.params.NCCMA;
        NCCMA = String(NCCMA);

        //Thông tin sửa
        const NCC_TEN = req.body.NCC_TEN,
            GHI_CHU = req.body.GHI_CHU,
            SU_DUNG = 1,
            NGAYBD = req.body.NGAYBD;
    
        db.query(`update phn_nha_cung_cap
                set NCC_TEN="${NCC_TEN}", NGAYBD="${NGAYBD}", SU_DUNG="${SU_DUNG}", GHI_CHU="${GHI_CHU}" 
                where NCCMA="${NCCMA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi cập nhật thông tin khách hàng - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin nha cung cap`});
            }else{

                return res.status(200).json({message: `cập nhật thong tin nha cung cap thanh cong ,ID: ${NCCMA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi cap nhat thong tin nha cung cap: ${err.message}`));
    }
}