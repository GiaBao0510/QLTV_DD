import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuXuat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaocaophieuxuatManage with ChangeNotifier{
  List<BaoCaoPhieuXuat_model> _PhieuXuats = [];
  List<BaoCaoPhieuXuat_model> get PhieuXuats => _PhieuXuats;

  int get BaoCaoPhieuXuatLength =>_PhieuXuats.length;

  //Lấy dư liệu
  Future<List<BaoCaoPhieuXuat_model>> fetchBaoCaoPhieuXuat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$url/api/phieu/phieuxuat'),
      headers: {
        "accesstoken": "${prefs.getString('accesstoken')}",
      }
    );
    if(response.statusCode == 200){
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BaoCaoPhieuXuat_model> BaoCaoPhieuXuatList = jsonList.map((e) => BaoCaoPhieuXuat_model.fromMap(e)).toList();
      _PhieuXuats = jsonList.map((e) => BaoCaoPhieuXuat_model.fromMap(e)).toList();

      notifyListeners();
      return BaoCaoPhieuXuatList;
    }else{
      throw Exception('Failed to load data');
    }
  }

  //-----------------------
  List<BangBaoCaoPhieuXuat_model> _bangBaoCaoPhieuXuat = [];
  List<BangBaoCaoPhieuXuat_model> get bangBaoCaoPhieuXuat => _bangBaoCaoPhieuXuat;
  int get bangBaoCaoPhieuXuatLenght => _bangBaoCaoPhieuXuat.length;

  Future<List<BangBaoCaoPhieuXuat_model>> LayDuLieuPhieuXuat_test () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$url/api/phieu/phieuxuat'),
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