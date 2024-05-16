var mysql = require('mysql');
var express = require('express');
var app = require('./app');
var db = require('./app/config/index');

async function startServer(){
    try{
        //Kiểm tra kết nối đến csdl
        await db.connect((err)=>{
            if(err){
                console.log(`Lỗi khi kết nối ${err}`);
                process.exit();
            }else{
                console.log(`Đã kết nối được cơ sở dữ liệu!!`);
            }
        });

        await app.listen(3000, (err)=>{
            if(err){
                console.log(`Lỗi khi lắng nghe ${err}`);
                process.exit();
            }else{
                console.log(`Đang hoạt động trên cổng 3000`);
            }
        });

    }catch(err){
        console.log(`Kết nối đến cơ sở dữ liệu thất bại ${err}`);
        process.exit();
    }
}

startServer();