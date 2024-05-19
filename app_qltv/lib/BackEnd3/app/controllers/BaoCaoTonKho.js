var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
var ApiError = require('../api-error');

exports.baoCaoTonKho = async (req, res, next)=>{
    try{
        db.query(`
            SELECT nh.NHOM_TEN, COUNT(nh.NHOM_TEN) SoLuong ,sum(dmh.CAN_TONG) TL_Thuc, sum(dmh.TL_HOT) TL_hot, sum((dmh.CAN_TONG -  dmh.TL_HOT)) TL_vang, sum(dmh.CONG_GOC) CONG_GOC, sum(dmh.GIA_CONG) GIA_CONG 
            FROM nhom_hang nh
            INNER JOIN danh_muc_hang_hoa dmh on nh.NHOMHANGID = dmh.NHOMHANGID
            JOIN loai_hang lh ON lh.LOAIID = dmh.LOAIID
            WHERE dmh.SU_DUNG="1"
            GROUP BY nh.NHOM_TEN
        `,(err, result)=>{
            if(err){
                return res.status(400).json({message: `Loi khi thực hiện lấy thông tin báo cáo tồn kho  - ERROR: ${err}`});
            }
            if(!result || result.length == 0){
                return res.status(404).json({message: `Loi khi thực hiện lấy thông tin báo cáo tồn kho.`});
            }

            return res.status(200).json(result);
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hiện khi thực hiện truy vấn bao cáo tồn kho: ${err.message}`));
    }
};