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
const { decode } = require('punycode');
const app = express();
const dbRoutes = require('./app/config/dbRoutes');

app.use(express.json());
app.use(cookieParser('quanlytiemvang'));
app.use(cors());

app.use(express.urlencoded({extended: true}));
app.use('/api/admin',admin);
app.use('/api/users', userRoutes);
app.use('/api/groups', groupRoutes);
app.use('/api/productType', productype);
app.use('/api/cam', cam);
app.use('/api/phieu',phieu);
app.use('/api/db', dbRoutes);

//Áp dụng cấu hình phiên
app.use(
    session({
        secret: 'somesecret',
        cookie: {maxAge:60000},
        resave:true,
        saveUninitialized:false,
    })
);

//Đăng nhập
app.post('/login', async (req, res, next) => {
    try{
        const {USER_TEN,MAT_KHAU} = req.body;
        
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
                
                //Nếu đăng nhập thành công thì lưu thông tin vào phiên
                req.session.authenticated = true;
                req.session.user = USER_TEN;

                //Tạo AccessToken và RefreshToken
                const accesstoken = jwt.sign({USER_TEN}, 'quanlytiemvang_shot', {expiresIn: '5h'}) ,
                    refreshtoken = jwt.sign({USER_TEN}, 'quanlytiemvang_long', {expiresIn:'14d'}) ;

                //Lưu thông tin vào cookie
                res.cookie('accessToken', accesstoken, {httpOnly: true,  maxAge: 18000000});
                res.cookie('refreshToken',refreshtoken,{httpOnly:true, maxAge: 1209600000});
                res.cookie('username', String(USER_TEN), {maxAge:3600000, secure: true});
                res.cookie('isLoggedIn',true, {maxAge:3600000, httpOnly:true, secure: true});
                
                const isLoggedIn = req.cookies.isLoggedIn;
                const username = req.cookies.username;
                const AccessToken = req.cookies.accessToken;
                const RefreshToken = req.cookies.refreshToken;

                return res.status(200).json({
                    message: `Đăng nhập thành công!` ,USER: username ,value:1, isLoggedIn: isLoggedIn,
                    data: {
                        accesstoken: AccessToken,
                        refreshtoken: RefreshToken
                    } ,
                    RefreshToken: RefreshToken
                });
            }
        });
        
    }catch(err){
        return next(new ApiError(500,`Loi khi thuc hien đăng nhập: ${err}`));
    }
});

//Làm mới Accesstoken, Khi mà Accesstoken hết hạn thì dựa vào RefreshToken để làm mới
app.post('/refresh-token', (req, res)=>{
    const refreshToken = req.cookies.refreshToken;
    let accessToken  = req.cookies.accessToken;

    //Kiểm tra xem AccessToken còn hiệu lực hay không ,Nếu hết thì làm mới
    if(!accessToken){
        //Kiểm tra luôn RefreshToken còn hiệu lực hay không ,Nếu hết đăng xuất
        if(!refreshToken){
            return res.status(403).json({
                mgs:'Hết hiệu lực - refreshToken', valid:0,
                data: {
                    accesstoken: accessToken,
                    refreshtoken: refreshToken
                } 
            });
        }
        //Ngược lại thì làm mới AccessToken
        else{
            jwt.verify(refreshToken,'quanlytiemvang_long', (err, decode)=> {
                if(err){
                    return res.status(403).json({
                        mgs:'Invalid refresh token', valid:0,
                        data: {
                            accesstoken: accessToken,
                            refreshtoken: refreshToken
                        } 
                    });
                }
        
                //Tạo AccessToken mới
                accessToken = jwt.sign({USER_TEN: decode.USER_TEN}, 'quanlytiemvang_shot', {expiresIn: '5h'} );
        
                //Gửi AccessToken mới
                res.cookie('accessToken', accessToken, {httpOnly: true,  maxAge: 18000000});
        
                return res.status(200).json({
                    mgs:'Access token has been refreshed!',valid:1,
                    data: {
                        accesstoken: accessToken,
                        refreshtoken: refreshToken
                    } 
                });
            });
        }
    }else{
        return res.status(203).json({
            mgs:'Còn hiệu lực - refreshToken', valid:1,
            data: {
                accesstoken: accessToken,
                refreshtoken: refreshToken
            } 
        });
    }
})

//Hủy phiên - đăng xuất
app.post('/exit', function(req, res,next ){
    try{
        //HỦy phiên
        req.session.destroy();

        //Xóa cookie
        res.clearCookie('username', {secure: true});
        res.clearCookie('isLoggedIn', {secure: true});
        res.clearCookie('accessToken', {secure: true});
        res.clearCookie('refreshToken', {secure: true});
        return res.status(200).json({message: "Hủy phiên thành công, Đăng xuất thành công"});
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