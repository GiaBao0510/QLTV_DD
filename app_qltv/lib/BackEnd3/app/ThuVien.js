var db  = require('./config/index_2');

var queryDB = (query) =>{
    return new Promise((resolve, reject) => {
        db.query(query, (err, result)=>{
            if(err) reject(err);
            resolve(result);
        });
    });
};

module.exports = {
    queryDB,
}