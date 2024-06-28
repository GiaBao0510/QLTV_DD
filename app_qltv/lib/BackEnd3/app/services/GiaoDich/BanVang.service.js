const ThuVien = require('../../ThuVien');
const db  = require('../../config/index_2');

//Kiểm tra xem mã sản phẩm có tồn tại hay không
const KiemTraMaHangHoa = async (HANGHOAMA) =>{
    try{
        //Kiểm tra mã hàng hóa có tồn tại hang không
        let KT_MaHangHoa = await ThuVien.queryDB(`SELECT * FROM danh_muc_hang_hoa WHERE HANGHOAMA="${HANGHOAMA}"`);
        if(KT_MaHangHoa.length === 0) throw Error("Mã hàng hóa không tồn tại.");

        //Kiểm tra số lượng tồn của hàng hóa
        let KT_HangTon = await ThuVien.queryDB(`
            SELECT hh.HANGHOAMA , tk.SL_TON 
            FROM danh_muc_hang_hoa hh INNER JOIN ton_kho tk ON hh.HANGHOAID = tk.HANGHOAID 
            WHERE hh.HANGHOAMA="${HANGHOAMA}" AND hh.SU_DUNG =1 AND tk.SL_TON > 0
        `);
        if(KT_HangTon.length === 0) throw Error("Số lượng tồn không đủ để xuất kho.");

        //Hiển thị thông tin sản phẩm
        let ThongTinHangHoa = await ThuVien.queryDB(`
            SELECT hh.HANGHOAID, nh.NHOMHANGID, hh.HANGHOAMA MA, hh.HANG_HOA_TEN TEN_HANG, l.LOAI_TEN LOAIVANG, nh.NHOM_TEN,
                hh.CAN_TONG, hh.TL_HOT, (hh.CAN_TONG - hh.TL_HOT) TRU_HOT, 
                hh.GIA_CONG, hh.DON_GIA_GOC, nh.DON_GIA_BAN, COUNT(hh.HANGHOAMA) SL,
                ((nh.DON_GIA_BAN * ((hh.CAN_TONG - hh.TL_HOT)/100.0)) + hh.GIA_CONG ) THANH_TIEN
            FROM danh_muc_hang_hoa hh INNER 
                JOIN ton_kho tk ON hh.HANGHOAID = tk.HANGHOAID 
                JOIN loai_hang l ON l.LOAIID = hh.LOAIID
                JOIN nhom_hang nh ON hh.NHOMHANGID = nh.NHOMHANGID
            WHERE hh.SU_DUNG =1 AND tk.SL_TON > 0 AND hh.HANGHOAMA="${HANGHOAMA}" 
        `);

        return [ 200, ThongTinHangHoa];
    }catch(err){
        console.log(`Lỗi: ${err.message}`);
        return [400, {message: `Lỗi: ${err.message}`}];
    }
}

const ThucHienGiaoDich = async (Input) =>{

    //Status
    let status = 200;

    //Nhận thông tin đầu vào
    const {
        KH_ID,
        TONG_TIEN, KHACH_DUA, THOI_LAI, TONG_SL, 
        CAN_TONG, TL_HOT, GIA_CONG, TIEN_BOT, THANH_TOAN,

        HANGHOAID, HANGHOAMA, HANG_HOA_TEN, SO_LUONG, DON_GIA,
        THANH_TIEN, NHOMHANGID, LOAIVANG
    } = Input;

    //Tạo phiếu xuất mã
    let ngay = new Date().getDate(),
        thang = new Date().getMonth()+1,
        nam = new Date().getFullYear(),
        gio = new Date().getHours(),
        phut = new Date().getMinutes(),
        giay = new Date().getSeconds();
    const PHIEU_XUAT_MA = "PX"+String(nam)+String(thang)+String(ngay)+String(gio)+String(phut)+String(giay);

    try{
        //Kiểm tra điều kiện trước khi thêm vào
        const KiemTraDieuKien = await KiemTraMaHangHoa( String(HANGHOAMA) );
        if(KiemTraDieuKien[0] == 200){

            //Truy vấn thông tin khách hàng dựa trên mã khách hàng
            let KT_khachHang = await ThuVien.queryDB(`SELECT * FROM phx_khach_hang WHERE KH_ID = ${KH_ID}`);
            if(KT_khachHang.length === 0){
                status = 404;
                throw Error("Mã khách hàng không tồn tại.");
            }else{
                console.log('Đã tìm thấy khách hàng');
            }
            
            //Cập nhật lại số lượng trong bản tồn kho
            const CapNhatBangTonKho = await ThuVien.InsertUpdateDB(`UPDATE ton_kho SET SL_TON=SL_TON-1, SL_Xuat=SL_Xuat+1 WHERE KHOID = 1 and HANGHOAID = "${HANGHOAID}";`);
            if(CapNhatBangTonKho === 0){
                status = 500;
                throw Error("Lỗi khi cập nhật số lượng tồn kho.");
            }else{
                console.log('Đã cập nhật số lượng tồn hàng hóa');
            } 

            //Tạo Phiếu xuất
            const TaoPhieuXuat = await ThuVien.InsertUpdateDB(`
                INSERT INTO 
                phx_phieu_xuat(KH_ID, PHIEU_XUAT_MA, NGAY_XUAT,TONG_TIEN, KHACH_DUA, THOI_LAI, TONG_SL, CAN_TONG, TL_HOT, GIA_CONG, TIEN_BOT, THANH_TOAN)
                VALUES(${KH_ID},"${PHIEU_XUAT_MA}", NOW(), ${TONG_TIEN}, ${KHACH_DUA}, ${THOI_LAI}, ${TONG_SL}, ${CAN_TONG}, ${TL_HOT}, ${GIA_CONG}, ${TIEN_BOT}, ${THANH_TOAN});
            `);
            if(TaoPhieuXuat == 0){
                status = 500;
                throw Error("Lỗi khi tạo phiếu xuất.");
            }else{
                console.log('ĐãTạo phiếu xuất');
            } 

            //Lấy ID cuỗi phiếu xuất
            let PHIEU_XUAT_ID = await ThuVien.queryDB(`
                SELECT PHIEU_XUAT_ID FROM phx_phieu_xuat
                ORDER BY PHIEU_XUAT_ID DESC LIMIT 1
            `);
            if(PHIEU_XUAT_ID.length === 0){
                status = 500;
                throw Error("Lỗi khi lấy ID cuối phiếu xuất.");
            }else{
                console.log('Đã lấy ID cuối phieus xuất');
            } 

            //Tạo chi tiết phiếu xuất
            const Tao_CTphieuXuat = await ThuVien.InsertUpdateDB(`
                INSERT INTO 
                phx_chi_tiet_phieu_xuat(PHIEU_XUAT_ID,HANGHOAID,HANGHOAMA,HANG_HOA_TEN,SO_LUONG,DON_GIA,THANH_TIEN,CAN_TONG,TL_HOT,GIA_CONG,NHOMHANGID,LOAIVANG) 
                VALUES(${PHIEU_XUAT_ID[0].PHIEU_XUAT_ID}, ${HANGHOAID}, "${HANGHOAMA}", "${HANG_HOA_TEN}", ${SO_LUONG}, ${DON_GIA}, ${THANH_TIEN}, ${CAN_TONG}, ${TL_HOT}, ${GIA_CONG}, "${NHOMHANGID}", "${LOAIVANG}");    
            `);
            if(Tao_CTphieuXuat == 0){
                status = 500;
                throw Error("Lỗi khi tạo chi tiết phiếu xuất.");
            }else{
                console.log('Đã lấy tạo chi tiết phieus xuất');
            } 

            return [ 200, {message: "Thực hiện giao dịch bán vàng thành công."}];
        }

        return [ 400, KiemTraDieuKien[1] ];        
    }catch(err){
        status = 400;
        console.log(`Lỗi: ${err.message}`);
        return [status , {message: `Lỗi: ${err.message}`}];
    }
}

module.exports={
    KiemTraMaHangHoa, ThucHienGiaoDich
}
//Thành tiền = TONG_TIEN,
//Khách đưa = Thanh toán