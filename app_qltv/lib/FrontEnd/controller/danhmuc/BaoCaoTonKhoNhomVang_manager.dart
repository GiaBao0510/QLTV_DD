import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoNhomVang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaoCaoTonKhoNhomVangManager with ChangeNotifier {
  List<BaoCaoTonKhoNhomVang> _baoCaoTonKhoNhomVang = [];

  List<BaoCaoTonKhoNhomVang> get baoCaoTonKhoNhomVang => _baoCaoTonKhoNhomVang;

  int get baoCaoTonKhoNhomVangLength => _baoCaoTonKhoNhomVang.length;

  Future<List<BaoCaoTonKhoNhomVang>> fetchBaoCaoTonKhoNhomVang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .get(Uri.parse('$url/api/admin/baocaotonkhotheonhomvang'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    print(response.body);
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NhomVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BaoCaoTonKhoNhomVang> baoCaoTonKhoNhomVangList =
          jsonList.map((e) => BaoCaoTonKhoNhomVang.fromMap(e)).toList();
      _baoCaoTonKhoNhomVang =
          jsonList.map((e) => BaoCaoTonKhoNhomVang.fromMap(e)).toList();
      notifyListeners();
      return baoCaoTonKhoNhomVangList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
