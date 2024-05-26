class Data{
  final String? NHOM_TEN;
  final int? SoLuong;
  final double? TL_Thuc;
  final double? TL_hot;
  final double? TL_vang;
  final double? CONG_GOC;
  final double? GIA_CONG;
  final double? DonGiaBanLoaiVang;
  final double? ThanhTien;

  //Hàm khoi tao
  Data({
    this.NHOM_TEN, this.SoLuong, this.TL_Thuc,
    this.TL_hot, this.TL_vang, this.CONG_GOC, this.GIA_CONG,
    this.DonGiaBanLoaiVang, this.ThanhTien
  });

  //Ham sao chep
  Data copyWith({
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
    return Data(
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
  factory Data.fromMap(Map<String, dynamic> map){
    return Data(
        NHOM_TEN: map['NHOM_TEN'],
        SoLuong: map['SoLuong'],
        TL_Thuc: map['TL_Thuc'],
        TL_hot: map['NHOM_TEN'],
        TL_vang: map['TL_hot'],
        CONG_GOC: map['NHOM_TEN'],
        GIA_CONG: map['CONG_GOC'],
        DonGiaBanLoaiVang: map['DonGiaBanLoaiVang'],
        ThanhTien: map['ThanhTien'],
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

class tinhTong{
  final double? tong_TLThuc;
  final double? tong_CongGoc;
  final double? tong_TLvang;
  final double? tong_TL_hot;
  final double? tong_GiaCong;
  final double? thanhTien;

  tinhTong({
    this.tong_TLThuc, this.tong_CongGoc, this.tong_TL_hot,
    this.tong_TLvang, this.tong_GiaCong, this.thanhTien
  });

  //Ham sao chep
  tinhTong copyWith({
    double? tong_TLThuc,
    double? tong_CongGoc,
    double? tong_TLvang,
    double? tong_TL_hot,
    double? tong_GiaCong,
    double? thanhTien,
  }){
    return tinhTong(
      tong_TLThuc: tong_TLThuc ?? this.tong_TLThuc,
      tong_CongGoc: tong_CongGoc ?? this.tong_CongGoc,
      tong_TLvang: tong_TLvang ?? this.tong_TLvang,
      tong_TL_hot: tong_TL_hot ?? this.tong_TL_hot,
      tong_GiaCong: tong_GiaCong ?? this.tong_GiaCong,
      thanhTien: thanhTien ?? this.thanhTien,
    );
  }

  //Chuyen Object sang Map
  factory tinhTong.fromMap(Map<String, dynamic> map){
    return tinhTong(
      tong_TLThuc: map['tong_TLThuc'],
      tong_CongGoc: map['tong_CongGoc'],
      tong_TLvang: map['tong_TLvang'],
      tong_TL_hot: map['tong_TL_hot'],
      tong_GiaCong: map['tong_GiaCong'],
      thanhTien: map['thanhTien'],
    );
  }

  //Chuyen Map sang Object
  Map<String, dynamic> toMap(){
    return {
      'tong_TLThuc':tong_TLThuc,
      'tong_CongGoc':tong_CongGoc,
      'tong_TLvang':tong_TLvang,
      'tong_TL_hot':tong_TL_hot,
      'tong_GiaCong':tong_GiaCong,
      'thanhTien':thanhTien
    };
  }
}