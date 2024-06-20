
class Khachhang {
  final String? kh_id;
  final String? kh_ma;
  final String? kh_ten;
  final String? kh_cmnd;
  final String? kh_sdt;
  final String? kh_dia_chi;
  final int? kh_su_dung;
  final String? kh_ghi_chu;
  Khachhang({
    this.kh_id,
    this.kh_ma,
    this.kh_ten,
    this.kh_cmnd,
    this.kh_sdt,
    this.kh_dia_chi,
    this.kh_su_dung,
    this.kh_ghi_chu,
  });
  Khachhang copyWith({
    String? kh_id,
    String? kh_ma,
    String? kh_ten,
    String? kh_cmnd,
    String? kh_sdt,
    String? kh_dia_chi,
    int? kh_su_dung,
    String? kh_ghi_chu,
   
  }){
    return Khachhang(
      kh_id: kh_id ?? this.kh_id,
      kh_ma: kh_ma ?? this.kh_ma,
      kh_ten: kh_ten ?? this.kh_ten,
      kh_cmnd: kh_cmnd ?? this.kh_cmnd,
      kh_sdt: kh_sdt ?? this.kh_sdt,
      kh_dia_chi: kh_dia_chi ?? this.kh_dia_chi,
      kh_su_dung: kh_su_dung ?? this.kh_su_dung,
      kh_ghi_chu: kh_ghi_chu ?? this.kh_ghi_chu,
    );
  }

  factory Khachhang.fromMap(Map<String, dynamic> map) {
  return Khachhang(
    kh_id: map['KH_ID'].toString(),  // Ensure KH_ID is treated as String
    kh_ma: map['KH_MA'],
    kh_ten: map['KH_TEN'],
    kh_cmnd: map['CMND'],
    kh_sdt: map['DIEN_THOAI'],
    kh_dia_chi: map['DIA_CHI'],
    kh_su_dung: map['SU_DUNG'],
    kh_ghi_chu: map['GHI_CHU'],
  );
}

   Map<String, dynamic> toMap() {
    return {
      'KH_ID':kh_id,
      'KH_MA':kh_ma,
      'KH_TEN':kh_ten,
      'CMND':kh_cmnd,
      'DIEN_THOAI':kh_sdt,
      'DIA_CHI':kh_dia_chi,
      'SU_DUNG':kh_su_dung,
      'GHI_CHU':kh_ghi_chu,
    };
  }
}
  //  KH_ID                int zerofill not null auto_increment,
  //  KH_MA                varchar(50),
  //  KH_TEN               national varchar(50),
  //  CMND                 national varchar(50),
  //  DIEN_THOAI           varchar(50),
  //  DIA_CHI              national char(100),
  //  SU_DUNG              bool,
  //  GHI_CHU              national varchar(50),
