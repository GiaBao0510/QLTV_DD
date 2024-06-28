import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_qltv/FrontEnd/model/GiaoDich/BanVang_model.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

class BanvangController with ChangeNotifier{
  
  //Lấy thong tin hang hoa
  Future<TruocKhiThucHienBanVang_model> ThongTinSanPham() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.get(
      Uri.parse('$url/api/giaodich/kiemtramahanghoa?HANGHOAMA=${ThuVienUntilState.maHangHoa}'),
      headers: {
        "accesstoken": "${prefs.getString('accesstoken')}",
      }
    );

    List<dynamic> json = jsonDecode(res.body);
    List<TruocKhiThucHienBanVang_model> thongTinHangHoa = json.map((e) => TruocKhiThucHienBanVang_model.fromMap(e)).toList();

    if (res.statusCode == 200){
      notifyListeners();
      return thongTinHangHoa.first;
    }else{
      throw Exception('${thongTinHangHoa.first}');
    }
  }
  
  //Thực hiện giao dịch bán vàng
  Future<void> ThucHienGiaoDichBanVang(SauKhiThucHienBangVang_model giaoDich) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        Uri.parse('$url/api/giaodich/giaodichbanvang'),
        body: jsonEncode(<String,dynamic>{
          "KH_ID": giaoDich.KH_ID,
          "TONG_TIEN":giaoDich.TONG_TIEN,
          "KHACH_DUA":giaoDich.KHACH_DUA,
          "THOI_LAI":giaoDich.THOI_LAI,
          "TONG_SL":1,
          "CAN_TONG":giaoDich.CAN_TONG,
          "TL_HOT":giaoDich.TL_HOT,
          "GIA_CONG":giaoDich.GIA_CONG,
          "TIEN_BOT":giaoDich.TIEN_BOT,
          "THANH_TOAN":giaoDich.THANH_TOAN,
          "HANGHOAID":giaoDich.HANGHOAID,
          "HANGHOAMA":giaoDich.HANGHOAMA,
          "HANG_HOA_TEN":"Nhan34",
          "SO_LUONG":1,
          "DON_GIA":giaoDich.DON_GIA,
          "THANH_TIEN":giaoDich.THANH_TIEN,
          "NHOMHANGID":giaoDich.NHOMHANGID,
          "LOAIVANG":giaoDich.LOAIVANG
        })
    );

    if(res.statusCode == 200){
      print('Thực hiện giao dịch bán vàng thành công.');
      notifyListeners();
    }else{
      throw Exception('Lỗi khi thực hiện giao dịch bán vàng');
    }
  }
}