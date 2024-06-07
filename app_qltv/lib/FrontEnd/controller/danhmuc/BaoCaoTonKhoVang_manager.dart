import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoVang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaocaotonkhovangManager with ChangeNotifier {
  //Data
  List<BaoCaoTonKhoVang_Model> _BaoCaoTonKhoVang = [];
  List<BaoCaoTonKhoVang_Model> get baoCaoTonKhoVang => _BaoCaoTonKhoVang;
  int get baoCaoTonKhoVang_lenght => _BaoCaoTonKhoVang.length;

  Future<List<BaoCaoTonKhoVang_Model>> fetchBaoCaoTonKhoVang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res =
        await http.get(Uri.parse('$url/api/admin/baocaotonkho'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });

    if (res.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(res.body);
      List<BaoCaoTonKhoVang_Model> baocaotonkhovangList =
          jsonList.map((e) => BaoCaoTonKhoVang_Model.fromMap(e)).toList();
      _BaoCaoTonKhoVang =
          jsonList.map((e) => BaoCaoTonKhoVang_Model.fromMap(e)).toList();

      notifyListeners();
      return baocaotonkhovangList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
