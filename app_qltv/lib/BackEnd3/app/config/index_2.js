var mysql = require('mysql');
var mysql2 = require('mysql2');

var db = mysql.createConnection({
    host: 'baokhoagold.ddns.net',
    port: '3306',
    database: 'QLTV1',
    user:"user_test",
    password:'12345'

    // database: 'quanlytiemvang',
    // port: '3307',
    // user:"test131",
    // password:'123123'

});

module.exports = db;