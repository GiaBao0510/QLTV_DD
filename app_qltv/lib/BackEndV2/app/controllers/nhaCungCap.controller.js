var mysql = require('mysql');
var express = require('express');
var db = require('../config/index');

//1.Lấy danh sách thông tin nhà cung cấp 
exports.list_NhaCungCap = async (req, res, next) =>{
    try{

        db.query(`SELECT * FROM phn_nha_cung_cap`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi lấy danh sách thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin nhà cung cấp`});
            }else{
                let KetQua = results.map(result =>({
                    "NCCID": Number(result.NCCID),
                    "NCCMA": result.NCCMA,
                    "NCC_TEN": result.NCC_TEN,
                    "NGAYBD": new Date(result.NGAYBD),
                    "GHI_CHU": result.GHI_CHU,
                    "SU_DUNG": result.SU_DUNG
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy danh sách nhà cung cấp: ${err.message}`));
    }
}

//2. Lấy thông tin nhà cung cấp theo ID
exports.lay_NhaCungCap = async (req, res, next) =>{
    try{
        const NCCMA = req.params.NCCMA;
    
        db.query(`select * from phn_nha_cung_cap where NCCMA = "${NCCMA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi lấy thông tin nhà cung cấp - ${err}`);
                return res.status(404).json({message: `Loi khi lấy thong tin nhà cung cấp - ${NCCMA}`});
            }else{

                return res.status(200).json(result);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa nhà cung cấp: ${err.message}`));
    }
}