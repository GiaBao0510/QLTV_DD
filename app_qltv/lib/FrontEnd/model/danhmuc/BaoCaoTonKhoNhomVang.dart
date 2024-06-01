import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';

class BaoCaoTonKhoNhomVang {
  final List<HangHoa> data;
  final String loaiTen;
  final int soLuong;
  final double tongTlThuc;
  final double tongTlHot;
  final double tongTlVang;
  final double tongCongGo;
  final int tongGiaCong;

  BaoCaoTonKhoNhomVang({
    required this.data,
    required this.loaiTen,
    required this.soLuong,
    required this.tongTlThuc,
    required this.tongTlHot,
    required this.tongTlVang,
    required this.tongCongGo,
    required this.tongGiaCong,
  });

  factory BaoCaoTonKhoNhomVang.fromMap(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<HangHoa> dataList = list.map((i) => HangHoa.fromMap(i)).toList();

    return BaoCaoTonKhoNhomVang(
      data: dataList,
      loaiTen: json['sumary']['LOAI_TEN'] ?? '',
      soLuong: json['sumary']['SoLuong'] ?? 0,
      tongTlThuc: (json['sumary']['TongTL_Thuc'] ?? 0).toDouble(),
      tongTlHot: (json['sumary']['TongTL_hot'] ?? 0).toDouble(),
      tongTlVang: (json['sumary']['TongTL_Vang'] ?? 0).toDouble(),
      tongCongGo: (json['sumary']['TongCongGo'] ?? 0).toDouble(),
      tongGiaCong: json['sumary']['TongGiaCong'] ?? 0,
    );
  }
}
