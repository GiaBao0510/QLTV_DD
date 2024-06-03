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
        var token = req.cookies.refreshToken;
        console.log('- Token: ',token);
        var InforUser = jwt.verify(token,process.env.REFRESH_TOKEN)
        const id = InforUser['_id'];
        console.log('- id: ',id);
        console.log('- inforUser',InforUser);
        const KT = await TruyVan_ID_NguoiDung(id);
        
        if(!KT || KT.length == 0 ){
            console.log('Không có quyền truy cập. Phần ID');
            return res.status(400).json({message: "Bạn không có quyền truy cập", valid: 0});
        }
        console.log('Có quyền truy cập');
        next();
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
    const autHeader = req.headers['Cookie'];
    console.log('- xác thực Token: ',autHeader);
    const token = autHeader && autHeader.split(' ')[1];
    console.log(token)
    if(token == null) return res.status(401).json({message: "Token không được cấp"});
    jwt.verify(token, process.env.ACCESS_TOKEN, (err, user) =>{
        if(err) return res.status(403).json({message: 'Token không hợp lệ'});
        req.user = user;
        next();
    });
};

module.exports = {
    TruyVan_ID_NguoiDung,
    CheckLogin,
    KiemTraHieuLucCuaToken,
    DangXuat,
    authenticationToken,
}