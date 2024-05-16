var mysql = require('mysql');
var express = require('express');
var db = require('../config/index');

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