    //Kiểm tra khi thao tác với SQL
// var mysql = require('mysql');
// var con = mysql.createConnection({
//     "host": "baokhoagold.ddns.net",
//     "database": "QLTV1",
//     "port": "3306",
//     "user": "user_test",
//     "password": "12345"
// });

// con.connect(function(err){
//     if(err) throw err;
//     con.query(`SELECT COUNT(*) SoLuong FROM Invoice`, function(err, result){
//         if(err) throw err;
//         console.log(result)
//         console.log(result[0].SoLuong)
//     });
// });

    //Kiểm tra bình thường
    let ngay = new Date().getDate(),
    thang = new Date().getMonth()+1,
    nam = new Date().getFullYear(),
    gio = new Date().getHours(),
    phut = new Date().getMinutes(),
    giay = new Date().getSeconds(),
    miligiay = new Date().getMilliseconds();
let chuoi = String(ngay) +String(thang) +String(nam) 
        +String(gio) + String(phut) + String(giay) 
        + String(miligiay);

    //Tạo 1 chuỗi random 4 ký tự 
    let StringRandom = (Math.random()+1).toString(36).substring(4).slice(0,4);
    let fkey = StringRandom+chuoi;
console.log(fkey)
