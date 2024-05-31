const express = require('express');
const session = require('express-session');
const cors = require('cors');
const os = require('os');
const bcrypt = require('bcrypt');
const cookieParser = require('cookie-parser');
const jwt =require('jsonwebtoken');

const ApiError = require('./app/api-error')
const db = require('./app/config/index_2');
const admin = require('./app/routers/admin.router');
const userRoutes = require('./app/routers/userRoutes');
const groupRoutes = require ('./app/routers/groupRoutes');
const productype = require('./app/routers/productTypeRoute');
const cam = require ('./app/routers/camvangRoute');
const phieu = require ('./app/routers/phieuRoute');
const kiemtra =require('./app/services/KiemTra.servie');
const { decode } = require('punycode');
const app = express();

require('dotenv').config();

app.use(express.json());
app.use(cookieParser('quanlytiemvang'));
app.use(cors({
    origin: '*',            //Cho phép CORS có thể xử lý bất kỳ tên miền nào ,Nên đặt địa chỉ ứng dụng thay vì "*", vì đây tiềm ẩn nhiều nguy cơ bảo mật
    credentials: true,     //Cho phép nhận cookie cùng với yêu cầu cors. Điều này giúp xác thực người dùng
}));

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
        cookie: {maxAge:3600000},
        resave: true,
        saveUninitialized:false,
    })
);

//Đăng nhập
app.post('/login', async (req, res, next) => {
    try{

        const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null);

        //--- Phần này dành cho đăng nhập ghi thông tin
        const {USER_TEN,MAT_KHAU} = req.body;   //Lấy thông tin đầu vào
        
        //Tìm tài khoán có khớp không
        db.query(`select * from pq_user where USER_TEN="${USER_TEN}"`,async (err, result)=>{
            if(err){
                return res.status(400).json({message: `Lỗi khi tìm USER_TEN: ${USER_TEN} `});
            }else if(!result || result.length == 0){
                return res.status(400).json({message: `Tài khoản không tồn tại ${USER_TEN}`,value:-1});
            }else{
                const MatKhauDaBam = result[0].MAT_KHAU;
                const userID = result[0].USER_ID;
                
                //So sánh mật khẩu
                const kqSoSanh = await bcrypt.compare(MAT_KHAU, MatKhauDaBam);
                if(!kqSoSanh){
                    return res.status(400).json({message: `Mật khẩu không hợp lệ`, value:0});
                }
                
                  // Lưu thông tin vào phiên
                req.session.authenticated = true;
                req.session.user = USER_TEN;

                // Tạo AccessToken và RefreshToken
                const accessToken = jwt.sign({ user: USER_TEN, _id: userID }, process.env.ACCESS_TOKEN, { expiresIn: '1h' }),
                    refreshToken = jwt.sign({ user: USER_TEN, _id: userID }, process.env.REFRESH_TOKEN, { expiresIn: '7d' });

                // Lưu thông tin vào cookie
                res.cookie('accessToken', accessToken, { httpOnly: true, maxAge: 3600000 });
                res.cookie('refreshToken', refreshToken, { httpOnly: true, maxAge: 604800000 });
                

                //Trả thông tin thông báo đăng nhập thành công
                console.log("Đăng nhập thành công");
                console.log('USER: ',USER_TEN);
                console.log('accessToken: ',accessToken);
                console.log('refreshToken: ',USER_TEN);
                console.log('ipV4Address: ',ip);
                return res.status(200).json({
                    message: 'Đăng nhập thành công!',
                    USER: USER_TEN,
                    value: 1,
                    isLoggedIn: true,
                    data: {
                      accessToken: accessToken,
                      refreshToken: refreshToken
                    },
                    accessToken: accessToken,
                });
            }
        });
        
    }catch(err){
        return next(new ApiError(500,`Loi khi thuc hien đăng nhập: ${err}`));
    }
});

//Làm mới Accesstoken, Khi mà Accesstoken hết hạn thì dựa vào RefreshToken để làm mới
app.post('/refresh-token', kiemtra.KiemTraHieuLucCuaToken);

//Hủy phiên - đăng xuất
app.post('/exit', kiemtra.DangXuat);

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