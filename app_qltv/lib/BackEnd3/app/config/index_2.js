var mysql = require('mysql');

var db = mysql.createConnection({
    host: 'localhost',
    database: 'quanlytiemvang',
    port: '3306',
    user:"test",
    password:'123123'
});

module.exports = db;