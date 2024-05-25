class BaoCaoTonKhoVang{
  final String? NHOM_TEN;
  final String? SoLuong;
  final String? TL_Thuc;
  final String? TL_hot;
  final String? TL_vang;
  final String? CONG_GOC;
  final String? GIA_CONG;

  BaoCaoTonKhoVang({
    this.NHOM_TEN, this.SoLuong, this.TL_Thuc,
    this.TL_hot, this.TL_vang, this.CONG_GOC, this.GIA_CONG
  });

  BaoCaoTonKhoVang copyWith({
     String? NHOM_TEN,
     String? SoLuong,
     String? TL_Thuc,
     String? TL_hot,
     String? TL_vang,
     String? CONG_GOC,
     String? GIA_CONG
  }){
    return BaoCaoTonKhoVang(
        NHOM_TEN: NHOM_TEN ?? this.NHOM_TEN,
        SoLuong: SoLuong ?? this.SoLuong,
        TL_Thuc: TL_Thuc ?? this.TL_Thuc,
        TL_hot: TL_hot ?? this.TL_hot,
        TL_vang: TL_vang ?? this.TL_vang,
        CONG_GOC: CONG_GOC ?? this.CONG_GOC,
        GIA_CONG: GIA_CONG ?? this.GIA_CONG
    );
  }

  //Phương thức chuyển đổi Map sang đối tượng BaoCaoTonKhoVang
  factory BaoCaoTonKhoVang.fromMap(Map<String, dynamic> map){
    return BaoCaoTonKhoVang(
        NHOM_TEN: map['NHOM_TEN'],
        SoLuong: map['SoLuong'],
        TL_Thuc: map['TL_Thuc'],
        TL_hot: map['TL_hot'],
        TL_vang: map['TL_vang'],
        CONG_GOC: map['CONG_GOC'],
        GIA_CONG: map['GIA_CONG']
    );
  }

  //Phương thức chuyển đổi đói tượng sang MAP
  Map<String, dynamic> toMap(){
    return{
      'NHOM_TEN': NHOM_TEN,
      'SoLuong': SoLuong,
      'TL_Thuc': TL_Thuc,
      'TL_hot': TL_hot,
      'TL_vang': TL_vang,
      'CONG_GOC': CONG_GOC,
      'GIA_CONG': GIA_CONG
    };
  }
}