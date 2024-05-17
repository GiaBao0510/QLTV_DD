var mysql = require('mysql');

var db = mysql.createConnection({
    host: 'localhost',
    database: 'quanlytiemvang',
    port: '3306',
    user:"userB",
    password:'12345'
});

module.exports = db;