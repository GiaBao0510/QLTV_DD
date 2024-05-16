var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
const ApiError = require('../api-error');

//1.Thêm loại hàng
exports.Add_LoaiHang = async (req, res, next) =>{
    try{
        const LOAIMA = req.body.LOAIMA,
        LOAI_TEN = req.body.LOAI_TEN,
        GHI_CHU = req.body.GHI_CHU,
        SU_DUNG = req.body.SU_DUNG;
    
        db.query('insert into loai_hang(LOAIMA,LOAI_TEN,GHI_CHU,SU_DUNG) values(?,?,?,?)',[LOAIMA,LOAI_TEN,GHI_CHU,SU_DUNG],(err, result)=>{
            if(err){
                console.log(`Lỗi khi gửi thông tin loại hàng - ${err}`);
                return res.status(404).json({message: `Loi khi gui thong tin loai hang`});
            }else{
                return res.status(200).json({message: `gui thong tin loai hang thanh cong`});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them loai hang: ${err.message}`));
    }
}

//2.Xóa loại hàng dựa trên ID loại hàng
exports.Delete_LoaiHang = async (req, res, next) =>{
    try{
        const LOAIID = req.params.LOAIID;
    
        db.query(`delete from loai_hang where LOAIID = "${LOAIID}"`,(err, result)=>{
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
    
        db.query(`SELECT * FROM loai_hang`,(err, results)=>{
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
    
        db.query(`select * from loai_hang where LOAIID = "${LOAIID}"`,(err, result)=>{
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