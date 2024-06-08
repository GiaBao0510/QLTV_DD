// class BaoCaoPhieuMua {
//   // final String kho_id;
//   // final String nhom_hang_id;
//   final String nhom_ten;
//   final String ma_hang_hoa;
//   final String ten_hang_hoa;
//   // final String dvt_id;
//   // final String nhom_id;
//   final String so_luong;
//   final String phieu_ma;
//   final String ngay_nhap;
//   final String ngay_phieu;
//   // final String khach_hang_id;
//   final double can_tong;
//   final double tl_hot;
//   final double don_gia;
//   final String da_xuat;
//   final String su_dung;
//   final String ghi_chu;
//   final double tl_loc;
//   final double tl_thuc;
//   final double thanh_tien;

//   BaoCaoPhieuMua({
//     // required this.kho_id,
//     // required this.nhom_hang_id,
//     required this.nhom_ten,
//     required this.ma_hang_hoa,
//     required this.ten_hang_hoa,
//     // required this.dvt_id,
//     // required this.nhom_id,
//     required this.so_luong,
//     required this.phieu_ma,
//     required this.ngay_nhap,
//     required this.ngay_phieu,
//     // required this.khach_hang_id,
//     required this.can_tong,
//     required this.tl_hot,
//     required this.don_gia,
//     required this.da_xuat,
//     required this.su_dung,
//     required this.ghi_chu,
//     required this.tl_loc,
//     required this.tl_thuc,
//     required this.thanh_tien,
//   });

//   // Chuyển đôi Map sang Object
//   factory BaoCaoPhieuMua.fromMap(Map<String, dynamic> map) {
//     return BaoCaoPhieuMua(
//       // kho_id: map['KHO_ID'] ?? '',
//       // nhom_hang_id: map['NHOMHANGID'] ?? '',
//       nhom_ten:map['NHOM_TEN'] ?? '',
//       ma_hang_hoa: map['MA_HANG_HOA'] ?? '',
//       ten_hang_hoa: map['TEN_HANG_HOA'] ?? '',
//       // dvt_id: map['DVT_ID'] ?? '',
//       // nhom_id: map['NHOM_ID'] ?? '',
//       so_luong: map['SO_LUONG'] ?? '',
//       phieu_ma: map['PHIEU_MA'] ?? '',
//       ngay_nhap: map['NGAY_NHAP'] ?? '',
//       ngay_phieu: map['NGAY_PHIEU'] ?? '',
//       // khach_hang_id: map['KHACH_HANG_ID'] ?? '',
//       da_xuat: map['DA_XUAT'] ?? '',
//       su_dung: map['SU_DUNG'] ?? '',
//       ghi_chu: map['GHI_CHU'] ?? '',
//       can_tong: (map['CAN_TONG'] is int)
//           ? (map['CAN_TONG'] as int).toDouble()
//           : (map['CAN_TONG'] is double)
//               ? map['CAN_TONG']
//               : 0.0,
//       tl_hot: (map['TL_HOT'] is int)
//           ? (map['TL_HOT'] as int).toDouble()
//           : (map['TL_HOT'] is double)
//               ? map['TL_HOT']
//               : 0.0,
//       tl_loc: (map['TL_LOC'] is int)
//           ? (map['TL_LOC'] as int).toDouble()
//           : (map['TL_LOC'] is double)
//               ? map['TL_LOC']
//               : 0.0,
//       tl_thuc: (map['TL_THUC'] is int)
//           ? (map['TL_THUC'] as int).toDouble()
//           : (map['TL_THUC'] is double)
//               ? map['TL_THUC']
//               : 0.0,
//       don_gia: (map['DON_GIA'] is int)
//           ? (map['DON_GIA'] as int).toDouble()
//           : (map['DON_GIA'] is double)
//               ? map['DON_GIA']
//               : 0.0,
//       thanh_tien: (map['THANH_TIEN'] is int)
//           ? (map['THANH_TIEN'] as int).toDouble()
//           : (map['THANH_TIEN'] is double)
//               ? map['THANH_TIEN']
//               : 0.0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       // 'KHO_ID': kho_id,
//       // 'NHOMHANGID': nhom_hang_id,
//       'NHOM_TEN': nhom_ten,
//       'MA_HANG_HOA': ma_hang_hoa,
//       'TEN_HANG_HOA': ten_hang_hoa,
//       // 'DVT_ID': dvt_id,
//       // 'NHOM_ID': nhom_id,
//       'SO_LUONG': so_luong,
//       'NGAY_NHAP': ngay_nhap,
//       'PHIEU_MA': phieu_ma,
//       'NGAY_PHIEU': ngay_phieu,
//       // 'KHACH_HANG_ID': khach_hang_id,
//       'CAN_TONG': can_tong,
//       'TL_HOT': tl_hot,
//       'DON_GIA': don_gia,
//       'DA_XUAT': da_xuat,
//       'SU_DUNG': su_dung,
//       'GHI_CHU': ghi_chu,
//       'TL_LOC': tl_loc,
//       'TL_THUC': tl_thuc,
//       'THANH_TIEN': thanh_tien,
//     };
//   }
// }

// // class BangBaoCaoPhieuMua_model{
// //   final List<BaoCaoPhieuMua> PhieuMua;
// //   final String MaPhieuMua;

// //   BangBaoCaoPhieuMua_model({
// //     required this.PhieuMua,
// //     required this.MaPhieuMua,
// //   });

// //   //Chuyen tu Map sang object
// //    factory BangBaoCaoPhieuMua_model.fromMap(Map<String, dynamic> json) {
// //     var list = json['data'] as List;
// //     List<BaoCaoPhieuMua> dataList = list.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
// //     return BangBaoCaoPhieuMua_model(
// //       MaPhieuMua: json['PhieuMuaMa'] ?? "",
// //       PhieuMua: dataList,
// //     );
// //   }
// // }
class BaoCaoPhieuXuatModel {
  final String hangHoaTen;
  final String nhomTen;
  final double tlLoc;
  final double tlHot;
  final double tlThuc;
  final double canTong;
  final double donGia;
  final int soLuong;
  final String phieuMa;
  final String ngayNhap;
  final String ngayPhieu;
  final String suDung;
  final String ghiChu;
  final double thanhTien;

  BaoCaoPhieuXuatModel({
    required this.hangHoaTen,
    required this.nhomTen,
    required this.tlLoc,
    required this.tlHot,
    required this.tlThuc,
    required this.canTong,
    required this.donGia,
    required this.soLuong,
    required this.phieuMa,
    required this.ngayNhap,
    required this.ngayPhieu,
    required this.suDung,
    required this.ghiChu,
    required this.thanhTien,
  });

  factory BaoCaoPhieuXuatModel.fromMap(Map<String, dynamic> map) {
    return BaoCaoPhieuXuatModel(
      hangHoaTen: map['HANG_HOA_TEN'] ?? '',
      nhomTen: map['NHOM_TEN'] ?? '',
      tlLoc: map['TL_LOC']?.toDouble() ?? 0.0,
      tlHot: map['TL_HOT']?.toDouble() ?? 0.0,
      tlThuc: map['TL_THUC']?.toDouble() ?? 0.0,
      canTong: map['CAN_TONG']?.toDouble() ?? 0.0,
      donGia: map['DON_GIA']?.toDouble() ?? 0.0,
      soLuong: map['SO_LUONG'] ?? 0,
      phieuMa: map['PHIEU_MA'] ?? '',
      ngayNhap: map['NGAY_NHAP'] ?? '',
      ngayPhieu: map['NGAY_PHIEU'] ?? '',
      suDung: map['SU_DUNG'] ?? '',
      ghiChu: map['GHI_CHU'] ?? '',
      thanhTien: map['CTPV_THANH_TIEN']?.toDouble() ?? 0.0,
    );
  }
}

// class BangBaoCaoPhieuXuatModel {
//   final List<BaoCaoPhieuXuatModel> phieuXuat;
//   final String maPhieuXuat;

//   BangBaoCaoPhieuXuatModel({
//     required this.phieuXuat,
//     required this.maPhieuXuat,
//   });

//   factory BangBaoCaoPhieuXuatModel.fromMap(Map<String, dynamic> json) {
//     var list = json['data'] as List;
//     List<BaoCaoPhieuXuatModel> dataList =
//         list.map((e) => BaoCaoPhieuXuatModel.fromMap(e)).toList();
//     return BangBaoCaoPhieuXuatModel(
//       maPhieuXuat: json['MaPhieuXuat'] ?? "",
//       phieuXuat: dataList,
//     );
//   }
// }


// class BaoCaoTonKhoPhieuMua {
//   final List<BaoCaoPhieuMua> data;
//   final String? nhomTen;
//   final int? soLuong;
//   final double? tongTlThuc;
//   final double? tongTlHot;
//   final double? tongTlVang;
//   final double? tongCongGoc;
//   final double? tongGiaCong;
//   final double? tongThanhTien;

//   BaoCaoTonKhoPhieuMua({
//     required this.data,
//     required this.nhomTen,
//     required this.soLuong,
//     required this.tongTlThuc,
//     required this.tongTlHot,
//     required this.tongTlVang,
//     required this.tongCongGoc,
//     required this.tongGiaCong,
//     required this.tongThanhTien,
//   });

//   factory BaoCaoTonKhoPhieuMua.fromMap(Map<String, dynamic> json) {
//     var list = json['data'] as List;
//     List<BaoCaoPhieuMua> dataList =
//         list.map((i) => BaoCaoPhieuMua.fromMap(i)).toList();

//     return BaoCaoTonKhoPhieuMua(
//       data: dataList,
//       nhomTen: json['sumary']['NhomTen'] ?? '',
//       soLuong: json['sumary']['SoLuong'] ?? 0,
//       tongTlThuc: (json['sumary']['TongTL_Thuc'] is num) ? json['sumary']['TongTL_Thuc'].toDouble() : null,
//       tongTlHot: (json['sumary']['TongTL_hot'] is num) ? json['sumary']['TongTL_hot'].toDouble() : null,
//       tongTlVang: (json['sumary']['TongTL_Vang'] is num) ? json['sumary']['TongTL_Vang'].toDouble() : null,
//       tongCongGoc: (json['sumary']['TongCongGoc'] is num) ? json['sumary']['TongCongGoc'].toDouble() : null,
//       tongGiaCong: (json['sumary']['TongGiaCong'] is num) ? json['sumary']['TongGiaCong'].toDouble() : null,
//       tongThanhTien: (json['sumary']['TongThanhTien'] is num) ? json['sumary']['TongThanhTien'].toDouble() : null,
//     );
//   }
// }
