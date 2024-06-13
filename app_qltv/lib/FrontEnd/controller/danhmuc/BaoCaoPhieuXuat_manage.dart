import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuXuat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaocaophieuxuatManage with ChangeNotifier{

  List<BangBaoCaoPhieuXuat_model> _bangBaoCaoPhieuXuat = [];
  List<BangBaoCaoPhieuXuat_model> get bangBaoCaoPhieuXuat => _bangBaoCaoPhieuXuat;
  int get bangBaoCaoPhieuXuatLenght => _bangBaoCaoPhieuXuat.length;

  Future<List<BangBaoCaoPhieuXuat_model>> LayDuLieuPhieuXuat_test (DateTime ngayBT, DateTime ngayKT) async{
    //Chuyen doi nay bat dau và ngay ket thuc sang dang chuoi
    String StartDay = DateFormat('yyyy-MM-dd').format(ngayBT);
    String EndDay = DateFormat('yyyy-MM-dd').format(ngayKT);

    print("ngày bắt đầu: ${StartDay}");
    print("ngay ket thuc: ${EndDay}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$url/api/phieu/phieuxuat?ngayBD=$StartDay&ngayKT=$EndDay}'),
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

}