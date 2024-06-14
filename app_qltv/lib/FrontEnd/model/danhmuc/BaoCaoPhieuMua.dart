class BaoCaoPhieuMua {
  final String? phieuMa;
  final String? hangHoaTen;
  final String? nhomTen;
  final double? tlHot;
  final double? tlThuc;
  final double? canTong;
  final double? donGia;
  final String? ngayNhap;
  final String? ngayPhieu;
  final double? thanhTien;

  BaoCaoPhieuMua({
    this.hangHoaTen,
    this.nhomTen,
    this.tlHot,
    this.tlThuc,
    this.canTong,
    this.donGia,
    this.phieuMa,
    this.ngayNhap,
    this.ngayPhieu,
    this.thanhTien,
  });
  BaoCaoPhieuMua copyWith({
    String? hangHoaTen,
    String? nhomTen,
    String? phieuMa,
    double? tlHot,
    double? tlThuc,
    double? canTong,
    double? donGia,
    String? ngayNhap,
    String? ngayPhieu,
    double? thanhTien,
  }) {
    return BaoCaoPhieuMua(
      hangHoaTen: hangHoaTen ?? this.hangHoaTen,
      nhomTen: nhomTen ?? this.nhomTen,
      phieuMa: phieuMa ?? this.phieuMa,
      tlHot: tlHot ?? this.tlHot,
      tlThuc: tlThuc ?? this.tlThuc,
      canTong: canTong ?? this.canTong,
      donGia: donGia ?? this.donGia,
      ngayNhap: ngayNhap ?? this.ngayNhap,
      ngayPhieu: ngayPhieu ?? this.ngayPhieu,
      thanhTien: thanhTien ?? this.thanhTien,
    );
  }

  factory BaoCaoPhieuMua.fromMap(Map<String, dynamic> map) {
    return BaoCaoPhieuMua(
      hangHoaTen: map['HANG_HOA_TEN'] ?? '',
      nhomTen: map['NHOM_TEN'] ?? '',
      tlHot: (map['TL_HOT'] is int)
          ? (map['TL_HOT'] as int).toDouble()
          : (map['TL_HOT'] is double)
              ? map['TL_HOT']
              : 0.0,
      tlThuc: (map['TL_THUC'] is int)
          ? (map['TL_THUC'] as int).toDouble()
          : (map['TL_THUC'] is double)
              ? map['TL_THUC']
              : 0.0,
      canTong: (map['CAN_TONG'] is int)
          ? (map['CAN_TONG'] as int).toDouble()
          : (map['CAN_TONG'] is double)
              ? map['CAN_TONG']
              : 0.0,
      
      donGia: (map['DON_GIA'] is int)
          ? (map['DON_GIA'] as int).toDouble()
          : (map['DON_GIA'] is double)
              ? map['DON_GIA']
              : 0.0,
      thanhTien: (map['THANH_TIEN'] is int)
          ? (map['THANH_TIEN'] as int).toDouble()
          : (map['THANH_TIEN'] is double)
              ? map['THANH_TIEN']
              : 0.0,
      phieuMa: map['PHIEU_MA'] ?? '',
      ngayNhap: map['NGAY_NHAP'] ?? '',
      ngayPhieu: map['NGAY_PHIEU'] ?? '',
      //thanhTien: map['THANH_TIEN'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'HANG_HOA_TEN': hangHoaTen,
      'NHOM_TEN': nhomTen,
      'TL_HOT': tlHot ,
      'CAN_TONG': canTong,
      'TL_THUC': tlThuc,
      'DON_GIA': donGia,
      'PHIEU_MA': phieuMa,
      'NGAY_NHAP': ngayNhap,
      'NGAY_PHIEU': ngayPhieu,
      'THANH_TIEN': thanhTien,
    };
  }
}
