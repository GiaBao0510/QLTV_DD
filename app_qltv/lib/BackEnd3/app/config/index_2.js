var mysql = require('mysql');
// var mysql2 = require('mysql2');

var db = mysql.createConnection({
<<<<<<< HEAD
    host: 'baokhoagold.ddns.net',
    database: 'QLTV1',
    port: '3306',
    user:"user_test",
    password:'12345'
=======
<<<<<<< HEAD
    host: 'baokhoagold.ddns.net',
    port: '3306',
    database: 'QLTV1',
    user:"user_test",
    password:'12345'
=======
    host: 'localhost',
    database: 'tiemvang',
    port: '3306',
    user:"root",
    password:''
>>>>>>> c196fd6ce376b1c9053d01ac4c0fb90c39e7831b

    // database: 'quanlytiemvang',
    // port: '3307',
    // user:"test131",
    // password:'123123'
>>>>>>> e243481d3d181a0b3704a52453a24b96bccfe6c2

});

module.exports = db;