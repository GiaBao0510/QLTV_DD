var mysql = require('mysql');
var express = require('express');
var db = require('../config/index_2');
var ApiError = require('../api-error');
const e = require('express');

//1. danh sách thông tin kho
exports.list_hangHoa = async (req, res, next) =>{
    try{

        db.query(`SELECT * FROM danh_muc_hang_hoa`,(err, results)=>{
            if(err){
                console.log(`Lỗi khi lấy danh sách thông tin hàng hóa - ${err}`);
                return res.status(404).json({message: `Loi khi lấy danh sách thong tin  hàng hóa`});
            }else{
                let KetQua = results.map(result =>({
                    "HANGHOAID": Number(result.HANGHOAID),
                    "HANGHOAMA": result.HANGHOAMA,
                    "LOAIID": result.LOAIID,
                    "DVTID" : result.DVTID,
                    "NHOMHANGID": result.NHOMHANGID,
                    "NCCID": result.NCCID,
                    "GIAM_GIA_ID": result.GIAM_GIA_ID,
                    "HANG_HOA_TEN": result.HANG_HOA_TEN,
                    "GIA_BAN": result.GIA_BAN,
                    "VAT": result.VAT,
                    "THUE": result.THUE,
                    "SU_DUNG": result.SU_DUNG,
                    "DANH_DAU": result.DANH_DAU,
                    "SL_IN": result.SL_IN,
                    "GHI_CHU": result.GHI_CHU,
                    "TAO_MA": result.TAO_MA,
                    "GIA_BAN_SI": result.GIA_BAN_SI,
                    "CAN_TONG": result.CAN_TONG,
                    "TL_HOT": result.TL_HOT,
                    "GIA_CONG": result.GIA_CONG,
                    "DON_GIA_GOC": result.DON_GIA_GOC,
                    "CONG_GOC": result.CONG_GOC,
                    "TUOI_BAN": result.TUOI_BAN,
                    "TUOI_MUA": result.TUOI_MUA,
                    "XUAT_XU": result.XUAT_XU,
                    "KY_HIEU": result.KY_HIEU,
                    "NGAY": new Date(result.NGAY),
                    "SO_LUONG": Number(result.SO_LUONG)
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lấy danh sách  hàng hóa: ${err.message}`));
    }
}

//2. lấy thông tin kho theo ID
exports.lay_hangHoa= async (req, res, next) =>{
    try{
        const HANGHOAMA = req.params.HANGHOAMA;
    
        db.query(`select * from danh_muc_hang_hoa where HANGHOAMA = "${HANGHOAMA}"`,(err, results)=>{
            if (err) {
                console.log(`Lỗi khi truy vấn thông tin hàng hóa - ${err}`);
                return res.status(500).json({ message: `Lỗi khi truy vấn thông tin hàng hóa` });
            }
            else if(!results || results.length === 0) {
                console.log(`Không tìm thấy thông tin hàng hóa - ${HANGHOAMA}`);
                return res.status(404).json({ message: `Lỗi không tìm thấy thông tin hàng hóa - ${HANGHOAMA}` });
            }else{
                let KetQua = results.map(result =>({
                    "HANGHOAID": Number(result.HANGHOAID),
                    "HANGHOAMA": result.HANGHOAMA,
                    "LOAIID": result.LOAIID,
                    "DVTID" : result.DVTID,
                    "NHOMHANGID": result.NHOMHANGID,
                    "NCCID": result.NCCID,
                    "GIAM_GIA_ID": result.GIAM_GIA_ID,
                    "HANG_HOA_TEN": result.HANG_HOA_TEN,
                    "GIA_BAN": result.GIA_BAN,
                    "VAT": result.VAT,
                    "THUE": result.THUE,
                    "SU_DUNG": result.SU_DUNG,
                    "DANH_DAU": result.DANH_DAU,
                    "SL_IN": result.SL_IN,
                    "GHI_CHU": result.GHI_CHU,
                    "TAO_MA": result.TAO_MA,
                    "GIA_BAN_SI": result.GIA_BAN_SI,
                    "CAN_TONG": result.CAN_TONG,
                    "TL_HOT": result.TL_HOT,
                    "GIA_CONG": result.GIA_CONG,
                    "DON_GIA_GOC": result.DON_GIA_GOC,
                    "CONG_GOC": result.CONG_GOC,
                    "TUOI_BAN": result.TUOI_BAN,
                    "TUOI_MUA": result.TUOI_MUA,
                    "XUAT_XU": result.XUAT_XU,
                    "KY_HIEU": result.KY_HIEU,
                    "NGAY": new Date(result.NGAY),
                    "SO_LUONG": Number(result.SO_LUONG)
                }));
                return res.status(200).json(KetQua);
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi tìm thong tin don vi: ${err.message}`));
    }
}

//3.Thêm thông tin danh_muc_hang_hoa
exports.Add_hangHoa = async (req, res, next) => {
    try {
        const {
            LOAIID, DVTID, NHOMHANGID, NCCID, GIAM_GIA_ID, HANG_HOA_TEN, GIA_BAN, VAT, THUE,
            SU_DUNG, DANH_DAU, SL_IN, GHI_CHU, TAO_MA, GIA_BAN_SI, CAN_TONG, TL_HOT, GIA_CONG,
            DON_GIA_GOC, CONG_GOC, TUOI_BAN, TUOI_MUA, XUAT_XU, KY_HIEU, NGAY, SO_LUONG
        } = req.body;

        // Tìm kiếm các ID để đảm bảo tồn tại
        const checkExistence = (query, id, table) => {
            return new Promise((resolve, reject) => {
                db.query(query, [id], (err, result) => {
                    if (err) {
                        return reject(`Lỗi khi truy vấn thông tin: ${err}`);
                    }
                    if (!result || result.length == 0) {
                        return reject(`Không tìm thấy thông tin - ${id} - ${table}`);
                    }
                    resolve(true);
                });
            });
        };

        try {
            await checkExistence(`SELECT * FROM loai_hang WHERE LOAIID = ?`, LOAIID, "loai_hang");
            //await checkExistence(`SELECT * FROM ns_don_vi WHERE DON_VI_ID = ?`, DVTID, "ns_don_vi");
            await checkExistence(`SELECT * FROM nhom_hang WHERE NHOMHANGID = ?`, NHOMHANGID, "nhom_hang");
            await checkExistence(`SELECT * FROM phn_nha_cung_cap WHERE NCCID = ?`, NCCID, "phn_nha_cung_cap");
        } catch (error) {
            console.log(error);
            return res.status(404).json({ message: error });
        }

        // Thêm hàng hóa
        db.query(
            `INSERT INTO danh_muc_hang_hoa (LOAIID, DVTID, NHOMHANGID, NCCID, GIAM_GIA_ID, HANG_HOA_TEN, GIA_BAN, VAT, THUE, SU_DUNG, DANH_DAU, SL_IN, GHI_CHU, TAO_MA, GIA_BAN_SI, CAN_TONG, TL_HOT, GIA_CONG, DON_GIA_GOC, CONG_GOC, TUOI_BAN, TUOI_MUA, XUAT_XU, KY_HIEU, NGAY, SO_LUONG) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [LOAIID, DVTID, NHOMHANGID, NCCID, GIAM_GIA_ID, HANG_HOA_TEN, GIA_BAN, VAT, THUE, SU_DUNG, DANH_DAU, SL_IN, GHI_CHU, TAO_MA, GIA_BAN_SI, CAN_TONG, TL_HOT, GIA_CONG, DON_GIA_GOC, CONG_GOC, TUOI_BAN, TUOI_MUA, XUAT_XU, KY_HIEU, NGAY, SO_LUONG],
            (err, result) => {
                if (err) {
                    console.log(`Lỗi khi gửi thông tin hàng hóa - ${err}`);
                    return res.status(500).json({ message: `Lỗi khi gửi thông tin hàng hóa` });
                }

                // Lấy ID cuối cùng
                db.query("SELECT HANGHOAID FROM danh_muc_hang_hoa ORDER BY HANGHOAID DESC LIMIT 1", (err, result) => {
                    if (err) {
                        console.log(`Lỗi khi lấy ID cuối thông tin hàng hóa - ${err}`);
                        return res.status(500).json({ message: `Lỗi khi lấy ID cuối thông tin hàng hóa` });
                    }
                    const IDcuoi = result[0].HANGHOAID;
                    const IDchuoi = String(IDcuoi);

                    db.query(`UPDATE danh_muc_hang_hoa SET HANGHOAMA = ? WHERE HANGHOAID = ?`, [IDchuoi, IDcuoi], (err, results) => {
                        if (err) {
                            console.log(`Lỗi khi cập nhật HANGHOAMA của hàng hóa - ${err}`);
                            return res.status(500).json({ message: `Lỗi khi cập nhật HANGHOAMA của hàng hóa` });
                        }

                        return res.status(200).json({ message: `Thêm thông tin hàng hóa thành công, ID: ${IDcuoi}` });
                    });
                });
            }
        );
    } catch (err) {
        return next(new ApiError(500, `Lỗi xuất hiện khi thêm hàng hóa: ${err.message}`));
    }
};

//4. xóa thông tin hàng hóa
exports.delete_hangHoa= async (req, res, next) =>{
    try{
        const HANGHOAMA = req.params.HANGHOAMA;

        //Đầu tiên tìm mã hàng hóa có tồn tại không
        db.query(`select * from danh_muc_hang_hoa where HANGHOAMA = "${HANGHOAMA}"`,(err, results)=>{
            if (err) {
                console.log(`Lỗi khi truy vấn thông tin hàng hóa - ${err}`);
                return res.status(500).json({ message: `Lỗi khi truy vấn thông tin hàng hóa` });
            }
            else if(!results || results.length === 0) {
                console.log(`Không tìm thấy thông tin hàng hóa - ${HANGHOAMA}`);
                return res.status(404).json({ message: `Lỗi không tìm thấy thông tin hàng hóa - ${HANGHOAMA}` });
            }else{
                db.query(`update danh_muc_hang_hoa set SU_DUNG="0" where HANGHOAMA = "${HANGHOAMA}"`,(err, results)=>{
                    if (err) {
                        console.log(`Lỗi khi xóa thông tin hàng hóa - ${err}`);
                        return res.status(500).json({ message: `Lỗi khi xóa thông tin hàng hóa` });
                    }
                    else{
                        return res.status(202).json({ message: `Xóa thông tin hàng hóa thành công - ${HANGHOAMA}` });
                    }
                });
            }
        });    

    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi xóa hàng hóa: ${err.message}`));
    }
}

//5. sửa thông tin kho
exports.Update_hangHoa= async (req, res, next) =>{
    try{
        //Thông tin truy vẫn
        let HANGHOAMA = req.params.HANGHOAMA;
        HANGHOAMA = String(HANGHOAMA);

        //Phần thông tin từ body
        const {
            LOAIID, DVTID, NHOMHANGID, NCCID, GIAM_GIA_ID, HANG_HOA_TEN, GIA_BAN, VAT, THUE,
            SU_DUNG, DANH_DAU, SL_IN, GHI_CHU, TAO_MA, GIA_BAN_SI, CAN_TONG, TL_HOT, GIA_CONG,
            DON_GIA_GOC, CONG_GOC, TUOI_BAN, TUOI_MUA, XUAT_XU, KY_HIEU, NGAY, SO_LUONG
        } = req.body;

        // Tìm kiếm các ID để đảm bảo tồn tại
        const checkExistence = (query, id, table) => {
            return new Promise((resolve, reject) => {
                db.query(query, [id], (err, result) => {
                    if (err) {
                        return reject(`Lỗi khi truy vấn thông tin: ${err}`);
                    }
                    if (!result || result.length == 0) {
                        return reject(`Không tìm thấy thông tin - ${id} - ${table}`);
                    }
                    resolve(true);
                });
            });
        };

        try {
            await checkExistence(`SELECT * FROM loai_hang WHERE LOAIID = ?`, LOAIID, "loai_hang");
            await checkExistence(`SELECT * FROM nhom_hang WHERE NHOMHANGID = ?`, NHOMHANGID, "nhom_hang");
            await checkExistence(`SELECT * FROM phn_nha_cung_cap WHERE NCCID = ?`, NCCID, "phn_nha_cung_cap");
        } catch (error) {
            console.log(error);
            return res.status(404).json({ message: error });
        }
    
        //Thực hiện cập nhật
        db.query(`update danh_muc_hang_hoa
                set LOAIID="${LOAIID}", DVTID="${DVTID}", NHOMHANGID="${NHOMHANGID}", NCCID="${NCCID}",
                    GIAM_GIA_ID="${GIAM_GIA_ID}", HANG_HOA_TEN="${HANG_HOA_TEN}", GIA_BAN="${GIA_BAN}", VAT="${VAT}",
                    THUE="${THUE}", SU_DUNG="${SU_DUNG}", DANH_DAU="${DANH_DAU}", SL_IN="${SL_IN}",
                    GHI_CHU="${GHI_CHU}", TAO_MA="${TAO_MA}", GIA_BAN_SI="${GIA_BAN_SI}", CAN_TONG="${CAN_TONG}",
                    TL_HOT="${TL_HOT}", GIA_CONG="${GIA_CONG}", DON_GIA_GOC="${DON_GIA_GOC}", CONG_GOC="${CONG_GOC}",
                    TUOI_BAN="${TUOI_BAN}", TUOI_MUA="${TUOI_MUA}", XUAT_XU="${XUAT_XU}", KY_HIEU="${KY_HIEU}",
                    NGAY="${NGAY}", SO_LUONG="${SO_LUONG}"
                where HANGHOAMA="${HANGHOAMA}"`,(err, result)=>{
            if(err){
                console.log(`Lỗi không tìm thất mã hàng hóa để cập nhật - ${err}`);
                return res.status(404).json({message: `Không tìm thấy ID hàng hóa`});
            }else{
                return res.status(200).json({message: `cập nhật thong tin hàng hóa thanh cong ,ID: ${HANGHOAMA} `});
            }
        })
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi cap nhat thong tin hàng hóa: ${err.message}`));
    }
}