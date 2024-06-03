class BaoCaoTonKhoVang_Model{
  final String NHOM_TEN;
  final int SoLuong;
  final double TL_Thuc;
  final double TL_hot;
  final double TL_vang;
  final double CONG_GOC;
  final double GIA_CONG;
  final double DonGiaBanLoaiVang;
  final double ThanhTien;

  //Hàm khoi tao
  BaoCaoTonKhoVang_Model({
    required this.NHOM_TEN, required this.SoLuong,
    required this.TL_Thuc, required this.TL_hot,
    required this.TL_vang, required this.CONG_GOC,
    required this.GIA_CONG, required this.DonGiaBanLoaiVang,
    required this.ThanhTien
  });

  //Ham sao chep
  BaoCaoTonKhoVang_Model copyWith({
   String? NHOM_TEN,
   int? SoLuong,
   double? TL_Thuc,
   double? TL_hot,
   double? TL_vang,
   double? CONG_GOC,
   double? GIA_CONG,
   double? DonGiaBanLoaiVang,
   double? ThanhTien
  }){
    return BaoCaoTonKhoVang_Model(
        NHOM_TEN: NHOM_TEN ?? this.NHOM_TEN,
        SoLuong: SoLuong ?? this.SoLuong,
        TL_Thuc: TL_Thuc ?? this.TL_Thuc,
        TL_hot: TL_hot ?? this.TL_hot,
        TL_vang: TL_vang ?? this.TL_vang,
        CONG_GOC: CONG_GOC ?? this.CONG_GOC,
        GIA_CONG: GIA_CONG ?? this.GIA_CONG,
        DonGiaBanLoaiVang: DonGiaBanLoaiVang ?? this.DonGiaBanLoaiVang,
        ThanhTien : ThanhTien ?? this.ThanhTien,
    );
  }

  //Phương thức chuyển Map sang Object
  factory BaoCaoTonKhoVang_Model.fromMap(Map<String, dynamic> map){
    return BaoCaoTonKhoVang_Model(
        NHOM_TEN: map['NHOM_TEN'] ?? '',
        SoLuong: (map['SoLuong'] is int) ? map['SoLuong'] : 0,
        TL_Thuc: (map['TL_Thuc'] is int) ?
          (map['TL_Thuc'] as int).toDouble() : (map['TL_Thuc'] is double) ?
          map['TL_Thuc'] : 0.0,
        TL_hot: (map['TL_hot'] is int) ?
          (map['TL_hot'] as int).toDouble() : (map['TL_hot'] is double)?
          map['TL_hot'] : 0.0,
        TL_vang: (map['TL_vang'] is int) ?
          (map['TL_vang'] as int).toDouble() : (map['TL_vang'] is double)?
          map['TL_vang'] : 0.0,
        CONG_GOC: (map['CONG_GOC'] is int) ?
          (map['CONG_GOC'] as int).toDouble() : (map['CONG_GOC'] is double)?
          map['CONG_GOC'] : 0.0,
        GIA_CONG: (map['GIA_CONG'] is int) ?
          (map['GIA_CONG'] as int).toDouble() : (map['GIA_CONG'] is double)?
          map['GIA_CONG'] : 0.0,
        DonGiaBanLoaiVang: (map['DonGiaBanLoaiVang'] is int) ?
          (map['DonGiaBanLoaiVang'] as int).toDouble() : (map['DonGiaBanLoaiVang'] is double)?
          map['DonGiaBanLoaiVang'] : 0.0,
        ThanhTien: (map['ThanhTien'] is int) ?
          (map['ThanhTien'] as int).toDouble() : (map['ThanhTien'] is double)?
          map['ThanhTien'] : 0.0,
    );
  }

  //Phương thướt chuyển object sang Map
  Map<String, dynamic> toMap(){
    return{
      "NHOM_TEN":NHOM_TEN,
      'SoLuong':SoLuong,
      'TL_Thuc':TL_Thuc,
      'TL_hot':TL_hot,
      'TL_vang':TL_vang,
      'CONG_GOC':CONG_GOC,
      'GIA_CONG': GIA_CONG,
      'DonGiaBanLoaiVang':DonGiaBanLoaiVang,
      'ThanhTien':ThanhTien
    };
  }
}