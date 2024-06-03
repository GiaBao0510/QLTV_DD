var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
var ApiError = require('../api-error');

exports.baoCaoTonKho = async (req, res, next)=>{
    try{
        db.query(`
            SELECT nh.NHOM_TEN, COUNT(tk.SL_TON) SoLuong ,
            sum(dmh.CAN_TONG) TL_Thuc, 
            sum(dmh.TL_HOT) TL_hot, 
            sum((dmh.CAN_TONG -  dmh.TL_HOT)) TL_vang, 
            sum(dmh.CONG_GOC) CONG_GOC, 
            sum(dmh.GIA_CONG) GIA_CONG, 
            nh.DON_GIA_BAN DonGiaBanLoaiVang, 
            (nh.DON_GIA_BAN*10 * (sum((dmh.CAN_TONG -  dmh.TL_HOT))/1000 ) )+sum(dmh.GIA_CONG) as ThanhTien
                    FROM danh_muc_hang_hoa dmh
                    INNER JOIN nhom_hang nh  on nh.NHOMHANGID = dmh.NHOMHANGID
                    JOIN loai_hang lh ON lh.LOAIID = dmh.LOAIID
                    JOIN ton_kho tk ON tk.HANGHOAID = dmh.HANGHOAID
                    WHERE dmh.SU_DUNG=1 AND nh.SU_DUNG=1 AND lh.SU_DUNG=1 AND dmh.SO_LUONG>0 AND tk.SU_DUNG=1 AND tk.SL_TON=1
                    GROUP BY nh.NHOM_TEN
        `,(err, result)=>{
            if(err){
                return res.status(400).json({message: `Loi khi thực hiện lấy thông tin báo cáo tồn kho  - ERROR: ${err}`});
            }
            if(!result || result.length == 0){
                return res.status(404).json({message: `Loi khi thực hiện lấy thông tin báo cáo tồn kho.`});
            }
            //let Tong = {"TongThong":"thoidi"};
            return res.status(200).json(result);
        });
    }catch(err){
        return next(new ApiError(500, `Loi ben server: ${err.message}`));
    }
};