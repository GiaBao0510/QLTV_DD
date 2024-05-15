var mysql = require('mysql');

var con = mysql.createConnection({
    host: 'localhost',
    user:"userB",
    password:'12345'
});

con.connect(function(err){
    if(err) throw err;
    console.log('ket noi duoc');
})