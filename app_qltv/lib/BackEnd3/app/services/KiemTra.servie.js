const { json } = require('body-parser');
const cookieParser = require('cookie-parser');
const express = require('express');
var mysql = require('mysql');
var db = require('../config/index_2');
var ApiError = require('../api-error');
const jwt =require('jsonwebtoken');

//Kiểm tra xem tài khoản còn hiệu lực
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

// >>>> Kiểm tra đăng nhập
var CheckLogin = async (req, res, next)=>{
    try{
        var token = req.cookies.refreshToken;
        //console.log('Token: ',token);
        var InforUser = jwt.verify(token,process.env.REFRESH_TOKEN)
        const id = InforUser['_id'];
        //console.log('id: ',id);
        const KT = await TruyVan_ID_NguoiDung(id);
        
        if(!KT || KT.length == 0 ){
            return res.status(400).json({message: "Bạn không có quyền truy cập", valid: 0});
        }
        console.log('Có quyền truy cập');
        next();
    }catch(err){
        console.log('Không có quyền truy cập');
        return res.status(403).json({message: "Token không hợp lệ", valid: 0});
    }
} 

module.exports = {
    TruyVan_ID_NguoiDung,
    CheckLogin,
}