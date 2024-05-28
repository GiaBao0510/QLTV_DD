class BaoCaoTonKhoLoaiVang{
  final String? NHOM_TEN;
  final String? HANGHOAMA;
  final String? HANG_HOA_TEN;
  final double? CAN_TONG;
  final double? TL_HOT;
  final double? TL_vang;
  final double? CONG_GOC;
  final double? GIA_CONG;
  final double? DonGiaBan;
  final double? ThanhTien;

  //Hàm mặc nhiên
  BaoCaoTonKhoLoaiVang({
   required this.NHOM_TEN, required this.HANGHOAMA, required this.HANG_HOA_TEN,
   required this.CAN_TONG, required this.TL_HOT, required this.TL_vang,
   required this.CONG_GOC, required this.GIA_CONG, required this.DonGiaBan,
   required this.ThanhTien
  });

  //Hàm sao chép
  BaoCaoTonKhoLoaiVang copyWith({
     String? NHOM_TEN, String? HANGHOAMA, String? HANG_HOA_TEN,
     double? CAN_TONG, double? TL_HOT, double? TL_vang, double? CONG_GOC,
     double? GIA_CONG, double? DonGiaBan, double? ThanhTien
  }){
    return BaoCaoTonKhoLoaiVang(
        NHOM_TEN: NHOM_TEN ?? this.NHOM_TEN,
        HANGHOAMA: HANGHOAMA ?? this.HANGHOAMA,
        HANG_HOA_TEN: HANG_HOA_TEN ?? this.HANG_HOA_TEN,
        CAN_TONG: CAN_TONG ?? this.CAN_TONG,
        TL_HOT: TL_HOT ?? this.TL_HOT,
        TL_vang: TL_vang ?? this.TL_vang,
        CONG_GOC: CONG_GOC ?? this.CONG_GOC,
        GIA_CONG: GIA_CONG ?? this.GIA_CONG,
        DonGiaBan: DonGiaBan ?? this.DonGiaBan,
        ThanhTien: ThanhTien ?? this.ThanhTien,
    );
  }

  //Phương thức chuyển từ Map sang đôi tượng
  factory BaoCaoTonKhoLoaiVang.fromMap(Map<String, dynamic> map){
    return BaoCaoTonKhoLoaiVang(
      NHOM_TEN: map['NHOM_TEN'] ?? '',
      HANGHOAMA: map['NHOM_TEN'] ?? '',
      HANG_HOA_TEN: map['HANG_HOA_TEN'] ?? '',
      CAN_TONG: (map['CAN_TONG'] as num).toDouble() ?? 0.0,
      TL_HOT: (map['TL_HOT'] as num).toDouble() ?? 0.0,
      TL_vang: (map['TL_vang'] as num).toDouble() ?? 0.0,
      CONG_GOC: (map['CONG_GOC'] as num).toDouble() ?? 0.0,
      GIA_CONG: (map['GIA_CONG'] as num).toDouble() ?? 0.0,
      DonGiaBan: (map['DonGiaBan'] as num).toDouble() ?? 0.0,
      ThanhTien: (map['ThanhTien'] as num).toDouble() ?? 0.0,
    );
  }

  //Phương thức chuyển Object sang Map
  Map<String, dynamic> toMap(){
    return {
      'NHOM_TEN': NHOM_TEN,
      'HANGHOAMA': HANGHOAMA,
      'HANG_HOA_TEN': HANG_HOA_TEN,
      'CAN_TONG': CAN_TONG,
      'TL_HOT': TL_HOT,
      'TL_vang': TL_vang,
      'CONG_GOC': CONG_GOC,
      'GIA_CONG': GIA_CONG,
      'DonGiaBan': DonGiaBan,
      'ThanhTien': ThanhTien
    };
  }
}

class TinhTong{
  final int? SoLuong;
  final double? TongTL_Thuc;
  final double? TongTL_hot;
  final double? TongTL_Vang;
  final double? TongCongGoc;
  final double? TongGiaCong;
  final double? TongThanhTien;

  //Hàm mặc nhiên
  TinhTong({
    required this.SoLuong, required this.TongTL_Thuc, required this.TongTL_hot,
    required this.TongTL_Vang, required this.TongCongGoc, required this.TongGiaCong,
    required this.TongThanhTien
  });

  //Hàm sao chép
  TinhTong copyWith({
    int? SoLuong, double? TongTL_Thuc, double? TongTL_hot,
    double? TongTL_Vang, double? TongCongGoc,
    double? TongGiaCong, double? TongThanhTien
  }){
    return TinhTong(
      SoLuong: SoLuong ?? this.SoLuong,
      TongTL_Thuc: TongTL_Thuc ?? this.TongTL_Thuc,
      TongTL_hot: TongTL_hot ?? this.TongTL_hot,
      TongTL_Vang: TongTL_Vang ?? this.TongTL_Vang,
      TongCongGoc: TongCongGoc ?? this.TongCongGoc,
      TongGiaCong: TongGiaCong ?? this.TongGiaCong,
      TongThanhTien: TongThanhTien ?? this.TongThanhTien
    );
  }

  //Phương thức chuyển từ Map sang đôi tượng
  factory TinhTong.fromMap(Map<String, dynamic> map){
    return TinhTong(
      SoLuong: map['SoLuong'] ?? 0,
      TongTL_Thuc: (map['TongTL_Thuc'] as num).toDouble() ?? 0.0,
      TongTL_hot: (map['TongTL_hot'] as num).toDouble() ?? 0.0,
      TongTL_Vang: (map['TongTL_Vang'] as num).toDouble() ?? 0.0,
      TongCongGoc: (map['TongCongGoc'] as num).toDouble() ?? 0.0,
      TongGiaCong: (map['TongGiaCong'] as num).toDouble() ?? 0.0,
      TongThanhTien: (map['TongThanhTien'] as num).toDouble() ?? 0.0
    );
  }

  //Phương thức chuyển Object sang Map
  Map<String, dynamic> toMap(){
    return {
      'SoLuong': SoLuong,
      'TongTL_Thuc': TongTL_Thuc,
      'TongTL_hot': TongTL_hot,
      'TongTL_Vang': TongTL_Vang,
      'TongCongGoc': TongCongGoc,
      'TongGiaCong': TongGiaCong,
      'TongThanhTien': TongThanhTien
    };
  }
}