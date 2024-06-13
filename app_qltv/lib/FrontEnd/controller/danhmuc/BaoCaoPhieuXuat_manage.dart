import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuXuat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaocaophieuxuatManage with ChangeNotifier{

  List<BangBaoCaoPhieuXuat_model> _bangBaoCaoPhieuXuat = [];
  List<BangBaoCaoPhieuXuat_model> get bangBaoCaoPhieuXuat => _bangBaoCaoPhieuXuat;
  int get bangBaoCaoPhieuXuatLenght => _bangBaoCaoPhieuXuat.length;

  //1.Load dữ liệu phiếu xuất theo ngày
  Future<List<BangBaoCaoPhieuXuat_model>> LayDuLieuPhieuXuat_test (DateTime ngayBT, DateTime ngayKT,int pages) async{
    //Chuyen doi nay bat dau và ngay ket thuc sang dang chuoi
    String StartDay = DateFormat('yyyy-MM-dd').format(ngayBT);
    String EndDay = DateFormat('yyyy-MM-dd').format(ngayKT);
    String Pages = pages.toString();

    print("ngày bắt đầu: ${StartDay}");
    print("ngay ket thuc: ${EndDay}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$url/api/phieu/phieuxuat?ngayBD=$StartDay&ngayKT=$EndDay&pages=$Pages'),
        headers: {
          "accesstoken": "${prefs.getString('accesstoken')}",
        }
    );
    print(response.body);
    if(response.statusCode == 200){
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BangBaoCaoPhieuXuat_model> BangBaoCaoPhieuXuatList = jsonList.map(
          (e) => BangBaoCaoPhieuXuat_model.fromMap(e)
      ).toList();

      _bangBaoCaoPhieuXuat = jsonList.map((e)=>BangBaoCaoPhieuXuat_model.fromMap(e) ).toList();

      notifyListeners();
      return BangBaoCaoPhieuXuatList;
    }else{
      throw Exception('Failed to load data');
    }
  }
  
  //2.Lấy số lượng phiếu xuất
  Future<int> SoLuongPhieuXuat(DateTime ngayBT, DateTime ngayKT) async{
    String startDay = DateFormat('yyyy-MM-dd').format(ngayBT);
    String endDay = DateFormat('yyyy-MM-dd').format(ngayKT);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    //Truy van
    final res = await http.get(
      Uri.parse('http://localhost:3000/api/phieu/soluongphieuxuat?ngayBD=${startDay}&ngayKT=${endDay}'),
        headers: {
          "accesstoken": "${prefs.getString('accesstoken')}",
        }
    );
    print(res.body);

    //Success
    if(res.statusCode == 200){
      final json = jsonDecode(res.body);
      notifyListeners();
      return json['SoLuongPhieuXuat'] as int;
    }
    //Fall
    else{
      throw Exception('Failed to load data');
      return 0;
    }
  }

  //3. Tinh tong cac thanh phan
  Future<ThongTinTinhTong_model> TinhTongPhieuXuat(DateTime ngayBD, DateTime ngayKT) async{
    String startDay = DateFormat('yyyy-MM-dd').format(ngayBD);
    String endDay = DateFormat('yyyy-MM-dd').format(ngayKT);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final res = await http.get(
      Uri.parse('$url/api/phieu/tinhtongphieuxuat?ngayBD=$startDay&ngayKT=$endDay'),
        headers: {
          "accesstoken": "${prefs.getString('accesstoken')}",
        }
    );

    if(res.statusCode == 200){
      final json = jsonDecode(res.body);
      ThongTinTinhTong_model KetQuaTinhTong = ThongTinTinhTong_model.fromMap(json);
      notifyListeners();
      return KetQuaTinhTong;
    }else{
      throw Exception('Failed to load data');
    }
  }
}