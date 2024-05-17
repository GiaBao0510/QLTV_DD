var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
const ApiError = require('../api-error');

//1.Thêm loại hàng
exports.Add_LoaiHang = async (req, res, next) =>{
    try{
        const LOAI_TEN = req.body.LOAI_TEN,
        GHI_CHU = req.body.GHI_CHU,
        SU_DUNG = 1;

        db.query('insert into loai_hang(LOAI_TEN,GHI_CHU,SU_DUNG) values(?,?,?)',[LOAI_TEN,GHI_CHU,SU_DUNG],(err, result)=>{
            if(err){
                console.log(`Lỗi khi thêm thông tin loai hang - ${err}`);
                return res.status(404).json({message: `Loi khi them thong tin loai hang`});
            }else{

                //lấy ID cuối
                db.query("SELECT LOAIID FROM loai_hang ORDER BY LOAIID DESC LIMIT 1",(err, result)=> {
                    if(err){
                        console.log(`Lỗi khi lấy ID cuối thông tin loai hang- ${err}`);
                        return res.status(404).json({message: `Loi khi lấy ID cuối thong tin loai hang`});
                    }else{
                        let IDcuoi = Number(result[0].LOAIID);
                        //Chuyển ID cuối về chuỗi
                        const IDchuoi = String(IDcuoi);
                        db.query(`update loai_hang set LOAIMA="${IDchuoi}" where LOAIID = "${IDcuoi}"`, (err, results)=>{
                            if (err) {
                                console.log(`Lỗi khi cập nhật LOAIMA của loai hang - ${err}`);
                                return res.status(404).json({message: `Loi khi cập nhật LOAIMA của loai hang`});
                            } else {
                                return res.status(200).json({message: `Thêm thong tin loai hang thanh cong, ID: ${IDcuoi}`});
                            }
                        })
                    }
                })
            }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them loai hang: ${err.message}`));
    }
}


///2.Xóa loại hàng dựa trên ID loại hàng
exports.Delete_LoaiHang = async (req, res, next) =>{
    try{
        const LOAIID = req.params.LOAIID;
    
        db.query(`update loai_hang set SU_DUNG="0" where LOAIID = "${LOAIID}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin loại hàng - ${err}`);
                return res.status(404).json({message: `Loi khi xóa thong tin loai hang`});
            }else{

                return res.status(200).json({message: `xóa thong tin loai hang thanh cong ,ID: ${LOAIID} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa loai hang: ${err.message}`));
    }
}

//3.Sửa thông tin loại hàng
exports.update_LoaiHang = async (req, res, next) =>{
    try{
        //Truy vấn
        const LOAIID = req.params.LOAIID;
        //Thông tin cần cập nhật
        const LOAIMA = req.body.LOAIMA,
        LOAI_TEN = req.body.LOAI_TEN,
        GHI_CHU = req.body.GHI_CHU,
        SU_DUNG = req.body.SU_DUNG;
    
        db.query(`update loai_hang 
                set LOAIMA = "${LOAIMA}",LOAI_TEN ="${LOAI_TEN}", GHI_CHU="${GHI_CHU}", SU_DUNG="${SU_DUNG}"    
                where LOAIID = "${LOAIID}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi cập nhật thông tin loại hàng - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin loai hang`});
            }else{
                return res.status(200).json({message: `cập nhật thong tin loai hang thanh cong ,ID: ${LOAIID} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi cập nhật loai hang: ${err.message}`));
    }
}

//4.Lấy danh sách thông tin loại hàng 
exports.list_LoaiHang = async (req, res, next) =>{
    try{
    
<<<<<<< HEAD:app_qltv/lib/BackEndV2/app/controllers/loaiHang.controllers.js
        db.query(`SELECT * FROM loai_hang where SU_DUNG`,(err, results)=>{
=======
        db.query(`SELECT * FROM loai_hang where SU_DUNG="1"`,(err, results)=>{
>>>>>>> 5a882bfeafd538d51e13b11670677c27c0c34ef5:app_qltv/lib/BackEnd3/app/controllers/loaiHang.controllers.js
            if(err){
                console.log(`Lỗi khi lấy danh sách thông tin loại hàng - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin loai hang`});
            }else{
                let KetQua = results.map(result =>({
                    "LOAIID": Number(result.LOAIID),
                    "LOAIMA": result.LOAIMA,
                    "LOAI_TEN": result.LOAI_TEN,
                    "GHI_CHU": result.GHI_CHU,
                    "SU_DUNG": result.SU_DUNG,
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy danh sách loai hang: ${err.message}`));
    }
}

//5. Lấy thông tin loại hàng theo ID
exports.lay_LoaiHang = async (req, res, next) =>{
    try{
        const LOAIID = req.params.LOAIID;
    
        db.query(`select * from loai_hang where LOAIID = "${LOAIID}" AND SU_DUNG="1"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi lấy thông tin loại hàng - ${err}`);
                return res.status(404).json({message: `Loi khi lấy thong tin loai hang - ${LOAIID}`});
            }else{
                let KetQua = result.map(i =>({
                    "LOAIID": Number(i.LOAIID),
                    "LOAIMA": i.LOAIMA,
                    "LOAI_TEN": i.LOAI_TEN,
                    "GHI_CHU": i.GHI_CHU,
                    "SU_DUNG": i.SU_DUNG,
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa loai hang: ${err.message}`));
    }
}