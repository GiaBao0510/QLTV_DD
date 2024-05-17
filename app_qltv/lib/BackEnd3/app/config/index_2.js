var mysql = require('mysql');

var db = mysql.createConnection({
    host: 'localhost',
    database: 'tiemvang',
    port: '3306',
    user:"root",
    password:''
    // database: 'quanlytiemvang',
    // port: '3307',
    // user:"test131",
    // password:'123123'
});

module.exports = db;