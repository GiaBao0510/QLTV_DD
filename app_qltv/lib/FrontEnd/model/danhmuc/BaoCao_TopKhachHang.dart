class TopKhachHang {
  final String? tenKH;
  final double? tongTien;

  TopKhachHang({this.tenKH, this.tongTien});

  factory TopKhachHang.fromMap(Map<String, dynamic> map) {
    return TopKhachHang(
      tenKH: map['KH_TEN'] ?? 'unknow',
      tongTien: (map['KH_TONG_TIEN'] is int
              ? map['KH_TONG_TIEN'].toDouble()
              : map['KH_TONG_TIEN']) ??
          0.0,
    );
  }
}
