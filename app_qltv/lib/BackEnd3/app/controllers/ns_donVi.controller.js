var mysql = require('mysql');
var express = require('express');
var db= require('../config/index_2');
var ApiError = require('../api-error');

//1. danh sách thông tin kho
exports.list_nsDonVi = async (req, res, next) =>{
    try{
        const page = parseInt(req.query.page) || 1;
        const pageSize = parseInt(req.query.pageSize) || 10;
        const offset = (page - 1) * pageSize;
        db.query(`SELECT COUNT(*) as total FROM ns_don_vi where SU_DUNG="1"`,(countErr, countResult)=>{
            if(countErr){
                console.log(`Lỗi khi lấy danh sách thông tin Đơn vị - ${countErr}`);
                return res.status(404).json({message: `Loi khi lấy danh sách thong tin  Đơn vị`});
            }
            const totalRows = countResult[0].total;
            const totalPages = Math.ceil(totalRows / pageSize);

            db.query(`SELECT * FROM ns_don_vi WHERE SU_DUNG = 1 LIMIT ${pageSize} OFFSET ${offset}`, (err, result) => {
                if (err) {
                    console.log(`Error retrieving customer list - ${err}`);
                    return res.status(500).json({ error: "Error retrieving customer list" });
                }
            else{
                let KetQua = countResult.map(result =>({
                    "DON_VI_ID": String(result.DON_VI_ID),
                    "DON_VI_MA": result.DON_VI_MA,
                    "DON_VI_TEN": result.DON_VI_TEN,
                    "SU_DUNG": result.SU_DUNG,
                    "GHI_CHU": result.GHI_CHU,
                    "DON_VI_TEN_HD": result.DON_VI_TEN_HD,
                    "DIA_CHI_HD": result.DIA_CHI_HD,
                    "DIEN_THOAI": result.DIEN_THOAI,
                    "TEN_GIAO_DICH": result.TEN_GIAO_DICH,
                    "TAO_LUU_Y": result.TAO_LUU_Y,
                    "TIEU_DE_PHIEU_CAM": result.TIEU_DE_PHIEU_CAM,
                    "TIEU_DE_PHIEU_BAN": result.TIEU_DE_PHIEU_BAN,
                    "GIOI_THIEU": result.GIOI_THIEU,
                }));
                return res.status(200).json(
                    {
                        data: result,
                        page,
                        totalPages,
                        totalRows 
                    }
                );}
            });
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy danh sách  Đơn vị: ${err.message}`));
    }
}

//2. lấy thông tin kho theo ID
exports.lay_nsDonVi= async (req, res, next) =>{
    try{
        const DON_VI_MA = req.params.DON_VI_MA;
    
        db.query(`select * from ns_don_vi where DON_VI_MA = "${DON_VI_MA}" AND SU_DUNG="1"`,(err, results)=>{
            if(err){
                console.log(`Không tìm thấy thông tin đơn vị - ${err}`);
                return res.status(404).json({message: `Loi khong tin thay thong tin don vi - ${DON_VI_MA}`});
            }else{
                let KetQua = results.map(result =>({
                    "DON_VI_ID": String(result.DON_VI_ID),
                    "DON_VI_MA": result.DON_VI_MA,
                    "DON_VI_TEN": result.DON_VI_TEN,
                    "SU_DUNG": result.SU_DUNG,
                    "GHI_CHU": result.GHI_CHU,
                    "DON_VI_TEN_HD": result.DON_VI_TEN_HD,
                    "DIA_CHI_HD": result.DIA_CHI_HD,
                    "DIEN_THOAI": result.DIEN_THOAI,
                    "TEN_GIAO_DICH": result.TEN_GIAO_DICH,
                    "TAO_LUU_Y": result.TAO_LUU_Y,
                    "TIEU_DE_PHIEU_CAM": result.TIEU_DE_PHIEU_CAM,
                    "TIEU_DE_PHIEU_BAN": result.TIEU_DE_PHIEU_BAN,
                    "GIOI_THIEU": result.GIOI_THIEU,
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi tìm thong tin don vi: ${err.message}`));
    }
}

//3.Thêm thông tin ns_don_vi
exports.Add_nsDonVi= async (req, res, next) =>{
    try{
        let DON_VI_TEN= req.body.DON_VI_TEN,
            SU_DUNG= 1,
            GHI_CHU= req.body.GHI_CHU,
            DON_VI_TEN_HD= req.body.DON_VI_TEN_HD,
            DIA_CHI_HD= req.body.DIA_CHI_HD,
            DIEN_THOAI= req.body.DIEN_THOAI,
            TEN_GIAO_DICH= req.body.TEN_GIAO_DICH,
            TAO_LUU_Y= req.body.TAO_LUU_Y,
            TIEU_DE_PHIEU_CAM= req.body.TIEU_DE_PHIEU_CAM,
            TIEU_DE_PHIEU_BAN= req.body.TIEU_DE_PHIEU_BAN,
            GIOI_THIEU= req.body.GIOI_THIEU;
    
        //Thêm trước mớ thông tin ngoại trừ ID và mã NCC
        db.query(` insert into ns_don_vi(DON_VI_TEN,SU_DUNG,GHI_CHU,DON_VI_TEN_HD,DIA_CHI_HD,DIEN_THOAI,TEN_GIAO_DICH,TAO_LUU_Y,TIEU_DE_PHIEU_CAM,TIEU_DE_PHIEU_BAN,GIOI_THIEU) 
                values(?,?,?,?,?,?,?,?,?,?,?)`
                ,[DON_VI_TEN,SU_DUNG,GHI_CHU,DON_VI_TEN_HD,DIA_CHI_HD,DIEN_THOAI,TEN_GIAO_DICH,TAO_LUU_Y,TIEU_DE_PHIEU_CAM,TIEU_DE_PHIEU_BAN,GIOI_THIEU],(err, result)=>{
            if(err){
                console.log(`Lỗi khi gửi thông tin đơn vị - ${err}`);
                return res.status(404).json({message: `Loi khi gui thong tin đơn vị`});
            }else{

                //lấy ID cuối
                db.query("SELECT DON_VI_ID FROM ns_don_vi ORDER BY DON_VI_ID DESC LIMIT 1",(err, result)=> {
                    if(err){
                        console.log(`Lỗi khi lấy ID cuối thông tin đơn vị - ${err}`);
                        return res.status(404).json({message: `Loi khi lấy ID cuối thong tin đơn vị`});
                    }else{
                        let IDcuoi = Number(result[0].DON_VI_ID);

                        //Chuyển ID cuối về chuỗi
                        const IDchuoi = String(IDcuoi);
                        
                        db.query(`update ns_don_vi set DON_VI_MA="${IDchuoi}" where DON_VI_ID = "${IDcuoi}"`, (err, results)=>{
                            if (err) {
                                console.log(`Lỗi khi cập nhật DON_VI_MA của kho - ${err}`);
                                return res.status(404).json({message: `Loi khi cập nhật DON_VI_MA của đơn vị`});
                            } else {
                                return res.status(200).json({message: `Thêm thong tin đơn vị thanh cong, ID: ${IDcuoi}`});
                            }
                        })
                    }
                })
            }
        });
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi them kho: ${err.message}`));
    }
}

//4. xóa thông tin đơn vị
exports.delete_nsDonVi= async (req, res, next) =>{
    try{
        const DON_VI_MA = req.params.DON_VI_MA;
    
        db.query(`update ns_don_vi set SU_DUNG="0" where DON_VI_MA = "${DON_VI_MA}"`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi xóa thông tin kho - ${err}`);
                return res.status(404).json({message: `Loi Không tìm thấy thông tin đơn vị để xóa - ${DON_VI_MA}`});
            }else{
                
                return res.status(200).json({message: `xóa thong tin đơn vị thanh cong- ${DON_VI_MA}`});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa đơn vị: ${err.message}`));
    }
}

//5. sửa thông tin kho
exports.Update_nsDonVi= async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let DON_VI_MA = req.params.DON_VI_MA;
        DON_VI_MA = String(DON_VI_MA);

        //Thông tin sửa
        let DON_VI_TEN= req.body.DON_VI_TEN,
            SU_DUNG= 1,
            GHI_CHU= req.body.GHI_CHU,
            DON_VI_TEN_HD= req.body.DON_VI_TEN_HD,
            DIA_CHI_HD= req.body.DIA_CHI_HD,
            DIEN_THOAI= req.body.DIEN_THOAI,
            TEN_GIAO_DICH= req.body.TEN_GIAO_DICH,
            TAO_LUU_Y= req.body.TAO_LUU_Y,
            TIEU_DE_PHIEU_CAM= req.body.TIEU_DE_PHIEU_CAM,
            TIEU_DE_PHIEU_BAN= req.body.TIEU_DE_PHIEU_BAN,
            GIOI_THIEU= req.body.GIOI_THIEU;
    
        db.query(`update ns_don_vi
                set DON_VI_TEN="${DON_VI_TEN}", SU_DUNG="${SU_DUNG}" , GHI_CHU="${GHI_CHU}" , DON_VI_TEN_HD="${DON_VI_TEN_HD}" 
                , DIA_CHI_HD="${DIA_CHI_HD}" , DIEN_THOAI="${DIEN_THOAI}" , TEN_GIAO_DICH="${TEN_GIAO_DICH}" , TAO_LUU_Y="${TAO_LUU_Y}" 
                , TIEU_DE_PHIEU_CAM="${TIEU_DE_PHIEU_CAM}" , TIEU_DE_PHIEU_BAN="${TIEU_DE_PHIEU_BAN}", GIOI_THIEU="${GIOI_THIEU}"
                where DON_VI_MA="${DON_VI_MA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi không tìm thất mã đơn vị để cập nhật - ${err}`);
                return res.status(404).json({message: `Không tìm thấy ID đơn vị`});
            }else{

                return res.status(200).json({message: `cập nhật thong tin đơn vị thanh cong ,ID: ${DON_VI_MA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi cap nhat thong tin đơn vị: ${err.message}`));
    }
}