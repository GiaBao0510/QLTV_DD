import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NguoiDungManager with ChangeNotifier {
  List<NguoiDung> _nguoiDungs = [];

  List<NguoiDung> get nguoiDungs => _nguoiDungs;

  int get nguoiDungsLength => _nguoiDungs.length;

  Future<List<NguoiDung>> fetchNguoiDungs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$url/api/users/'),
      headers: {
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );

    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NguoiDung objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<NguoiDung> nguoiDungList =
          jsonList.map((e) => NguoiDung.fromJson(e)).toList();
      _nguoiDungs = nguoiDungList;
      notifyListeners();
      return nguoiDungList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  void addNguoiDung(NguoiDung nguoiDung) {
    _nguoiDungs.add(nguoiDung);
    notifyListeners();
  }

  void updateNguoiDung(NguoiDung updatedNguoiDung) {
    final index = _nguoiDungs
        .indexWhere((nguoiDung) => nguoiDung.userId == updatedNguoiDung.userId);
    if (index != -1) {
      _nguoiDungs[index] = updatedNguoiDung;
      notifyListeners();
    }
  }

  void deleteNguoiDung(int userId) {
    _nguoiDungs.removeWhere((nguoiDung) => nguoiDung.userId == userId);
    notifyListeners();
  }
}
