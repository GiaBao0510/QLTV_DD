// database : nhom_hang

class Kho {
  final String? kho_id;
  final String? kho_ma;
  final String? kho_ten;
  final int? su_dung;

  Kho({
    this.kho_id,
    this.kho_ma,
    this.kho_ten,
    this.su_dung

  });
  Kho copyWith({
    String? kho_id,
    String? kho_ma,
    String? kho_ten,
    int? su_dung,
  }){
    return Kho(
      kho_id: kho_id ?? this.kho_id,
      kho_ma: kho_ma ?? this.kho_ma,
      kho_ten: kho_ten ?? this.kho_ten,
      su_dung: su_dung ?? this.su_dung,
    );
  }
  factory Kho.fromMap(Map<String,dynamic>map){
    return Kho(
      kho_id: map['KHOID'],
      kho_ma: map['KHOMA'],
      kho_ten: map['KHO_TEN'],
      su_dung: map['SU_DUNG'],
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'KHOID': kho_id,
      'KHOMA': kho_ma,
      'KHO_TEN': kho_ten,
      'SU_DUNG': su_dung,
    };
  }
  // KHOID                int zerofill not null auto_increment,
  //  KHOMA                varchar(50),
  //  KHO_TEN              national varchar(50),
  //  SU_DUNG              bool,
  //  primary key (KHOID)
}