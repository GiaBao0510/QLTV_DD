var mysql = require('mysql');

// module.exports = db;

var fs = require('fs')
const test = JSON.parse(fs.readFileSync('./app/config/test.json','utf-8'));

var db = mysql.createConnection(test);

module.exports = db;