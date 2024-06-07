class BaoCaoPhieuMua {
  final String kho_id;
  final String nhom_hang_id;
  final String ma_hang_hoa;
  final String ten_hang_hoa;
  final String dvt_id;
  final String nhom_id;
  final String so_luong;
  final String phieu_ma;
  final String ngay_nhap;
  final String ngay_phieu;
  final String khach_hang_id;
  final double can_tong;
  final double tl_hot;
  final double don_gia;
  final String da_xuat;
  final String su_dung;
  final String ghi_chu;
  final double tl_loc;
  final double tl_thuc;
  final double thanh_tien;

  BaoCaoPhieuMua({
    required this.kho_id,
    required this.nhom_hang_id,
    required this.ma_hang_hoa,
    required this.ten_hang_hoa,
    required this.dvt_id,
    required this.nhom_id,
    required this.so_luong,
    required this.phieu_ma,
    required this.ngay_nhap,
    required this.ngay_phieu,
    required this.khach_hang_id,
    required this.can_tong,
    required this.tl_hot,
    required this.don_gia,
    required this.da_xuat,
    required this.su_dung,
    required this.ghi_chu,
    required this.tl_loc,
    required this.tl_thuc,
    required this.thanh_tien,
  });

  // Chuyển đôi Map sang Object
  factory BaoCaoPhieuMua.fromMap(Map<String, dynamic> map) {
    return BaoCaoPhieuMua(
      kho_id: map['KHO_ID'] ?? '',
      nhom_hang_id: map['NHOMHANGID'] ?? '',
      ma_hang_hoa: map['MA_HANG_HOA'] ?? '',
      ten_hang_hoa: map['TEN_HANG_HOA'] ?? '',
      dvt_id: map['DVT_ID'] ?? '',
      nhom_id: map['NHOM_ID'] ?? '',
      so_luong: map['SO_LUONG'] ?? '',
      phieu_ma: map['PHIEU_MA'] ?? '',
      ngay_nhap: map['NGAY_NHAP'] ?? '',
      ngay_phieu: map['NGAY_PHIEU'] ?? '',
      khach_hang_id: map['KHACH_HANG_ID'] ?? '',
      da_xuat: map['DA_XUAT'] ?? '',
      su_dung: map['SU_DUNG'] ?? '',
      ghi_chu: map['GHI_CHU'] ?? '',
      can_tong: (map['CAN_TONG'] is int)
          ? (map['CAN_TONG'] as int).toDouble()
          : (map['CAN_TONG'] is double)
              ? map['CAN_TONG']
              : 0.0,
      tl_hot: (map['TL_HOT'] is int)
          ? (map['TL_HOT'] as int).toDouble()
          : (map['TL_HOT'] is double)
              ? map['TL_HOT']
              : 0.0,
      tl_loc: (map['TL_LOC'] is int)
          ? (map['TL_LOC'] as int).toDouble()
          : (map['TL_LOC'] is double)
              ? map['TL_LOC']
              : 0.0,
      tl_thuc: (map['TL_THUC'] is int)
          ? (map['TL_THUC'] as int).toDouble()
          : (map['TL_THUC'] is double)
              ? map['TL_THUC']
              : 0.0,
      don_gia: (map['DON_GIA'] is int)
          ? (map['DON_GIA'] as int).toDouble()
          : (map['DON_GIA'] is double)
              ? map['DON_GIA']
              : 0.0,
      thanh_tien: (map['THANH_TIEN'] is int)
          ? (map['THANH_TIEN'] as int).toDouble()
          : (map['THANH_TIEN'] is double)
              ? map['THANH_TIEN']
              : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'KHO_ID': kho_id,
      'NHOMHANGID': nhom_hang_id,
      'MA_HANG_HOA': ma_hang_hoa,
      'TEN_HANG_HOA': ten_hang_hoa,
      'DVT_ID': dvt_id,
      'NHOM_ID': nhom_id,
      'SO_LUONG': so_luong,
      'NGAY_NHAP': ngay_nhap,
      'PHIEU_MA': phieu_ma,
      'NGAY_PHIEU': ngay_phieu,
      'KHACH_HANG_ID': khach_hang_id,
      'CAN_TONG': can_tong,
      'TL_HOT': tl_hot,
      'DON_GIA': don_gia,
      'DA_XUAT': da_xuat,
      'SU_DUNG': su_dung,
      'GHI_CHU': ghi_chu,
      'TL_LOC': tl_loc,
      'TL_THUC': tl_thuc,
      'THANH_TIEN': thanh_tien,
    };
  }
}
