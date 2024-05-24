var mysql = require('mysql');
// var mysql2 = require('mysql2');

var db = mysql.createConnection({

    host: 'baokhoagold.ddns.net',
    database: 'QLTV1',
    port: '3306',
    user:"user_test",
    password:'12345'

});

module.exports = db;