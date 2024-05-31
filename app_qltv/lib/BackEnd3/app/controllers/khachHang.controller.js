var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');

//Thêm khách hàng
exports.Add_khachHang = async(req, res, next) =>{
    try {
        const KH_TEN = req.body.KH_TEN,
            CMND = req.body.CMND,
            DIEN_THOAI = req.body.DIEN_THOAI,
            DIA_CHI = req.body.DIA_CHI,
            SU_DUNG = 1,
            GHI_CHU = req.body.GHI_CHU;

        // Thêm thông tin người dùng trước
        db.query("insert into phx_khach_hang(KH_TEN, CMND, DIEN_THOAI, DIA_CHI, SU_DUNG, GHI_CHU) values(?,?,?,?,?,?)", [KH_TEN, CMND, DIEN_THOAI, DIA_CHI, SU_DUNG, GHI_CHU], (err, result) => {
            if (err) {
                console.log(`Lỗi khi thêm thông tin khach hàng - ${err}`);
                return res.status(404).json({message: `Loi khi thêm thong tin khach hang`});
            }

            // Lấy ID người dùng cuối
            db.query("SELECT KH_ID FROM phx_khach_hang ORDER BY KH_ID DESC LIMIT 1", (err, result) => {
                if (err) {
                    console.log(`Lỗi khi lấy ID cuối của khach hàng - ${err}`);
                    return res.status(404).json({message: `Loi khi lấy ID cuối của khach hang`});
                } else {
                    let IDcuoi = Number(result[0].KH_ID);  // Sử dụng let thay vì const

                    // Chuyển về kiểu chuỗi
                    const IDchuoi = String(IDcuoi);

                    // Cập nhật thêm vào bảng
                    db.query(`update phx_khach_hang set KH_MA = "${IDchuoi}" where KH_ID = "${IDcuoi}"`, (err, result) => {
                        if (err) {
                            console.log(`Lỗi khi cập nhật KH_MA của khach hàng - ${err}`);
                            return res.status(404).json({message: `Loi khi cập nhật KH_MA của khach hang`});
                        } else {
                            return res.status(200).json({message: `Thêm thong tin khach hang thanh cong, ID: ${IDcuoi}`});
                        }
                    });
                }
            });
        });
    } catch (err) {
        return next(new ApiError(500, `Loi xuat hien khi them nhan vien: ${err.message}`));
    }
}

//2. xóa thông tin khách hàng
exports.Delete_KhachHang = async (req, res, next) =>{
    try{
        let KH_MA = req.params.KH_MA;
        KH_MA = String(KH_MA);
    
        db.query(`update phx_khach_hang set SU_DUNG="0" where KH_MA = "${KH_MA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin khách hàng - ${err}`);
                return res.status(404).json({message: `Loi khi xóa thong tin khách hang`});
            }else{

                return res.status(200).json({message: `xóa thong tin khách hang thanh cong ,ID: ${KH_MA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa khach hang: ${err.message}`));
    }
}

//3. sửa thông tin khách hàng
exports.Update_KhachHang = async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let KH_MA = req.params.KH_MA;
        KH_MA = String(KH_MA);

        //Thông tin sửa
        const KH_TEN = req.body.KH_TEN,
            CMND = req.body.CMND,
            DIEN_THOAI = req.body.DIEN_THOAI,
            DIA_CHI = req.body.DIA_CHI,
            SU_DUNG = req.body.SU_DUNG,
            GHI_CHU = req.body.GHI_CHU;
    
        db.query(`update phx_khach_hang
                set KH_TEN="${KH_TEN}", CMND="${CMND}", DIEN_THOAI="${DIEN_THOAI}", DIA_CHI="${DIA_CHI}", SU_DUNG="${SU_DUNG}", GHI_CHU="${GHI_CHU}" 
                where KH_MA="${KH_MA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi cập nhật thông tin khách hàng - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin khách hang`});
            }else{

                return res.status(200).json({message: `cập nhật thong tin khách hang thanh cong ,ID: ${KH_MA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa khach hang: ${err.message}`));
    }
}

//4.Lấy danh sách thông tin khách hàng 
exports.list_KhachHang = async (req, res, next) =>{
    try{
        db.query(`SELECT * FROM phx_khach_hang where SU_DUNG="1"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi lấy danh sách thông tin khách hàng - ${err}`);
                return res.status(404).json({message: `Loi khi cập nhật thong tin khách hang`});
            }else{

                return res.status(200).json(result);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy danh sách khách hang: ${err.message}`));
    }
}

//5. Lấy thông tin khách hàng theo ID
exports.lay_KhachHang = async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let KH_MA = req.params.KH_MA;
        KH_MA = String(KH_MA);
    
        db.query(`select * from phx_khach_hang  where KH_MA="${KH_MA}" AND SU_DUNG="1"`,(err, result)=>{
            if(err){
                console.log(`Lỗi khi lấy thông tin khách hàng - ${err}`);
                return res.status(404).json({message: `Loi khi lấy thong tin khách hang - ${KH_MA}`});
            }else{
                return res.status(200).json(result);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy thông tin khách hang: ${err.message}`));
    }
}