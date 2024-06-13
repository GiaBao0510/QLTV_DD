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
  final String KH_TEN;
  final double TIEN_BOT;
  final int SO_LUONG;
  final double GIA_CONG;
  final double TONG_TIEN;
  final double THANH_TOAN;
  final double TRI_GIA_MUA;

  BaoCaoPhieuXuat_model({
    required this.PHIEU_XUAT_MA,
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
    required this.LaiLo,
    required this.KH_TEN,
    required this.TIEN_BOT,
    required this.SO_LUONG,
    required this.GIA_CONG,
    required this.TONG_TIEN,
    required this.THANH_TOAN,
    required this.TRI_GIA_MUA,
  });

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
      KH_TEN: map['KH_TEN'] ?? '',
      TIEN_BOT: (map['TIEN_BOT'] is int)
          ? (map['TIEN_BOT'] as int).toDouble()
          : (map['TIEN_BOT'] is double)
              ? map['TIEN_BOT']
              : 0.0,
      SO_LUONG: (map['SO_LUONG'] is int) ? map['SO_LUONG'] : 0,
      GIA_CONG: (map['GIA_CONG'] is int)
          ? (map['GIA_CONG'] as int).toDouble()
          : (map['GIA_CONG'] is double)
              ? map['GIA_CONG']
              : 0.0,
      TONG_TIEN: (map['TONG_TIEN'] is int)
          ? (map['TONG_TIEN'] as int).toDouble()
          : (map['TONG_TIEN'] is double)
              ? map['TONG_TIEN']
              : 0.0,
      THANH_TOAN: (map['THANH_TOAN'] is int)
          ? (map['THANH_TOAN'] as int).toDouble()
          : (map['THANH_TOAN'] is double)
              ? map['THANH_TOAN']
              : 0.0,
      TRI_GIA_MUA: (map['TRI_GIA_MUA'] is int)
          ? (map['TRI_GIA_MUA'] as int).toDouble()
          : (map['TRI_GIA_MUA'] is double)
              ? map['TRI_GIA_MUA']
              : 0.0,
    );
  }

  //Chuyển Object sang Map
  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    return {
      'PHIEU_XUAT_MA': PHIEU_XUAT_MA,
      'HANGHOAMA': HANGHOAMA,
      'HANG_HOA_TEN': HANG_HOA_TEN,
      'LOAIVANG': LOAIVANG,
      'CAN_TONG': CAN_TONG,
      'TL_HOT': TL_HOT,
      'TL_Vang': TL_Vang,
      'NGAY_XUAT': NGAY_XUAT,
      'DON_GIA': DON_GIA,
      'THANH_TIEN': THANH_TIEN,
      'GiaGoc': GiaGoc,
      'LaiLo': LaiLo,
      'KH_TEN': KH_TEN,
      'TIEN_BOT': TIEN_BOT,
      'SO_LUONG': SO_LUONG,
      'GIA_CONG': GIA_CONG,
      'TONG_TIEN': TONG_TIEN,
      'THANH_TOAN': THANH_TOAN,
    };
  }
}

//Bang bao cao phieu xuat
class BangBaoCaoPhieuXuat_model {
  final List<BaoCaoPhieuXuat_model> PhieuXuat;
  final String MaPhieuXuat;

  BangBaoCaoPhieuXuat_model({
    required this.PhieuXuat,
    required this.MaPhieuXuat,
  });

  //Chuyen tu Map sang object
  factory BangBaoCaoPhieuXuat_model.fromMap(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BaoCaoPhieuXuat_model> dataList =
        list.map((e) => BaoCaoPhieuXuat_model.fromMap(e)).toList();
    return BangBaoCaoPhieuXuat_model(
      MaPhieuXuat: json['PhieuXuatMa'] ?? "",
      PhieuXuat: dataList,
    );
  }
}

//Lop lay thong tin tinh tong
class ThongTinTinhTong_model {
  final int SoLuongHang;
  final double TongCanTong;
  final double TongTLhot;
  final double TongTLvang;
  final double TongThanhTien;
  final double TongGiaGoc;
  final double TongLaiLo;

  ThongTinTinhTong_model({
    required this.SoLuongHang,
    required this.TongCanTong,
    required this.TongTLhot,
    required this.TongTLvang,
    required this.TongThanhTien,
    required this.TongGiaGoc,
    required this.TongLaiLo,
  });

  //Chuyen Map sang object
  factory ThongTinTinhTong_model.fromMap(Map<String, dynamic> map) {
    return ThongTinTinhTong_model(
      SoLuongHang: (map['SoLuongHang'] is int) ? map['SoLuongHang'] : 0,
      TongCanTong: (map['TongCanTong'] is int)
          ? (map['TongCanTong'] as int).toDouble()
          : (map['TongCanTong'] is double)
              ? (map['TongCanTong'] as double)
              : 0.0,
      TongTLhot: (map['TongTLhot'] is int)
          ? (map['TongTLhot'] as int).toDouble()
          : (map['TongTLhot'] is double)
              ? (map['TongTLhot'] as double)
              : 0.0,
      TongTLvang: (map['TongTLvang'] is int)
          ? (map['TongTLvang'] as int).toDouble()
          : (map['TongTLvang'] is double)
              ? (map['TongTLvang'] as double)
              : 0.0,
      TongThanhTien: (map['TongThanhTien'] is int)
          ? (map['TongThanhTien'] as int).toDouble()
          : (map['TongThanhTien'] is double)
              ? (map['TongThanhTien'] as double)
              : 0.0,
      TongGiaGoc: (map['TongGiaGoc'] is int)
          ? (map['TongGiaGoc'] as int).toDouble()
          : (map['TongGiaGoc'] is double)
              ? (map['TongGiaGoc'] as double)
              : 0.0,
      TongLaiLo: (map['TongLaiLo'] is int)
          ? (map['TongLaiLo'] as int).toDouble()
          : (map['TongLaiLo'] is double)
              ? (map['TongLaiLo'] as double)
              : 0.0,
    );
  }

  //Chuyen Object sang Map
  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    return {
      'SoLuongHang': SoLuongHang,
      'TongCanTong': TongCanTong,
      'TongTLhot': TongTLhot,
      'TongTLvang': TongTLvang,
      'TongThanhTien': TongThanhTien,
      'TongGiaGoc': TongGiaGoc,
      'TongLaiLo': TongLaiLo
    };
  }
}
