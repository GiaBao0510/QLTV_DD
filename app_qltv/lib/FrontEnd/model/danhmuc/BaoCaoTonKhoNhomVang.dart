import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';

class BaoCaoTonKhoNhomVang {
  final List<HangHoa> data;
  final int soLuong;
  final double tongTlThuc;
  final double tongTlHot;
  final double tongTlVang;
  final double tongCongGo;
  final int tongGiaCong;

  BaoCaoTonKhoNhomVang({
    required this.data,
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
      soLuong: json['sumary']['SoLuong:'],
      tongTlThuc: json['sumary']['TongTL_Thuc'].toDouble(),
      tongTlHot: json['sumary']['TongTL_hot'].toDouble(),
      tongTlVang: json['sumary']['TongTL_Vang'].toDouble(),
      tongCongGo: json['sumary']['TongCongGo'].toDouble(),
      tongGiaCong: json['sumary']['TongGiaCong'],
    );
  }
}
