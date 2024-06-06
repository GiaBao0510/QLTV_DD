import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoLoaiVang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class BaoCaoTonKhoLoaiVangManager with ChangeNotifier {
  List<BaoCaoTonKhoLoaiVang> _baoCaoTonKhoLoaiVang = [];

  List<BaoCaoTonKhoLoaiVang> get baoCaoTonKhoLoaiVang => _baoCaoTonKhoLoaiVang;

  int get baoCaoTonKhoLoaiVangLength => _baoCaoTonKhoLoaiVang.length;

  Future<List<BaoCaoTonKhoLoaiVang>> fetchBaoCaoTonKhoLoaiVang() async {
    final response =
        await http.get(Uri.parse('$url/api/admin/baocaotonkholoaivang'));
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of LoaiVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BaoCaoTonKhoLoaiVang> baoCaoTonKhoLoaiVangList =
          jsonList.map((e) => BaoCaoTonKhoLoaiVang.fromMap(e)).toList();
      _baoCaoTonKhoLoaiVang =
          jsonList.map((e) => BaoCaoTonKhoLoaiVang.fromMap(e)).toList();
      notifyListeners();
      return baoCaoTonKhoLoaiVangList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
