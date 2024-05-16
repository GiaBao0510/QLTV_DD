const app = require('./app');
var mysql = require('mysql');
var express = require('express');
const userService = require('./app/services/userService');
var db = require('./app/config/index_2');

const PORT = process.env.PORT || 3000;


// // Sử dụng userService
// userService.getUserById(1)
//   .then(user => console.log(user))
//   .catch(error => console.error(error));

// userService.getAllUsers()
//   .then(users => console.log(users))
//   .catch(error => console.error(error));
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

      await app.listen(PORT, (err)=>{
          if(err){
              console.log(`Lỗi khi lắng nghe ${err}`);
              process.exit();
          }else{
              console.log(`Đang hoạt động trên cổng ${PORT}`);
          }
      });

  }catch(err){
      console.log(`Kết nối đến cơ sở dữ liệu thất bại ${err}`);
      process.exit();
  }
}

startServer();