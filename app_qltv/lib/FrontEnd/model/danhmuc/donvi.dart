
class Donvi {
  final String? dvi_id;
  final String? dvi_ma;
  final String? dvi_ten;
  final int? dvi_su_dung;
  final String? dvi_ghichu;
  final String? dvi_ten_hd;
  final String? dvi_dia_chi_hd;
  final String? dvi_sdt;
  final String? dvi_ten_gd;
  final String? dvi_luu_y;
  final String? dvi_tde_pcam;
  final String? dvi_tde_pban;
  final String? dvi_gioi_thieu;
  Donvi({
    this.dvi_id,
    this.dvi_ma,
    this.dvi_ten,
    this.dvi_su_dung,
    this.dvi_ghichu,
    this.dvi_ten_hd,
    this.dvi_dia_chi_hd,
    this.dvi_sdt,
    this.dvi_ten_gd,
    this.dvi_luu_y,
    this.dvi_tde_pcam,
    this.dvi_tde_pban,
    this.dvi_gioi_thieu,

  });
  Donvi copyWith({
    String? dvi_id,
    String? dvi_ma,
    String? dvi_ten,
    int? dvi_su_dung,
    String? dvi_ghichu,
    String? dvi_ten_hd,
    String? dvi_dia_chi_hd,
    String? dvi_sdt,
    String? dvi_ten_gd,
    String? dvi_luu_y,
    String? dvi_tde_pcam,
    String? dvi_tde_pban,
    String? dvi_gioi_thieu,
  }){
    return Donvi(
      dvi_id: dvi_id ?? this.dvi_id,
      dvi_ma: dvi_ma ?? this.dvi_ma,
      dvi_ten: dvi_ten ?? this.dvi_ten,
      dvi_su_dung: dvi_su_dung ?? this.dvi_su_dung,
      dvi_ghichu: dvi_ghichu ?? this.dvi_ghichu,
      dvi_ten_hd: dvi_ten_hd ?? this.dvi_ten_hd,
      dvi_dia_chi_hd: dvi_dia_chi_hd ?? this.dvi_dia_chi_hd,
      dvi_sdt: dvi_sdt ?? this.dvi_sdt,
      dvi_ten_gd: dvi_ten_gd ?? this.dvi_ten_gd,
      dvi_luu_y: dvi_luu_y ?? this.dvi_luu_y,
      dvi_tde_pcam: dvi_tde_pcam ?? this.dvi_tde_pcam,
      dvi_tde_pban: dvi_tde_pban ?? this.dvi_tde_pban,
      dvi_gioi_thieu: dvi_gioi_thieu ?? this.dvi_gioi_thieu,
    );
  }

  factory Donvi.fromMap(Map<String, dynamic> map) {
  return Donvi(
    dvi_id: map['DON_VI_ID'].toString(),  // Chuyển đổi ID thành chuỗi
    dvi_ma: map['DON_VI_MA'],
    dvi_ten: map['DON_VI_TEN'],
    dvi_su_dung: map['SU_DUNG'],
    dvi_ghichu: map['GHI_CHU'],
    dvi_ten_hd: map['DON_VI_TEN_HD'],
    dvi_dia_chi_hd: map['DIA_CHI_HD'],
    dvi_sdt: map['DIEN_THOAI'],
    dvi_ten_gd: map['TEN_GIAO_DICH'],
    dvi_luu_y: map['TAO_LUU_Y'],
    dvi_tde_pcam: map['TIEU_DE_PHIEU_CAM'],
    dvi_tde_pban: map['TIEU_DE_PHIEU_BAN'],
    dvi_gioi_thieu: map['GIOI_THIEU'],
  );
}

   Map<String, dynamic> toMap() {
    return {
      'DON_VI_ID':dvi_id,
      'DON_VI_MA':dvi_ma,
      'DON_VI_TEN':dvi_ten,
      'SU_DUNG':dvi_su_dung,
      'GHI_CHU':dvi_ghichu,
      'DON_VI_TEN_HD':dvi_ten_hd,
      'DIA_CHI_HD':dvi_dia_chi_hd,
      'DIEN_THOAI':dvi_sdt,
      'TEN_GIAO_DICH':dvi_ten_gd,
      'TAO_LUU_Y':dvi_luu_y,
      'TIEU_DE_PHIEU_CAM':dvi_tde_pcam,
      'TIEU_DE_PHIEU_BAN':dvi_tde_pban,
      'GIOI_THIEU':dvi_gioi_thieu,
    };
  }
}

//  DON_VI_ID            int not null auto_increment,
//    DON_VI_MA            varchar(50),
//    DON_VI_TEN           national varchar(50),
//    SU_DUNG              bool,
//    GHI_CHU              national varchar(50),
//    DON_VI_TEN_HD        varchar(100),
//    DIA_CHI_HD           varchar(100),
//    DIEN_THOAI           varchar(50),
//    TEN_GIAO_DICH        varchar(50),
//    TAO_LUU_Y            varchar(150),
//    TIEU_DE_PHIEU_CAM    varchar(100),
//    TIEU_DE_PHIEU_BAN    varchar(100),
//    GIOI_THIEU           varchar(100),