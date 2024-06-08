import 'dart:convert';

import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/hethong/ketnoi.dart';
import 'package:http/http.dart' as http;

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

  Future<void> updateketnoi(KetNoi newConfig) async {
    try {
      final Map<String, dynamic> json = newConfig.toMap();
      final response = await http.post(
        Uri.parse('$url/api/db/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        // Database configuration updated successfully
        notifyListeners();
      } else {
        throw Exception('Failed to update database config');
      }
    } catch (e) {
      throw Exception('Error updating database config: $e');
    }
  }
}