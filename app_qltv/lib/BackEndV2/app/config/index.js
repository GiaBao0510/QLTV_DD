var mysql = require('mysql');

var db = mysql.createConnection({
    host: 'localhost',
    database: 'tiemvang',
    port: '3306',
    user:"root",
    password:''
});

module.exports = db;