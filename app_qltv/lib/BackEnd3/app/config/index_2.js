var mysql = require('mysql');
var mysql2 = require('mysql2');

var db = mysql.createConnection({
    host: 'localhost',
<<<<<<< HEAD
    database: 'tiemvang',
    port: '3306',
    user:"root",
    password:''
    // database: 'quanlytiemvang',
    // port: '3307',
    // user:"test131",
    // password:'123123'
=======
    port: '3306',
    user:"root",
    database: 'quanlytiemvang',
    port: '3306',
    user:"userB",
    password:'12345'
>>>>>>> e1c9a31e674a16c8981d8647ced1fb858751f30e
});

module.exports = db;