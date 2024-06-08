import 'dart:convert';

import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/main.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/hethong/ketnoi.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:session_manager/session_manager.dart';

class KetnoiManager with ChangeNotifier{

  Future<KetNoi> fetchketnoi() async {
    try {
      final response = await http.get(Uri.parse('$url/api/db/dbinfo'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return KetNoi.fromMap(json);
      } else {
        throw Exception('Failed to load database config');
      }
    } catch (e) {
      throw Exception('Error fetching database config: $e');
    }
  }

  Future<void> updateketnoi(BuildContext context,KetNoi newConfig) async {
    try {
      final Map<String, dynamic> json = newConfig.toMap();
      final response = await http.put(
        Uri.parse('$url/api/db/dbinfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        // Database configuration updated successfully
        notifyListeners();
        await Logout(context);
      } else {
        throw Exception('Failed to update database config');
      }
    } catch (e) {
      throw Exception('Error updating database config: $e');
    }
  }

  Future<void> Logout(BuildContext context) async {
    try {
      String path = logout; // Đảm bảo đường dẫn này đúng
      var res = await http.post(Uri.parse(path), headers: {"Content-Type": "application/json"});
      print(res.body);

      SessionManager().setString('username', '');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Đăng xuất thành công",
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp())
      );
    } catch (e) {
      print('Lỗi khi thực hiện đăng xuất: $e');
    }
  }
}