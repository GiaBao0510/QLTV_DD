import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../model/danhmuc/BaoCaoTonKhoLoaiVang.dart';

class BaocaotonkholoaivangManager with ChangeNotifier {

  //Trả về danh sách thông tin
  Future<List<dynamic>> fetchBaoCaoTonKhoTheoLoaiVang()async{
    final res = await http.get(Uri.parse('$url/api/admin/baocaotonkholoaivang'),headers: {"Content-Type": "application/json"} );
    if(res.statusCode == 200){
      List<dynamic> list = jsonDecode(res.body);
      notifyListeners();
      return list;
    }else{
      throw Exception('Failed to load data');
    }
  }
}