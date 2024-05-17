var mysql = require('mysql');

var db = mysql.createConnection({
    host: 'localhost',
<<<<<<< HEAD:app_qltv/lib/BackEndV2/app/config/index.js
    database: 'tiemvang',
    port: '3306',
    user:"root",
    password:''
=======
    database: 'quanlytiemvang',
    port: '3307',
    user:"test131",
    password:'123123'
>>>>>>> 5a882bfeafd538d51e13b11670677c27c0c34ef5:app_qltv/lib/BackEnd3/app/config/index_2.js
});

module.exports = db;