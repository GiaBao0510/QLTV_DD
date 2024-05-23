const express = require('express');
const session = require('express-session');
const cors = require('cors');
const os = require('os');
const bcrypt = require('bcrypt');
const ApiError = require('./app/api-error')
const db = require('./app/config/index_2');
const admin = require('./app/routers/admin.router');
const userRoutes = require('./app/routers/userRoutes');
const groupRoutes = require ('./app/routers/groupRoutes');
const productype = require('./app/routers/productTypeRoute');
const cam = require ('./app/routers/camvangRoute');
const phieu = require ('./app/routers/phieuRoute')
const app = express();
app.use(express.json());

app.use(cors());
app.use(express.urlencoded({extended: true}));
app.use('/api/admin',admin);
app.use('/api/users', userRoutes);
app.use('/api/groups', groupRoutes);
app.use('/api/productType', productype);
app.use('/api/cam', cam);
app.use('/api/phieu',phieu);

//Áp dụng cấu hình phiên
app.use(
    session({
        secret: 'somesecret',
        cookie: {maxAge:60000},
        resave:true,
        saveUninitialized:false
    })
);

//Đăng nhập
app.post('/login', async (req, res, next) => {
    try{
        const {USER_TEN, MAT_KHAU} = req.body;
        
        //Tìm tài khoán có khớp không
        db.query(`select * from pq_user where USER_TEN="${USER_TEN}"`,async (err, result)=>{
            if(err){
                return res.status(400).json({message: `Lỗi khi tìm USER_TEN: ${USER_TEN} `});
            }else if(!result || result.length == 0){
                return res.status(400).json({message: `Tài khoản không tồn tại ${USER_TEN}`,value:-1});
            }else{
                const MatKhauDaBam = result[0].MAT_KHAU;
                
                //So sánh mật khẩu
                const kqSoSanh = await bcrypt.compare(MAT_KHAU, MatKhauDaBam);
                if(!kqSoSanh){
                    return res.status(400).json({message: `Mật khẩu không hợp lệ`, value:0});
                }
                
                //Nếu đăng nhập thành công thì lưu thông tin
                req.session.authenticated = true;
                req.session.user = USER_TEN;
                req.session.password = MatKhauDaBam;
                req.secure.code = 'GOOD_REQUEST';
                return res.status(200).json({message: `Đăng nhập thành công!` ,USER: USER_TEN ,PASS_WORD: MatKhauDaBam ,value:1});
            }
        });
        
    }catch(err){
        return next(new ApiError(500,`Loi khi thuc hien đăng nhập: ${err}`));
    }
});

//Hủy phiên - đăng xuất
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