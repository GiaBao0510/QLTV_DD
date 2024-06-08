class KhoVangMuaVao {
  final String? tenHangHoa;
  final String? tenNhomHang;
  final double? tLLoc;
  final double? tLHot;
  final double? tLThuc;
  final double? canTong;
  final double? donGia;
  final int? soLuong;

  KhoVangMuaVao({
    required this.tenHangHoa,
    required this.tenNhomHang,
    required this.tLLoc,
    required this.tLHot,
    required this.tLThuc,
    required this.canTong,
    required this.donGia,
    required this.soLuong,
  });

  KhoVangMuaVao copyWith({
    String? tenHangHoa,
    String? tenNhomHang,
    double? tLLoc,
    double? tLHot,
    double? tLThuc,
    double? canTong,
    double? donGia,
    int? soLuong,
  }) {
    return KhoVangMuaVao(
      tenHangHoa: tenHangHoa ?? this.tenHangHoa,
      tenNhomHang: tenNhomHang ?? this.tenNhomHang,
      tLLoc: tLLoc ?? this.tLLoc,
      tLHot: tLHot ?? this.tLHot,
      tLThuc: tLThuc ?? this.tLThuc,
      canTong: canTong ?? this.canTong,
      donGia: donGia ?? this.donGia,
      soLuong: soLuong ?? this.soLuong,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'TEN_HANG_HOA': tenHangHoa,
      'NHOM_TEN': tenNhomHang,
      'TL_LOC': tLLoc,
      'TL_HOT': tLHot,
      'TL_THUC': tLThuc,
      'CAN_TONG': canTong,
      'DON_GIA': donGia,
      'SO_LUONG': soLuong,
    };
  }

  factory KhoVangMuaVao.fromMap(Map<String, dynamic> map) {
    return KhoVangMuaVao(
      tenHangHoa: map['TEN_HANG_HOA'] ?? '',
      tenNhomHang: map['NHOM_TEN'] ?? '',
      tLLoc:
          (map['TL_LOC'] is int ? map['TL_LOC'].toDouble() : map['TL_LOC']) ??
              0.0,
      tLHot:
          (map['TL_HOT'] is int ? map['TL_HOT'].toDouble() : map['TL_HOT']) ??
              0.0,
      tLThuc: (map['TL_THUC'] is int
              ? map['TL_THUC'].toDouble()
              : map['TL_THUC']) ??
          0.0,
      canTong: (map['CAN_TONG'] is int
              ? map['CAN_TONG'].toDouble()
              : map['CAN_TONG']) ??
          0.0,
      donGia: (map['DON_GIA'] is int
              ? map['DON_GIA'].toDouble()
              : map['DON_GIA']) ??
          0.0,
      soLuong: map['SO_LUONG'] ?? 0,
    );
  }
}
