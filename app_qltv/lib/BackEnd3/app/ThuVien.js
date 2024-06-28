var db  = require('./config/index_2');

//Trả kết quả truy vấn
var queryDB = (query) =>{
    return new Promise((resolve, reject) => {
        db.query(query, (err, result)=>{
            if(err) reject(err);
            resolve(result);
        });
    });
};

//Trả kết quả sau khi thêm thông tin
var InsertUpdateDB = (query) =>{
    return new Promise((resolve, reject) => {
        db.query(query, (err, result)=>{
            if(err) reject(0);
            resolve(1);
        });
    });
};

module.exports = {
    queryDB, InsertUpdateDB
}