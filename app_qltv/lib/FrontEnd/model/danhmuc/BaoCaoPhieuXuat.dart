class BaoCaoPhieuXuat_model {
  final String PHIEU_XUAT_MA;
  final String HANGHOAMA;
  final String HANG_HOA_TEN;
  final String LOAIVANG;
  final double CAN_TONG;
  final double TL_HOT;
  final double TL_Vang;
  final String NGAY_XUAT;
  final double DON_GIA;
  final double THANH_TIEN;
  final double GiaGoc;
  final double LaiLo;

  BaoCaoPhieuXuat_model(
      {required this.PHIEU_XUAT_MA,
      required this.HANGHOAMA,
      required this.HANG_HOA_TEN,
      required this.LOAIVANG,
      required this.CAN_TONG,
      required this.TL_HOT,
      required this.TL_Vang,
      required this.NGAY_XUAT,
      required this.DON_GIA,
      required this.THANH_TIEN,
      required this.GiaGoc,
      required this.LaiLo});

  //Chuyển đôi Map sang Object
  factory BaoCaoPhieuXuat_model.fromMap(Map<String, dynamic> map) {
    return BaoCaoPhieuXuat_model(
      PHIEU_XUAT_MA: map['PHIEU_XUAT_MA'] ?? '',
      HANGHOAMA: map['HANGHOAMA'] ?? '',
      HANG_HOA_TEN: map['HANG_HOA_TEN'] ?? '',
      LOAIVANG: map['LOAIVANG'] ?? '',
      // CAN_TONG: map['CAN_TONG'] ?? 0,
      CAN_TONG: (map['CAN_TONG'] is int)
          ? (map['CAN_TONG'] as int).toDouble()
          : (map['CAN_TONG'] is double)
              ? map['CAN_TONG']
              : 0.0,
      // TL_HOT: map['TL_HOT'] ?? 0,
      TL_HOT: (map['TL_HOT'] is int)
          ? (map['TL_HOT'] as int).toDouble()
          : (map['TL_HOT'] is double)
              ? map['TL_HOT']
              : 0.0,
      // TL_Vang: map['TL_Vang'] ?? 0,
      TL_Vang: (map['TL_Vang'] is int)
          ? (map['TL_Vang'] as int).toDouble()
          : (map['TL_Vang'] is double)
              ? map['TL_Vang']
              : 0.0,
      NGAY_XUAT: map['NGAY_XUAT'] ?? '',
      // DON_GIA: map['DON_GIA'] ?? 0,
      DON_GIA: (map['DON_GIA'] is int)
          ? (map['DON_GIA'] as int).toDouble()
          : (map['DON_GIA'] is double)
              ? map['DON_GIA']
              : 0.0,
      // THANH_TIEN: map['THANH_TIEN'] ?? 0,
      THANH_TIEN: (map['THANH_TIEN'] is int)
          ? (map['THANH_TIEN'] as int).toDouble()
          : (map['THANH_TIEN'] is double)
              ? map['THANH_TIEN']
              : 0.0,
      // GiaGoc: map['GiaGoc'] ?? 0,
      GiaGoc: (map['GiaGoc'] is int)
          ? (map['GiaGoc'] as int).toDouble()
          : (map['GiaGoc'] is double)
              ? map['GiaGoc']
              : 0.0,
      // LaiLo: map['LaiLo'] ?? 0
      LaiLo: (map['LaiLo'] is int)
          ? (map['LaiLo'] as int).toDouble()
          : (map['LaiLo'] is double)
              ? map['LaiLo']
              : 0.0,
    );
  }
}
