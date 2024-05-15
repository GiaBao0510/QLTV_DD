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

    //Truy xuất
    var sql ="SELECT * FROM pq_user";
    con.query("SELECT * FROM pq_user", function(err, result, fields){
        if(err) throw err;
        console.log(result);
    });
})