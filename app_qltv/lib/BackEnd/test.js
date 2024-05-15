var mysql = require('mysql');

var con = mysql.createConnection({
    host: 'localhost',
    database: 'quanlytiemvang',
    user:"userB",
    password:'12345'
});


//Kiểm tra kết nối
con.connect(function(err){
    if(err) throw err;
    console.log('ket noi duoc');

    const PhanQuyenUser = "pq_user";
    //Truy xuất
    var sql =`SELECT * FROM ${PhanQuyenUser}`;
    con.query(sql, function(err, result, fields){
        if(err) throw err;
        console.log(result);
    });
})

// --------
const ktraham = require('./app/services/pt_user_services');
const ktraham1 = new ktraham();
ktraham1.DanhSachPhanQuyenNguoiDung();