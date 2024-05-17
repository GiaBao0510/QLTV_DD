//Tạo 1 lớp dùng để thông báo lỗi kế thừ từ lớp Error
class ApiError extends Error{
    //Hàm khởi tạo
    constructor(status ,message){
        super();
        this.message = message;
        this.status = status;
    }
}

module.exports = ApiError; //Xuất vào module để có thể sử dụng