var mysql = require('mysql');
// var mysql2 = require('mysql2');

// var db = mysql.createConnection({
//     host: 'baokhoagold.ddns.net',
//     database: 'QLTV1',
//     port: '3306',
//     user:"user_test",
//     password:'12345'

// });

// module.exports = db;

var fs = require('fs')
const test = JSON.parse(fs.readFileSync('./app/config/test.json','utf-8'));

var db = mysql.createConnection(test);

module.exports = db;