class PhieuDangCam_model{
  final String? PHIEU_CAM_VANG_ID;
  final String? PHIEU_MA;
  final String? KH_TEN;
  final String? TU_NGAY;
  final String? DEN_NGAY;
  final double? CAN_TONG;
  final double? TL_HOT;
  final double? TL_THUC;
  final double? DINH_GIA;
  final double? TIEN_KHACH_NHAN;
  final double? LAI_XUAT;
  final double? TIEN_THEM;
  final double? TIEN_MOI;
  final String? DIEN_THOAI;
  final String? DIA_CHI;
  final String? NGAY_LAP;
  final String? NGAY_CAM;
  final String? LY_DO_MAT_PHIEU;
  final String? MAT_PHIEU;
  final int? SO_NGAY_HET_HAN;
  final int? SO_NGAY_TINH_DUOC;
  final double? THANH_TIEN;
  final String? GHI_CHU;
  final String? LOAI_VANG;
  final String? TEN_HANG_HOA;
  final double? DON_GIA;

  //Ham khoi tao
  PhieuDangCam_model({
    this.PHIEU_CAM_VANG_ID,
    this.PHIEU_MA, this.KH_TEN,
    this.TU_NGAY, this.DEN_NGAY,
    this.CAN_TONG, this.TL_HOT,
    this.TL_THUC, this.DINH_GIA,
    this.TIEN_KHACH_NHAN, this.LAI_XUAT,
    this.TIEN_THEM, this.TIEN_MOI,
    this.DIEN_THOAI, this.DIA_CHI,
    this.NGAY_LAP, this.NGAY_CAM,
    this.LY_DO_MAT_PHIEU, this.MAT_PHIEU,
    this.SO_NGAY_HET_HAN, this.SO_NGAY_TINH_DUOC,
    this.THANH_TIEN, this.GHI_CHU,
    this.LOAI_VANG, this.TEN_HANG_HOA,
    this.DON_GIA,
  });

  //Ham sao chep
  PhieuDangCam_model copyWith({
    String? PHIEU_CAM_VANG_ID,
    String? PHIEU_MA,
    String? KH_TEN,
    String? TU_NGAY,
    String? DEN_NGAY,
    double? CAN_TONG,
    double? TL_HOT,
    double? TL_THUC,
    double? DINH_GIA,
    double? TIEN_KHACH_NHAN,
    double? LAI_XUAT,
    double? TIEN_THEM,
    double? TIEN_MOI,
    String? DIEN_THOAI,
    String? DIA_CHI,
    String? NGAY_LAP,
    String? NGAY_CAM,
    String? LY_DO_MAT_PHIEU,
    String? MAT_PHIEU,
    int? SO_NGAY_HET_HAN,
    int? SO_NGAY_TINH_DUOC,
    double? THANH_TIEN,
    String? GHI_CHU,
    String? LOAI_VANG,
    String? TEN_HANG_HOA,
    double? DON_GIA,
  }){
    return PhieuDangCam_model(
      PHIEU_CAM_VANG_ID: PHIEU_CAM_VANG_ID ?? this.PHIEU_CAM_VANG_ID,
      PHIEU_MA: PHIEU_MA ?? this.PHIEU_MA,
      KH_TEN: KH_TEN ?? this.KH_TEN,
      TU_NGAY: TU_NGAY ?? this.TU_NGAY,
      DEN_NGAY: DEN_NGAY ?? this.DEN_NGAY,
      CAN_TONG: CAN_TONG ?? this.CAN_TONG,
      TL_HOT: TL_HOT ?? this.TL_HOT,
      TL_THUC: TL_THUC ?? this.TL_THUC,
      DINH_GIA: DINH_GIA ?? this.DINH_GIA,
      TIEN_KHACH_NHAN: TIEN_KHACH_NHAN ?? this.TIEN_KHACH_NHAN,
      LAI_XUAT: LAI_XUAT ?? this.LAI_XUAT,
      TIEN_THEM: TIEN_THEM ?? this.TIEN_THEM,
      TIEN_MOI: TIEN_MOI ?? this.TIEN_MOI,
      DIEN_THOAI: DIEN_THOAI ?? this.DIEN_THOAI,
      DIA_CHI: DIA_CHI ?? this.DIA_CHI,
      NGAY_LAP: NGAY_LAP ?? this.NGAY_LAP,
      NGAY_CAM: NGAY_CAM ?? this.NGAY_CAM,
      LY_DO_MAT_PHIEU: LY_DO_MAT_PHIEU ?? this.LY_DO_MAT_PHIEU,
      MAT_PHIEU: MAT_PHIEU ?? this.MAT_PHIEU,
      SO_NGAY_HET_HAN: SO_NGAY_HET_HAN ?? this.SO_NGAY_HET_HAN,
      SO_NGAY_TINH_DUOC: SO_NGAY_TINH_DUOC ?? this.SO_NGAY_TINH_DUOC,
      THANH_TIEN: THANH_TIEN ?? this.THANH_TIEN,
      GHI_CHU: GHI_CHU ?? this.GHI_CHU,
      LOAI_VANG: LOAI_VANG ?? this.LOAI_VANG,
      TEN_HANG_HOA: TEN_HANG_HOA ?? this.TEN_HANG_HOA,
      DON_GIA: DON_GIA ?? this.DON_GIA,
    );
  }

  //Chuyen Map sang doi tương
  factory PhieuDangCam_model.fromMap(Map<String, dynamic> json){
    return PhieuDangCam_model(
      PHIEU_CAM_VANG_ID: json['PHIEU_CAM_VANG_ID'] ?? '',
      PHIEU_MA: json['PHIEU_MA'] ?? '',
      KH_TEN: json['KH_TEN'] ?? '',
      TU_NGAY: json['TU_NGAY'] ?? '',
      DEN_NGAY: json['DEN_NGAY'] ?? '',
      CAN_TONG: (json['CAN_TONG'] is int) ? (json['CAN_TONG'] as int).toDouble() :
        (json['CAN_TONG'] is double) ? json['CAN_TONG'] : 0.0,
      TL_HOT: (json['TL_HOT'] is int) ? (json['TL_HOT'] as int).toDouble() :
        (json['TL_HOT'] is double) ? json['TL_HOT'] : 0.0,
      TL_THUC: (json['TL_THUC'] is int) ? (json['TL_THUC'] as int).toDouble() :
        (json['TL_THUC'] is double) ? json['TL_THUC'] : 0.0,
      DINH_GIA: (json['DINH_GIA'] is int) ? (json['DINH_GIA'] as int).toDouble() :
        (json['DINH_GIA'] is double) ? json['DINH_GIA'] : 0.0,
      TIEN_KHACH_NHAN: (json['TIEN_KHACH_NHAN'] is int) ? (json['TIEN_KHACH_NHAN'] as int).toDouble() :
        (json['TIEN_KHACH_NHAN'] is double) ? json['TIEN_KHACH_NHAN'] : 0.0,
      LAI_XUAT: (json['LAI_XUAT'] is int) ? (json['LAI_XUAT'] as int).toDouble() :
        (json['LAI_XUAT'] is double) ? json['LAI_XUAT'] : 0.0,
      TIEN_THEM: (json['TIEN_THEM'] is int) ? (json['TIEN_THEM'] as int).toDouble() :
        (json['TIEN_THEM'] is double) ? json['TIEN_THEM'] : 0.0,
      TIEN_MOI: (json['TIEN_MOI'] is int) ? (json['TIEN_MOI'] as int).toDouble() :
        (json['TIEN_MOI'] is double) ? json['TIEN_MOI'] : 0.0,
      DIEN_THOAI: json['DIEN_THOAI'] ?? '',
      DIA_CHI: json['DIA_CHI'] ?? '',
      NGAY_LAP: json['NGAY_LAP'] ?? '',
      NGAY_CAM: json['NGAY_CAM'] ?? '',
      LY_DO_MAT_PHIEU: json['LY_DO_MAT_PHIEU'] ?? '',
      MAT_PHIEU: json['MAT_PHIEU'] ?? '',
      SO_NGAY_HET_HAN: (json['SO_NGAY_HET_HAN'] is int)? json['SO_NGAY_HET_HAN'] :0,
      SO_NGAY_TINH_DUOC: (json['SO_NGAY_TINH_DUOC'] is int)? json['SO_NGAY_TINH_DUOC'] :0,
      THANH_TIEN: (json['THANH_TIEN'] is int) ? (json['THANH_TIEN'] as int).toDouble() :
        (json['THANH_TIEN'] is double) ? json['THANH_TIEN'] : 0.0,
      GHI_CHU: json['GHI_CHU'] ?? '',
      LOAI_VANG: json['LOAI_VANG'] ?? '',
      TEN_HANG_HOA: json['TEN_HANG_HOA'] ?? '',
      DON_GIA: (json['DON_GIA'] is int) ? (json['DON_GIA'] as int).toDouble() :
        (json['DON_GIA'] is double) ? json['DON_GIA'] : 0.0,
    );
  }

  //Chuyen Object to Map
  Map<String, dynamic> toMap(Map<String, dynamic> json){
    return {
      'PHIEU_CAM_VANG_ID':PHIEU_CAM_VANG_ID,
      'PHIEU_MA': PHIEU_MA,
      'KH_TEN': KH_TEN,
      'TU_NGAY': TU_NGAY,
      'DEN_NGAY': DEN_NGAY,
      'CAN_TONG': CAN_TONG,
      'TL_HOT': TL_HOT,
      'TL_THUC': TL_THUC,
      'DINH_GIA': DINH_GIA,
      'TIEN_KHACH_NHAN': TIEN_KHACH_NHAN,
      'LAI_XUAT': LAI_XUAT,
      'TIEN_THEM': TIEN_THEM,
      'TIEN_MOI': TIEN_MOI,
      'DIEN_THOAI': DIEN_THOAI,
      'DIA_CHI': DIA_CHI,
      'NGAY_LAP': NGAY_LAP,
      'NGAY_CAM': NGAY_CAM,
      'LY_DO_MAT_PHIEU': LY_DO_MAT_PHIEU,
      'MAT_PHIEU': MAT_PHIEU,
      'THANH_TIEN': THANH_TIEN,
      'GHI_CHU': GHI_CHU,
      'LOAI_VANG': LOAI_VANG,
      'TEN_HANG_HOA': TEN_HANG_HOA,
      'DON_GIA': DON_GIA,
    };
  }
}

class TinhTongPhieuDangCam_model{
  final int? SoLuong;
  final double? TongCanTong;
  final double? Tong_TLthuc;
  final double? Tong_TL_HOT;
  final double? TongDinhGia;
  final double? TongTienKhachNhan;
  final double? TongTienThem;
  final double? TongTienMoi;

  TinhTongPhieuDangCam_model({
    this.SoLuong, this.Tong_TLthuc,
    this.TongCanTong, this.TongDinhGia,
    this.TongTienKhachNhan, this.TongTienMoi,
    this.TongTienThem, this.Tong_TL_HOT
  });

  //ham sao chep
  TinhTongPhieuDangCam_model copyWith({
    int? SoLuong,
    double? TongCanTong,
    double? Tong_TLthuc,
    double? Tong_TL_HOT,
    double? TongDinhGia,
    double? TongTienKhachNhan,
    double? TongTienThem,
    double? TongTienMoi,
  }){
    return TinhTongPhieuDangCam_model(
      SoLuong: SoLuong ?? this.SoLuong,
      TongCanTong: TongCanTong ?? this.TongCanTong,
      Tong_TLthuc: Tong_TLthuc ?? this.Tong_TLthuc,
      Tong_TL_HOT: Tong_TL_HOT ?? this.Tong_TL_HOT,
      TongDinhGia: TongDinhGia ?? this.TongDinhGia,
      TongTienKhachNhan: TongTienKhachNhan ?? this.TongTienKhachNhan,
      TongTienThem: TongTienThem ?? this.TongTienThem,
      TongTienMoi: TongTienMoi ?? this.TongTienMoi,
    );
  }

  //Chuyen doi Map sang Object
  factory TinhTongPhieuDangCam_model.fromMap(Map<String, dynamic> json){
    return TinhTongPhieuDangCam_model(
      SoLuong: (json['SoLuong'] is int)? json['SoLuong'] :0,
      TongCanTong: (json['TongCanTong'] is int) ? (json['TongCanTong'] as int).toDouble() :
        (json['TongCanTong'] is double) ? json['TongCanTong'] : 0.0,
      Tong_TLthuc: (json['Tong_TLthuc'] is int) ? (json['Tong_TLthuc'] as int).toDouble() :
        (json['Tong_TLthuc'] is double) ? json['Tong_TLthuc'] : 0.0,
      Tong_TL_HOT: (json['Tong_TLthuc'] is int) ? (json['Tong_TL_HOT'] as int).toDouble() :
        (json['Tong_TL_HOT'] is double) ? json['Tong_TL_HOT'] : 0.0,
      TongDinhGia: (json['TongDinhGia'] is int) ? (json['TongDinhGia'] as int).toDouble() :
        (json['TongDinhGia'] is double) ? json['TongDinhGia'] : 0.0,
      TongTienKhachNhan: (json['TongTienKhachNhan'] is int) ? (json['TongTienKhachNhan'] as int).toDouble() :
        (json['TongTienKhachNhan'] is double) ? json['TongTienKhachNhan'] : 0.0,
      TongTienThem: (json['TongTienThem'] is int) ? (json['TongTienThem'] as int).toDouble() :
        (json['TongTienThem'] is double) ? json['TongTienThem'] : 0.0,
      TongTienMoi: (json['TongTienMoi'] is int) ? (json['TongTienMoi'] as int).toDouble() :
        (json['TongTienMoi'] is double) ? json['TongTienMoi'] : 0.0,
    );
  }

  //Chuyen doi Object sang Map
  Map<String, dynamic> toMap(Map<String, dynamic> json){
    return {
      'SoLuong':SoLuong,
      'TongCanTong': TongCanTong,
      'Tong_TLthuc': Tong_TLthuc,
      'Tong_TL_HOT': Tong_TL_HOT,
      'TongDinhGia': TongDinhGia,
      'TongTienKhachNhan': TongTienKhachNhan,
      'TongTienThem': TongTienThem,
      'TongTienMoi': TongTienMoi,
    };
  }

}