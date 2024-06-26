const ThuVien = require('../../ThuVien');
const db  = require('../../config/index_2');

//Kiểm tra xem mã sản phẩm có tồn tại hay không
//Kiểm tra xem nếu mã sản phẩm tồn tại thì xem số lượng nó > 0 và SuDung == 1
const KiemTraMaHangHoa = async (HANGHOAMA) =>{
    try{
        //Kiểm tra mã hàng hóa có tồn tại hang không
        let KT_MaHangHoa = await ThuVien.queryDB(`SELECT * FROM danh_muc_hang_hoa WHERE HANGHOAMA="${HANGHOAMA}"`);
        if(KT_MaHangHoa.length === 0) throw Error("Mã hàng hóa không tồn tại.");

        //Kiểm tra số lượng tồn của hàng hóa
        let KT_HangTon = ThuVien.queryDB(`
            SELECT hh.HANGHOAMA , tk.SL_TON 
            FROM danh_muc_hang_hoa hh INNER JOIN ton_kho tk ON hh.HANGHOAID = tk.HANGHOAID 
            WHERE hh.HANGHOAMA="${HANGHOAMA}" AND hh.SU_DUNG =1 AND tk.SL_TON > 0
        `);
        if(KT_HangTon.length === 0) throw Error("Số lượng tồn không đủ để xuất kho.");

        //Hiển thị thông tin sản phẩm


    }catch(err){
        console.log(`Lỗi thêm hóa đơn: ${err.message}`);
        return {message: `Lỗi thêm hóa đơn: ${err.message}`};
    }
}

// Nếu > 0 ,thì thực hiện giao dịch
//Cập nhật lại số lượng hàng hóa dựa trên mã hàng trong bảng tồn kho
//Thêm thông tin vào phiếu xuất dựa trên hàng đã bán

module.exports={
    KiemTraMaHangHoa
}