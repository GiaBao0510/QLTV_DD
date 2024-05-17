import './loaivang.dart';
import 'package:http/http.dart' as http;

class LoaiVangManager {
  final List<LoaiVang> _items = [
    LoaiVang(
      nhomHangId: 0000000001,
      nhomHangMa: "1",
      nhomChaId: 0,
      nhomTen: "9999",
      donGiaBan: 5500000.00000,
      donGiaMua: 5000000.00000,
      muaBan: false,
      donGiaVon: 6000000.00000,
      donGiaCam: 5000000.00000,
      suDung: false,
      ghiChu: "",
    ),
    LoaiVang(
      nhomHangId: 0000000002,
      nhomHangMa: "2",
      nhomChaId: 1,
      nhomTen: "24",
      donGiaBan: 5500000.00000,
      donGiaMua: 5000000.00000,
      muaBan: false,
      donGiaVon: 6000000.00000,
      donGiaCam: 5000000.00000,
      suDung: false,
      ghiChu: "",
    ),
  ];

  Future<http.Response> fetchLoaiVang() {
    return http.get(Uri.parse('http://localhost:3000/admin/danhsachloaihang'));
  }

  int get itemCount {
    return _items.length;
  }

  List<LoaiVang> get items{
    return [..._items];
  }
}