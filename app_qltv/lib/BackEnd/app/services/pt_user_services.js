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
            const rows = await connection.query(`SELECT * FROM ${this.PhanQuyenUser}`);
            const data = rows.map(row => ({ ...row }));
            const jsondata = JSON.stringify(data, null,2)
            console.log(jsondata);
            return jsondata;
        }catch(err){
            return [];
        }
    }
}

module.exports = pt_user_services;