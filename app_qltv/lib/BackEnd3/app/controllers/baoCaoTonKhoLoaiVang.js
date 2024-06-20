var mysql = require('mysql');
var express = require('express');
var {db, db2} = require('../config/index_2');
var ApiError = require('../api-error');

exports.baoCaoTonKhoLoaiVang = async (req, res, next)=>{
    try{
        //Lấy theo từng tên loại vàng trước
        db.query(
            `
            SELECT DISTINCT nh.NHOM_TEN , nh.NHOMHANGID
            FROM nhom_hang nh
                INNER JOIN danh_muc_hang_hoa dmh on nh.NHOMHANGID = dmh.NHOMHANGID
                JOIN loai_hang lh ON lh.LOAIID = dmh.LOAIID
                JOIN ton_kho tk ON tk.HANGHOAID = dmh.HANGHOAID
            WHERE dmh.SU_DUNG="1" AND nh.SU_DUNG = 1 AND lh.SU_DUNG = 1 AND  tk.SL_TON = 1
            `,
            async (err, result1)=>{
                if(err){
                    return res.status(404).json({message: `Loi khi lấy thông tin danh sách hàng hóa theo từng loại vàng - ${err}`});
                }else{
                    //TÌm kiếm theo tên loại vàng
                    const TimKiemTheoNhom = (query, tenNhom) =>{
                        return new Promise((resolve, reject)=>{
                            db.query(query, (err, result)=>{
                                if(err){
                                    return res.status(404).json({message: `Loi khi thực hiện lấy thông tin loại vàng - ${tenNhom} - ERROR: ${err}`});
                                }
                                if(!result || result.length == 0){
                                    return res.status(404).json({message: `Loi khong tim thay ten loai vang ${tenNhom}.`});
                                }
                                resolve(result);
                                return result;
                            });
                        });
                    }

                    let MangKQ = [];
                    let tong_TLThuc = 0,
                        tong_TL_hot =0,
                        tong_TLvang=0,
                        tong_CongGoc=0,
                        tong_GiaCong=0,
                        tong_ThanhTien =0,
                        SoLuong=0;
                    //Lấy danh sách từng tên loại vàng
                    for(const item of result1) {
                        //console.log(item.NHOM_TEN);
                        let ketqua = await TimKiemTheoNhom(`
                            SELECT nh.NHOM_TEN, 
                                dmh.HANGHOAMA, 
                                dmh.HANG_HOA_TEN, 
                                lh.LOAI_TEN,
                                dmh.CAN_TONG, 
                                dmh.TL_HOT, 
                                (dmh.CAN_TONG - dmh.TL_HOT) AS TL_vang, 
                                dmh.CONG_GOC, 
                                dmh.GIA_CONG,
                                nh.DON_GIA_BAN AS DonGiaBan,
                                (nh.DON_GIA_BAN * 10 * ((dmh.CAN_TONG - dmh.TL_HOT) / 1000))+dmh.GIA_CONG AS ThanhTien 
                            FROM nhom_hang nh
                                INNER JOIN danh_muc_hang_hoa dmh ON nh.NHOMHANGID = dmh.NHOMHANGID
                                JOIN loai_hang lh ON lh.LOAIID = dmh.LOAIID
                                JOIN ton_kho tk ON tk.HANGHOAID = dmh.HANGHOAID
                            WHERE nh.NHOMHANGID = "${item.NHOMHANGID}" 
                                AND dmh.SU_DUNG = 1 
                                AND nh.SU_DUNG = 1 
                                AND lh.SU_DUNG = 1 
                                AND dmh.SO_LUONG > 0 
                                AND tk.SL_TON = 1
                            ORDER BY dmh.HANGHOAMA;    
                        `,item.NHOMHANGID);
                  
                        //Tính tổng
                        for(const item of ketqua){
                            nhomTen = item.NHOM_TEN;
                            tong_TLThuc += item.CAN_TONG;
                            tong_TL_hot +=item.TL_HOT;
                            tong_TLvang +=item.TL_vang;
                            tong_CongGoc +=item.CONG_GOC;
                            tong_GiaCong +=item.GIA_CONG;
                            tong_ThanhTien += item.ThanhTien;
                            SoLuong++;
                        }

                        var tinhTong = {
                            "NhomTen": nhomTen,
                            "SoLuong:": SoLuong,
                            "TongTL_Thuc":tong_TLThuc, 
                            "TongTL_hot": tong_TL_hot, 
                            "TongTL_Vang": tong_TLvang, 
                            "TongCongGoc": tong_CongGoc, 
                            "TongGiaCong":tong_GiaCong,
                            "TongThanhTien": tong_ThanhTien,
                        }

                        //Đặt lại số lượng về 0
                        SoLuong=0;
                        tong_TLThuc = 0;
                        tong_TL_hot =0;
                        tong_TLvang=0;
                        tong_CongGoc=0;
                        tong_GiaCong=0;
                        tong_ThanhTien =0;
                        SoLuong=0;

                        let ketQuaTungLoai = {
                            data: ketqua,
                            sumary: tinhTong
                        };

                        MangKQ.push(ketQuaTungLoai)
                    }
                    return res.status(200).json(MangKQ);
                }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hiện khi thực hiện truy vấn bao cáo hàng hóa theo loại vàng: ${err.message}`));
    }
};

exports.baoCaoTonKhoLoaiVang_TenLoaiVang = async (req, res, next)=>{
    try{
        const NHOM_TEN = req.params.NHOM_TEN;
        db.query(`
            SELECT nh.NHOM_TEN, dmh.HANGHOAMA, dmh.HANG_HOA_TEN, lh.LOAI_TEN,dmh.CAN_TONG, dmh.TL_HOT, (dmh.CAN_TONG -  dmh.TL_HOT) TL_vang, dmh.CONG_GOC, dmh.GIA_CONG 
            FROM nhom_hang nh
            INNER JOIN danh_muc_hang_hoa dmh on nh.NHOMHANGID = dmh.NHOMHANGID
            JOIN loai_hang lh ON lh.LOAIID = dmh.LOAIID
            WHERE nh.NHOM_TEN="${NHOM_TEN}" AND dmh.SU_DUNG="1"
        `,(err, result)=>{
            if(err){
                return res.status(400).json({message: `Loi khi thực hiện lấy thông tin loại vàng - ${NHOM_TEN} - ERROR: ${err}`});
            }
            if(!result || result.length == 0){
                return res.status(404).json({message: `Loi khong tim thay ten lọai vàng ${NHOM_TEN}.`});
            }

            let tong_TLThuc = 0,
                tong_TL_hot =0,
                tong_TLvang=0,
                tong_CongGoc=0,
                tong_GiaCong=0,
                SoLuong=0;

            for(const item of result){
                tong_TLThuc += item.CAN_TONG;
                tong_TL_hot +=item.TL_HOT;
                tong_TLvang +=item.TL_vang;
                tong_CongGoc +=item.CONG_GOC;
                tong_GiaCong +=item.GIA_CONG;
                SoLuong++;
            }

            return res.status(200).json({
                data:result,
                sumary:{
                    "Số lượng:": SoLuong,
                    "Tổng TL_Thực":tong_TLThuc, 
                    "Tổng TL_hột": tong_TL_hot, 
                    "Tổng TL_Vàng": tong_TLvang, 
                    "Tổng Công gốc": tong_CongGoc, 
                    "Tổng giá công":tong_GiaCong
                }
            });
        });

    }catch(err){
        return next(new ApiError(500, `Loi xuat hiện khi thực hiện truy vấn bao cáo hàng hóa theo loại vàng: ${err.message}`));
    }
};