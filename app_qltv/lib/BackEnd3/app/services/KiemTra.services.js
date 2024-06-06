const { json } = require('body-parser');
const cookieParser = require('cookie-parser');
const express = require('express');
var mysql = require('mysql');
var db = require('../config/index_2');
var ApiError = require('../api-error');
const jwt =require('jsonwebtoken');

//0. Kiểm tra xem tài khoản còn hiệu lực
const TruyVan_ID_NguoiDung = async (iduser) =>{
    return new Promise((resolve, reject) => {
        db.query(`select * from pq_user where USER_ID="${iduser}"`,(err, result) => {
            if(err){
                reject(err);
            }
            if(!result || result.length == 0){
                reject({message: `Loi khong tim thay ID người dùng ${iduser}.`});
            }
            resolve(result);
        });
    });
};

//1. Kiểm tra đăng nhập
const CheckLogin = async (req, res, next)=>{
    try{
        //
        console.log("\n\t------ Kiểm tra đăng nhập ------- ");

        var tokenOnHeader = req.headers['accesstoken'];  //Lấy token trên Headers
        var tokenOnCookie = req.cookies['accessToken']; //Lấy token trên cookies
        var Token = tokenOnCookie || tokenOnHeader;

        //ĐK 1: Lấy accesstoken trên phần header và kiểm tra xem phần này nếu trống thì trả về không có token
        
        if(Token == null) return res.status(400).json({message: "Token không được cấp", valid: 0});
        console.log(' - AccessToken in Cookies or Headers: ',Token);

        jwt.verify(Token,process.env.ACCESS_TOKEN ,async (err, decoded) => {
            
            //ĐK 2: Nếu xuất hiện lỗi thì báo Token không hợp lệ
            if(err){
                return res.status(401).json({message: "Token không hợp lệ", valid: 0});
            }
            let InforUser = decoded;
            console.log(" - InforUser: ",decoded);
            const id = InforUser['_id'];
            const expire = InforUser['exp']* 1000;
            const current = new Date().getTime();
            const HetHan = new Date(expire),
                HienTai = new Date(current);
            console.log('- id: ',id);
            console.log('- HienTai: ',HienTai.toLocaleString('vi-VN'));
            console.log('- HetHan: ',HetHan.toLocaleString('vi-VN'));
           
            //ĐK 3: Nếu Token hết hạn thì không cho đăng nhập
            if(HetHan < HienTai) return res.status(402).json({message: "Token không hợp lệ", valid: 0});

            //ĐK 4: Truy vấn Nếu không tìm thấy ID người dùng thì trả về không đăng nhập
            const KT = await TruyVan_ID_NguoiDung(id);
            if(!KT || KT.length == 0 ){
                console.log('Không có quyền truy cập. Phần ID');
                return res.status(400).json({message: "Bạn không có quyền truy cập", valid: 0});
            }
            console.log('Có quyền truy cập');
            next();
        });
        
        
    }catch(err){
        console.log('Không có quyền truy cập');
        return res.status(403).json({message: "Token không hợp lệ", valid: 0});
    }
}

//2. Kiểm tra hiệu lực của các Token
const KiemTraHieuLucCuaToken = async(req, res) => {
    const accessToken = req.cookies.accessToken,
            refreshToken = req.cookies.refreshToken;
    
    //Kiểm tra xem nếu accessToken hết hiệu lực thì làm mới
    if(!accessToken){
        //Kiểm tra xem nếu refreshToken hết hiệu lực thì phải đăng nhập lại
        if(!refreshToken){
            return res.status(403).json({
                message:"Hết hiệu lực refresh Token",
                data:{
                    accesstoken: accessToken,
                    refreshtoken: refreshToken
                }
            });
        }else{
            //Ngươc lại thì làm mới accessToken
            jwt.verify(refreshToken, process.env.REFRESH_TOKEN, (err, decode) =>{
                if(err){
                    return res.status(503).json({
                        message:"Hết hiệu lực refresh Token",
                        data:{
                            accesstoken: accessToken,
                            refreshtoken: refreshToken
                        },
                        err: err
                    });
                }

                //Tạo accessToken mới
                accessToken = jwt.sign({ user: decode.USER_TEN, _id: decode.userID}, process.env.ACCESS_TOKEN, {expiresIn: '1h'});
                res.cookie('accessToken', accessToken, {httpOnly: true, maxAge: 3600000});

                return res.status(200).json({
                    message:"Đã làm mới accessToken, còn hiệu lực",
                    data:{
                        accesstoken: accessToken,
                        refreshtoken: refreshToken
                    }
                });
            });
        }
    }else{
        return res.status(203).json({
            message:"AccessToken còn hiệu lực",
            data:{
                accesstoken: accessToken,
                refreshtoken: refreshToken
            }
        });
    }
}

//3. Thực hiện đăng xuất
const DangXuat = async(req, res) =>{
    try{
        req.session.destroy();
        //Xóa cookie
        res.clearCookie('username', {secure: true});
        res.clearCookie('isLoggedIn', {secure: true});
        res.clearCookie('accessToken', {secure: true});
        res.clearCookie('refreshToken', {secure: true});
        console.log(' \t Đăng xuất thành công ');
        return res.status(200).json({message: "Hủy phiên thành công, Đăng xuất thành công"});
    }catch(err){
        return res.status(500).json({
            message:"Đăng xuất thất bại - phía server",
            Error: err
        });
    }
}

//4. Xác thực Token
const authenticationToken = async (req, res, next) =>{
    const Authorization = String(req.headers['authorization']).trim();
    console.log('- xác thực Token hiện tại:',Authorization);
    if(Authorization == null) return res.status(401).json({message: "Token không được cấp"});
    jwt.verify(Authorization, process.env.ACCESS_TOKEN, (err, user) =>{
        if(err) return res.status(403).json({message: 'Token không hợp lệ'});
        req.user = user;
        console.log('- Có quyền truy cập');
        next();
    });
    //next();
};

module.exports = {
    TruyVan_ID_NguoiDung,
    CheckLogin,
    KiemTraHieuLucCuaToken,
    DangXuat,
    authenticationToken,
}