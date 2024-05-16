//Thêm module
const express = require('express');
const session = require('express-session');
const cors = require('cors');
const os = require('os');

const db = require('./app/config/index');
const admin = require('./app/routers/admin.router');
const apiError = require('./api-error');
var bodyParser = require('body-parser');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use('/admin',admin);

//Áp dụng cấu hình phiên
app.use(
    session({
        secret: 'somesecret',
        cookie: {maxAge:60000},
        resave:true,
        saveUninitialized:false
    })
);

//Hủy phiên
app.post('/exit', function(res, req){
    try{
        req.session.destroy();
        return res.status(200).json({message: "Hủy phiên thành công"});
    }catch(err){
        return next(new ApiError(500,`Loi khi thuc hien huy phien: ${err}`));
    }
});

//Xử lý lỗi từ máy khách
app.use((req, res, next) =>{
    return next(new ApiError(404, 'Resource not found!' ));
});

//Xử lý lỗi từ phía máy chủ
app.use((err, req, res, next)=>{
    return res.status(err.statusCode || 500).json({
        message: err.message || 'Internal server error!',
    });
});


module.exports = app;