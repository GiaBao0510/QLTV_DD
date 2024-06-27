
import 'dart:convert';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaocaophieumuaManeger with ChangeNotifier {
  List<BaoCaoPhieuMua> _BaoCaoPhieuMua = [];
  List<BaoCaoPhieuMua> get baoCaoPhieuMua => _BaoCaoPhieuMua;

  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 1;
 // bool _isLoading = false;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  Future<List<BaoCaoPhieuMua>> fecthbaoCaoPhieuMua({int page = 1, int pageSize = 10}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    final response =
        await http.get(Uri.parse('$url/api/phieu/phieumua?page=$page&pageSize=$pageSize'), 
        headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> data = json['data'];
      List<BaoCaoPhieuMua> BaoCaoPhieuMuaList =
          data.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
      //_BaoCaoPhieuMua = jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
      _currentPage = json['page'];
      _totalPages = json['totalPages'];
      notifyListeners();
      return BaoCaoPhieuMuaList;
    } else {
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }
}
