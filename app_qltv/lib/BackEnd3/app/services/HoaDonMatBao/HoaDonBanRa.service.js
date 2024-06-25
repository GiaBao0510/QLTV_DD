const thuvien = require('../../ThuVien');

//1. Lấy danh sách hóa đơn bán ra
const DanhSachHoaDon_SV = async () =>{
    return new Promise((resolve, reject) =>{
        db.query(
            `SELECT hd.Fkey, hd.ApiInvSerial MauSo, hd.InvNo SoHoaDon, hd.SO MaThamChieu,
                kh.MaKH, kh.Buyer TenKhachHang, kh.CusTaxCode MaSoThue, hd.Amount GiaTri,
                lhd.TenLoaiHoaDon LoaiHoaDon, hd.ArisingDate NgayTao 
            FROM Invoice hd INNER 
                JOIN InvoiceType lhd ON hd.InvType = lhd.InvType
                JOIN Client kh ON kh.MaKH = hd.MaKH`,
            (err, result)=>{
                if(err) reject(err);
                resolve(result);
            }
        );
    });
}

//2. Xóa hóa đơn nháp
const XoaHoaDonNhap = async(Fkey) =>{
    try{
        //Xóa bên chi tiết hóa đơn trước sao đó xóa
        await thuvien.queryDB(`DELETE FROM ChiTietHoaDonBanRa WHERE Fkey = "${Fkey}"`);

        //Xóa bên hóa đơn
        await thuvien.queryDB(`DELETE FROM Invoice WHERE Fkey = "${Fkey}"`);

        console.log(`Xóa thông tin dựa trên Fkey: "${Fkey}" - bên bảng chi tiết hóa đơn thành công`);
        console.log(`Xóa thông tin dựa trên Fkey: "${Fkey}" - bên bảng hóa đơn thành công`);
    }catch(err){
        console.log(`Lỗi: ${err.message}.`);
    }
}


module.exports = {
    DanhSachHoaDon_SV,
    XoaHoaDonNhap
};