class BaoCaoPhieuDoi {
  final String? maPhieu;
  final double? triGiaBan;
  final double? triGiaMua;
  final double? thanhToan;

  BaoCaoPhieuDoi({
    this.maPhieu,
    this.triGiaBan,
    this.triGiaMua,
    this.thanhToan,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'TRI_GIA_BAN': triGiaBan,
  //     'TRI_GIA_MUA': triGiaMua,
  //     'THANH_TOAN': thanhToan,
  //   };
  // }

  factory BaoCaoPhieuDoi.fromMap(Map<String, dynamic> map) {
    return BaoCaoPhieuDoi(
      maPhieu: map['PHIEU_DOI_MA'].toString(),
      triGiaBan: (map['TRI_GIA_BAN'] is int
              ? map['TRI_GIA_BAN'].toDouble()
              : map['TRI_GIA_BAN']) ??
          0.0,
      triGiaMua: (map['TRI_GIA_MUA'] is int
              ? map['TRI_GIA_MUA'].toDouble()
              : map['TRI_GIA_MUA']) ??
          0.0,
      thanhToan: (map['THANH_TOAN'] is int
              ? map['THANH_TOAN'].toDouble()
              : map['THANH_TOAN']) ??
          0.0,
    );
  }
}
