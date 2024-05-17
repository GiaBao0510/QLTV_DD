const {MySQLClient} = require('mysql');

class MySQL{
    //Biến này dùng để kết nối đến MongoDB thông qua uri. Truyền vào
    static connect = async (uri)=>{
        if(this.client) return this.client;
        this.client  = await MySQLClient.con;
        return this.client;
    }
}

module.exports = MySQL;