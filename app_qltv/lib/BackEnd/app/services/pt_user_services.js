var bcrypt = require('bcrypt');
const db = require('../config/index');
const { connection } = require('../../server');

class pt_user_services{
    //khởi tao
    constructor(){
        this.PhanQuyenUser = "pq_user";
    }

    //Tạo người dùng


    //Lấy danh sách phân quyền người dùng
    async DanhSachPhanQuyenNguoiDung(){
        try{
            const [rows] = await connection.query(`SELECT * FROM ${this.PhanQuyenUser}`);
            console.log(rows); 
            return [rows];
        }catch(err){
            return 0;
        }
    }
}

module.exports = pt_user_services;