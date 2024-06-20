var mysql = require('mysql');

// module.exports = db;

var fs = require('fs')
const test = JSON.parse(fs.readFileSync('./app/config/test.json','utf-8'));
const hoadonmatbao = JSON.parse(fs.readFileSync('./app/config/hoadonmatbao.json', 'utf-8'));

var db = mysql.createConnection(test);
var db2 = mysql.createConnection(hoadonmatbao);

module.exports = {
    db, db2
};