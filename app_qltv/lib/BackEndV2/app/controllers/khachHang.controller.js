var mysql = require('mysql');
var express = require('express');
var db = require('../config/index');

//Thêm khách hàng
exports.Add_khachHang = async(req, res, next) =>{
    try{
        const KH_TEN = req.body.KH_TEN,
                CMND = req.body.CMND,
                DIEN_THOAI = req.body.DIEN_THOAI,
                DIA_CHI = req.body.DIA_CHI,
                SU_DUNG = req.body.SU_DUNG,
                GHI_CHU = req.body.GHI_CHU;
         
        db.query("insert into phx_khach_hang(KH_TEN, CMND, DIEN_THOAI, DIA_CHI, SU_DUNG, GHI_CHU) values(?,?,?,?,?,?)",[KH_TEN, CMND, DIEN_THOAI, DIA_CHI, SU_DUNG, GHI_CHU], (err, result)=>{
            if(err){
                console.log(`Lỗi khi thêm thông tin khach hàng - ${err}`);
                return res.status(404).json({message: `Loi khi thêm thong tin khach hang`});
            }else{
                return res.status(200).json({message: `thêm thong tin khach hang thanh cong`});
            }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them nhan vien: ${err.message}`));
    }
}
