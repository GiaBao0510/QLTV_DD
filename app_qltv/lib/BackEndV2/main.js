var mysql = require('mysql');
var express = require('express');
var app = express();

app.use(express.json());

var connect = mysql.createConnection({
    host: 'localhost',
    database: 'quanlytiemvang',
    port: '3306',
    user:"userB",
    password:'12345'
});

//Kiểm tra kết nối
connect.connect((err)=>{
    if(err){
        console.log(`Lỗi khi kết nối ${err}`);
        process.exit();
    }else{
        console.log(`Đã kết nối!!`);
    }
})

app.post('/loaihang',(req, res)=>{
    const LOAIMA = req.body.LOAIMA,
        LOAI_TEN = req.body.LOAI_TEN,
        GHI_CHU = req.body.GHI_CHU;
    
    connect.query('insert into loai_hang(LOAIMA,LOAI_TEN,GHI_CHU) values(?,?,?)',[LOAIMA,LOAI_TEN,GHI_CHU],(err, result)=>{
        if(err){
            console.log(`Lỗi khi gửi thông tin loại hàng - ${err}`);
            process.exit();
        }else{
            res.send(`POSTED`);
        }
    })
})

app.listen(3000, (err)=>{
    if(err){
        console.log(`Lỗi khi lắng nghe ${err}`);
        process.exit();
    }else{
        console.log(`Đang hoạt động trên cổng 3000`);
    }
})