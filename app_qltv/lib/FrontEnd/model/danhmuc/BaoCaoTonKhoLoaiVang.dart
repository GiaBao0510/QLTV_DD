class LoaiVangTonKho {
  final String? nhomTen;
  final String? hangHoaMa;
  final String? hangHoaTen;
  final double? canTong;
  final double? tlHot;
  final double? tlVang;
  final double? congGoc;
  final double? giaCong;
  final double? donGiaBan;
  final double? thanhTien;

  // Constructor
  LoaiVangTonKho({
    required this.nhomTen,
    required this.hangHoaMa,
    required this.hangHoaTen,
    required this.canTong,
    required this.tlHot,
    required this.tlVang,
    required this.congGoc,
    required this.giaCong,
    required this.donGiaBan,
    required this.thanhTien,
  });

  // Copy constructor
  LoaiVangTonKho copyWith({
    String? nhomTen,
    String? hangHoaMa,
    String? hangHoaTen,
    double? canTong,
    double? tlHot,
    double? tlVang,
    double? congGoc,
    double? giaCong,
    double? donGiaBan,
    double? thanhTien,
  }) {
    return LoaiVangTonKho(
      nhomTen: nhomTen ?? this.nhomTen,
      hangHoaMa: hangHoaMa ?? this.hangHoaMa,
      hangHoaTen: hangHoaTen ?? this.hangHoaTen,
      canTong: canTong ?? this.canTong,
      tlHot: tlHot ?? this.tlHot,
      tlVang: tlVang ?? this.tlVang,
      congGoc: congGoc ?? this.congGoc,
      giaCong: giaCong ?? this.giaCong,
      donGiaBan: donGiaBan ?? this.donGiaBan,
      thanhTien: thanhTien ?? this.thanhTien,
    );
  }

  // Factory constructor to create an instance from a Map
  factory LoaiVangTonKho.fromMap(Map<String, dynamic> map) {
    return LoaiVangTonKho(
      nhomTen: map['NHOM_TEN'] ?? '',
      hangHoaMa: map['HANGHOAMA'] ?? '',
      hangHoaTen: map['HANG_HOA_TEN'] ?? '',
      canTong: (map['CAN_TONG'] as num?)?.toDouble() ?? 0.0,
      tlHot: (map['TL_HOT'] as num?)?.toDouble() ?? 0.0,
      tlVang: (map['TL_vang'] as num?)?.toDouble() ?? 0.0,
      congGoc: (map['CONG_GOC'] as num?)?.toDouble() ?? 0.0,
      giaCong: (map['GIA_CONG'] as num?)?.toDouble() ?? 0.0,
      donGiaBan: (map['DonGiaBan'] as num?)?.toDouble() ?? 0.0,
      thanhTien: (map['ThanhTien'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Method to convert an instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'NHOM_TEN': nhomTen,
      'HANGHOAMA': hangHoaMa,
      'HANG_HOA_TEN': hangHoaTen,
      'CAN_TONG': canTong,
      'TL_HOT': tlHot,
      'TL_vang': tlVang,
      'CONG_GOC': congGoc,
      'GIA_CONG': giaCong,
      'DonGiaBan': donGiaBan,
      'ThanhTien': thanhTien,
    };
  }
}

class BaoCaoTonKhoLoaiVang {
  final List<LoaiVangTonKho> data;
  final String nhomTen;
  final int? soLuong;
  final double? tongTlThuc;
  final double? tongTlHot;
  final double? tongTlVang;
  final double? tongCongGoc;
  final double? tongGiaCong;
  final double? tongThanhTien;

  // Constructor
  BaoCaoTonKhoLoaiVang({
    required this.data,
    required this.nhomTen,
    required this.soLuong,
    required this.tongTlThuc,
    required this.tongTlHot,
    required this.tongTlVang,
    required this.tongCongGoc,
    required this.tongGiaCong,
    required this.tongThanhTien,
  });

  // Factory constructor to create an instance from a Map
  factory BaoCaoTonKhoLoaiVang.fromMap(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LoaiVangTonKho> dataList =
        list.map((i) => LoaiVangTonKho.fromMap(i)).toList();

    return BaoCaoTonKhoLoaiVang(
      data: dataList,
      nhomTen: json['sumary']['NhomTen'] ?? '',
      soLuong: json['sumary']['SoLuong'] ?? 0,
      tongTlThuc: (json['sumary']['TongTL_Thuc'] as num?)?.toDouble() ?? 0.0,
      tongTlHot: (json['sumary']['TongTL_hot'] as num?)?.toDouble() ?? 0.0,
      tongTlVang: (json['sumary']['TongTL_Vang'] as num?)?.toDouble() ?? 0.0,
      tongCongGoc: (json['sumary']['TongCongGoc'] as num?)?.toDouble() ?? 0.0,
      tongGiaCong: (json['sumary']['TongGiaCong'] as num?)?.toDouble() ?? 0.0,
      tongThanhTien:
          (json['sumary']['TongThanhTien'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
