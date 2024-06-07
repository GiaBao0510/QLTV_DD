import 'dart:convert';

import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCao_KhoVangMuaVao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class KhoVangMuaVaoManager with ChangeNotifier {
  // List<KhoVangMuaVao> _khoVangMuaVao = [];

  // List<KhoVangMuaVao> get khoVangMuaVao => _khoVangMuaVao;

  // int get khoVangMuaVaoLength => _khoVangMuaVao.length;

  Future<List<KhoVangMuaVao>> fecthKhoVangMuaVao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$url/api/phieu/khovangmuavao'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<KhoVangMuaVao> khoVangMuaVaoList =
          jsonList.map((e) => KhoVangMuaVao.fromMap(e)).toList();
      // _khoVangMuaVao = jsonList.map((e) => KhoVangMuaVao.fromMap(e)).toList();
      notifyListeners();
      return khoVangMuaVaoList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
