var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
var ApiError = require('../api-error');

exports.baoCaoTonKhoTheoNhom = async (req, res, next)=>{
    try{
        //Lấy theo từng tên nhóm trước
        db.query(
            `SELECT DISTINCT lh.LOAI_TEN FROM loai_hang lh 
            INNER JOIN danh_muc_hang_hoa dmh on lh.LOAIID = dmh.LOAIID
            order by lh.LOAI_TEN`,
            async (err, result1)=>{
                if(err){
                    return res.status(404).json({message: `Loi khi lấy thông tin danh sách hàng hóa theo từng nhóm - ${err}`});
                }else{
                    //TÌm kiếm theo tên nhóm
                    const TimKiemTheoNhom = (query, tenNhom) =>{
                        return new Promise((resolve, reject)=>{
                            db.query(query, (err, result)=>{
                                if(err){
                                    return res.status(404).json({message: `Loi khi thực hiện lấy thông tin nhóm - ${tenNhom} - ERROR: ${err}`});
                                }
                                if(!result || result.length == 0){
                                    return res.status(404).json({message: `Loi khong tim thay ten nhom ${tenNhom}.`});
                                }
                                resolve(result);
                                return result;
                            });
                        });
                    }

                    let MangKQ = [];
                    //Lấy danh sách từng tên nhóm
                    for(const item of result1) {
                        //console.log(item.LOAI_TEN);
                        let ketqua = await TimKiemTheoNhom(`
                            SELECT lh.LOAIID, dmh.HANGHOAMA, dmh.HANG_HOA_TEN, dmh.CAN_TONG, dmh.TL_HOT, (dmh.CAN_TONG -  dmh.TL_HOT) TL_vang, dmh.CONG_GOC, dmh.GIA_CONG  
                            FROM loai_hang lh 
                            INNER JOIN danh_muc_hang_hoa dmh on lh.LOAIID = dmh.LOAIID
                            WHERE lh.LOAI_TEN="${item.LOAI_TEN}" AND dmh.SU_DUNG=1
                        `,item.LOAI_TEN);
                        Array.prototype.push.apply(MangKQ, ketqua);
        
                    }
                    return res.status(200).json(MangKQ);
                }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hiện khi thực hiện truy vấn bao cáo hàng hóa theo nhóm: ${err.message}`));
    }
};

exports.baoCaoTonKhoTheoNhom_TenNhom = async (req, res, next)=>{
    try{
        const LOAI_TEN = req.params.LOAI_TEN;
        db.query(`
            SELECT lh.LOAI_TEN, dmh.HANGHOAMA, dmh.HANG_HOA_TEN, dmh.CAN_TONG, dmh.TL_HOT, (dmh.CAN_TONG -  dmh.TL_HOT) TL_vang, dmh.CONG_GOC, dmh.GIA_CONG  
            FROM loai_hang lh 
            INNER JOIN danh_muc_hang_hoa dmh on lh.LOAIID = dmh.LOAIID
            WHERE lh.LOAI_TEN="${LOAI_TEN}" AND dmh.SU_DUNG=1
        `,(err, result)=>{
            if(err){
                return res.status(404).json({message: `Loi khi thực hiện lấy thông tin nhóm - ${LOAI_TEN} - ERROR: ${err}`});
            }
            if(!result || result.length == 0){
                return res.status(404).json({message: `Loi khong tim thay ten nhom ${LOAI_TEN}.`});
            }
            return res.status(200).json(result);
        });

    }catch(err){
        return next(new ApiError(500, `Loi xuat hiện khi thực hiện truy vấn bao cáo hàng hóa theo nhóm: ${err.message}`));
    }
};