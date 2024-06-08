import 'dart:convert';

import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuDoi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaoCaoPhieuDoiManager with ChangeNotifier {
  Future<List<BaoCaoPhieuDoi>> fetchBaoCaoPhieuDoi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$url/api/phieu/phieudoi'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BaoCaoPhieuDoi> baoCaoPhieuDoiList =
          jsonList.map((e) => BaoCaoPhieuDoi.fromMap(e)).toList();
      notifyListeners();
      return baoCaoPhieuDoiList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
