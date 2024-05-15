const app = require('./app');
const db = require("./app/config/index");

let connection;
async function startServer(){
    try{
        //Kiểm tra kết nối nến cơ sở dữ liệu
        connection = await db.connect();
        console.log('Kết nối đến MySQL thành công');

        //Lắng nghe trên cổng 8080
        const PORT = 8080; 
        app.listen(PORT, ()=>{
            console.log(`Server is running on port ${PORT}`);
        });
    }catch(err){
        console.log(`Kết nối đến cơ sở dữ liệu thất bại ${err}`);
        process.exit();
    }
}

startServer();

module.exports = {connection};