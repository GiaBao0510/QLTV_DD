class TruocKhiThucHienBanVang_model{
  final String? HANGHOAID;
  final String? NHOMHANGID;
  final String? MA;
  final String? TEN_HANG;
  final String? LOAIVANG;
  final String? NHOM_TEN;
  final double? CAN_TONG;
  final double? TL_HOT;
  final double? TRU_HOT;
  final double? GIA_CONG;
  final double? DON_GIA_GOC;
  final double? DON_GIA_BAN;
  final double? THANH_TIEN;
  final int? SL;

  //Hàm nhâp
  TruocKhiThucHienBanVang_model({
    required this.HANGHOAID,
    required this.NHOMHANGID,
    required this.MA,
    required this.SL,
    required this.TEN_HANG,
    required this.LOAIVANG,
    required this.NHOM_TEN,
    required this.CAN_TONG,
    required this.TL_HOT,
    required this.TRU_HOT,
    required this.GIA_CONG,
    required this.DON_GIA_GOC,
    required this.DON_GIA_BAN,
    required this.THANH_TIEN,
  });

  TruocKhiThucHienBanVang_model copyWith({
    String? HANGHOAID,
    String? NHOMHANGID,
    String? MA,
    int? SL,
    String? TEN_HANG,
    String? LOAIVANG,
    String? NHOM_TEN,
    double? CAN_TONG,
    double? TL_HOT,
    double? TRU_HOT,
    double? GIA_CONG,
    double? DON_GIA_GOC,
    double? DON_GIA_BAN,
    double? THANH_TIEN,
  }){
    return TruocKhiThucHienBanVang_model(
      HANGHOAID: HANGHOAID ?? this.HANGHOAID,
      NHOMHANGID: NHOMHANGID ?? this.NHOMHANGID,
      MA: MA ?? this.MA,
      SL: SL ?? this.SL,
      TEN_HANG: TEN_HANG ?? this.TEN_HANG,
      LOAIVANG: LOAIVANG ?? this.LOAIVANG,
      NHOM_TEN: NHOM_TEN ?? this.NHOM_TEN,
      CAN_TONG: CAN_TONG ?? this.CAN_TONG,
      TL_HOT: TL_HOT ?? this.TL_HOT,
      TRU_HOT: TRU_HOT ?? this.TRU_HOT,
      GIA_CONG: GIA_CONG ?? this.GIA_CONG,
      DON_GIA_GOC: DON_GIA_GOC ?? this.DON_GIA_GOC,
      DON_GIA_BAN: DON_GIA_BAN ?? this.DON_GIA_BAN,
      THANH_TIEN: THANH_TIEN ?? this.THANH_TIEN,
    );
  }

  //Chuyen Object sang map
  Map<String, dynamic> toMap(){
    return {
      'HANGHOAID':HANGHOAID,
      'NHOMHANGID':NHOMHANGID,
      'MA':MA,
      'SL': SL,
      'TEN_HANG':TEN_HANG,
      'LOAIVANG':LOAIVANG,
      'NHOM_TEN':NHOM_TEN,
      'CAN_TONG':CAN_TONG,
      'TL_HOT':TL_HOT,
      'TRU_HOT':TRU_HOT,
      'GIA_CONG':GIA_CONG,
      'DON_GIA_GOC':DON_GIA_GOC,
      'DON_GIA_BAN':DON_GIA_BAN,
      'THANH_TIEN':THANH_TIEN,
    };
  }

  //Chuyển Map sang Object
  factory TruocKhiThucHienBanVang_model.fromMap(Map<String,dynamic> json){
    return TruocKhiThucHienBanVang_model(
      HANGHOAID: json['HANGHOAID'] ?? '',
      NHOMHANGID: json['NHOMHANGID'] ?? '',
      MA: json['MA'] ?? '',
      SL: (json['SL'] is int)? json['SL'] : 1,
      TEN_HANG: json['TEN_HANG'] ?? '',
      LOAIVANG: json['LOAIVANG'] ?? '',
      NHOM_TEN: json['NHOM_TEN'] ?? '',
      CAN_TONG: (json['CAN_TONG'] is int ? json['CAN_TONG'].toDouble() : json['CAN_TONG'] ) ?? 0.0,
      TL_HOT: (json['TL_HOT'] is int ? json['TL_HOT'].toDouble() : json['TL_HOT'] ) ?? 0.0,
      TRU_HOT: (json['TRU_HOT'] is int ? json['TRU_HOT'].toDouble() : json['TRU_HOT'] ) ?? 0.0,
      GIA_CONG: (json['GIA_CONG'] is int ? json['GIA_CONG'].toDouble() : json['GIA_CONG'] ) ?? 0.0,
      DON_GIA_GOC: (json['DON_GIA_GOC'] is int ? json['DON_GIA_GOC'].toDouble() : json['DON_GIA_GOC'] ) ?? 0.0,
      DON_GIA_BAN: (json['DON_GIA_BAN'] is int ? json['DON_GIA_BAN'].toDouble() : json['DON_GIA_BAN'] ) ?? 0.0,
      THANH_TIEN: (json['THANH_TIEN'] is int ? json['THANH_TIEN'].toDouble() : json['THANH_TIEN'] ) ?? 0.0,
    );
  }
}

// ---------------------

class SauKhiThucHienBangVang_model{

  final String? KH_ID, HANGHOAID, HANGHOAMA, HANG_HOA_TEN,
      NHOMHANGID, LOAIVANG;
  final double? TONG_TIEN, KHACH_DUA, THOI_LAI, TONG_SL,
      CAN_TONG, TL_HOT, GIA_CONG, TIEN_BOT, THANH_TOAN,
      SO_LUONG, DON_GIA, THANH_TIEN;

  SauKhiThucHienBangVang_model({
    required this.KH_ID,
    required this.TONG_TIEN,
    required this.KHACH_DUA,
    required this.THOI_LAI,
    required this.TONG_SL,
    required this.CAN_TONG,
    required this.TL_HOT,
    required this.GIA_CONG,
    required this.TIEN_BOT,
    required this.THANH_TOAN,
    required this.HANGHOAID,
    required this.HANGHOAMA,
    required this.HANG_HOA_TEN,
    required this.SO_LUONG,
    required this.DON_GIA,
    required this.THANH_TIEN,
    required this.NHOMHANGID,
    required this.LOAIVANG,
  });

  SauKhiThucHienBangVang_model copyWith({
    String? KH_ID,
    double? TONG_TIEN,
    double? KHACH_DUA,
    double? THOI_LAI,
    double? TONG_SL,
    double? CAN_TONG,
    double? TL_HOT,
    double? GIA_CONG,
    double? TIEN_BOT,
    double? THANH_TOAN,
    String? HANGHOAID,
    String? HANGHOAMA,
    String? HANG_HOA_TEN,
    double? SO_LUONG,
    double? DON_GIA,
    double? THANH_TIEN,
    String? NHOMHANGID,
    String? LOAIVANG,
  }){
    return SauKhiThucHienBangVang_model(
      KH_ID: KH_ID ?? this.KH_ID,
      TONG_TIEN: TONG_TIEN ?? this.TONG_TIEN,
      KHACH_DUA: KHACH_DUA ?? this.KHACH_DUA,
      THOI_LAI: THOI_LAI ?? this.THOI_LAI,
      TONG_SL: TONG_SL ?? 1.0,
      CAN_TONG: CAN_TONG ?? this.CAN_TONG,
      TL_HOT: TL_HOT ?? this.TL_HOT,
      GIA_CONG: GIA_CONG ?? this.GIA_CONG,
      TIEN_BOT: TIEN_BOT ?? this.TIEN_BOT,
      THANH_TOAN: THANH_TOAN ?? this.THANH_TOAN,
      HANGHOAID: HANGHOAID ?? this.HANGHOAID,
      HANGHOAMA: HANGHOAMA ?? this.HANGHOAMA,
      HANG_HOA_TEN: HANG_HOA_TEN ?? this.HANG_HOA_TEN,
      SO_LUONG: SO_LUONG ?? 1.0,
      DON_GIA: DON_GIA ?? this.DON_GIA,
      THANH_TIEN: THANH_TIEN ?? this.THANH_TIEN,
      NHOMHANGID: NHOMHANGID ?? this.NHOMHANGID,
      LOAIVANG: HANGHOAMA ?? this.LOAIVANG,
    );
  }

  //Chuyen Object sang map
  Map<String, dynamic> toMap(){
    return {
      'KH_ID':KH_ID,
      'TONG_TIEN':TONG_TIEN,
      'KHACH_DUA':KHACH_DUA,
      'THOI_LAI':THOI_LAI,
      'TONG_SL': 1.0,
      'CAN_TONG':CAN_TONG,
      'TL_HOT':TL_HOT,
      'GIA_CONG':GIA_CONG,
      'TIEN_BOT':TIEN_BOT,
      'THANH_TOAN':THANH_TOAN,
      'HANGHOAID':HANGHOAID,
      'HANGHOAMA':HANGHOAMA,
      'HANG_HOA_TEN':HANG_HOA_TEN,
      'SO_LUONG': 1.0,
      'DON_GIA':DON_GIA,
      'THANH_TIEN':THANH_TIEN,
      'NHOMHANGID':NHOMHANGID,
      'LOAIVANG':LOAIVANG,
    };
  }

  //Chuyển Map sang Object
  factory SauKhiThucHienBangVang_model.fromMap(Map<String,dynamic> json){
    return SauKhiThucHienBangVang_model(
      KH_ID: json['KH_ID'] ?? '',
      TONG_TIEN: (json['TONG_TIEN'] is int ? json['TONG_TIEN'].toDouble() : json['TONG_TIEN'] ) ?? 0.0,
      KHACH_DUA: (json['KHACH_DUA'] is int ? json['KHACH_DUA'].toDouble() : json['KHACH_DUA'] ) ?? 0.0,
      THOI_LAI: (json['THOI_LAI'] is int ? json['THOI_LAI'].toDouble() : json['THOI_LAI'] ) ?? 0.0,
      TONG_SL: 1.0,
      CAN_TONG: (json['CAN_TONG'] is int ? json['CAN_TONG'].toDouble() : json['CAN_TONG'] ) ?? 0.0,
      TL_HOT: (json['TL_HOT'] is int ? json['TL_HOT'].toDouble() : json['TL_HOT'] ) ?? 0.0,
      GIA_CONG: (json['GIA_CONG'] is int ? json['GIA_CONG'].toDouble() : json['GIA_CONG'] ) ?? 0.0,
      TIEN_BOT: (json['TIEN_BOT'] is int ? json['TIEN_BOT'].toDouble() : json['TIEN_BOT'] ) ?? 0.0,
      THANH_TOAN: (json['THANH_TOAN'] is int ? json['THANH_TOAN'].toDouble() : json['THANH_TOAN'] ) ?? 0.0,
      HANGHOAID: json['HANGHOAID'] ?? '',
      HANGHOAMA: json['HANGHOAMA'] ?? '',
      HANG_HOA_TEN: json['HANG_HOA_TEN'] ?? '',
      SO_LUONG: 1.0,
      DON_GIA: (json['DON_GIA'] is int ? json['DON_GIA'].toDouble() : json['DON_GIA'] ) ?? 0.0,
      THANH_TIEN: (json['THANH_TIEN'] is int ? json['THANH_TIEN'].toDouble() : json['THANH_TIEN'] ) ?? 0.0,
      NHOMHANGID: json['NHOMHANGID'] ?? '',
      LOAIVANG: json['LOAIVANG'] ?? '',
    );
  }
}
