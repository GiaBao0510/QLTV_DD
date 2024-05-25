var mysql = require('mysql');
// var mysql2 = require('mysql2');

var db = mysql.createConnection({
    host: 'baokhoagold.ddns.net',
    database: 'QLTV1',
    port: '3306',
    user:"user_test",
    password:'12345'

    // host: 'localhost',
    // database: 'tiemvang',
    // port: '3306',
    // user:"root",
    // password:''

    // database: 'quanlytiemvang',
    // port: '3307',
    // user:"test131",
    // password:'123123'

    // port: '3306',
    // database: 'quanlytiemvang',
    // user:"userB",
    // password:'12345'

});

module.exports = db;