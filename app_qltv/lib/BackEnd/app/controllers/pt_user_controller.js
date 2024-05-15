const ApiError = require('../api-error');
const pt_user_services = require('../services/pt_user_services');

    // GET
//1.Lấy danh sách phân quyền người dùng
exports.DSphanQuyen_user = async (req, res, next) =>{
    try{
        const ptUserServices = new pt_user_services();
        const result = await ptUserServices.DanhSachPhanQuyenNguoiDung();

        // Kiểm tra nếu kết quả là một mảng rỗng (không có dữ liệu)
        if (!result ||result.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy dữ liệu phân quyền người dùng' });
        }

        // Trả về kết quả dưới dạng JSON
        return res.status(202).json(result[0]);
    }catch(err){
        return next(new ApiError(500, `Loi xuat hien khi lay danh sách phan quyen nguoi dung: ${err.message}`));
    }
} 
