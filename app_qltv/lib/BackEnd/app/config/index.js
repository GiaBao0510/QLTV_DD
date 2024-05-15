var mysql = require('mysql');

var config = mysql.createConnection({
    host: 'localhost',
    database: 'quanlytiemvang',
    port: '3306',
    user:"userB",
    password:'12345'
});

module.exports = config;