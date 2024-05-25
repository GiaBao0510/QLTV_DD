import 'dart:convert';
import 'dart:io';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';


class HangHoaManager with ChangeNotifier {
  List<HangHoa> _hangHoas = [];

  List<HangHoa> get hangHoas => _hangHoas;

  int get hangHoasLength => _hangHoas.length;

  Future<List<HangHoa>> fetchHangHoas() async {
    try {
      final response = await http.get(Uri.parse('$url/api/admin/danhsachhanghoa'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<HangHoa> hangHoaList = jsonList.map((e) => HangHoa.fromMap(e)).toList();
        _hangHoas = hangHoaList;
        notifyListeners();
        return hangHoaList;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No internet connection');
      } else if (e is HttpException) {
        throw Exception('HTTP error: ${e.message}');
      } else if (e is FormatException) {
        throw Exception('Bad response format');
      } else {
        throw Exception('Error occurred while fetching data: $e');
      }
    }
  }

  Future<void> addHangHoa(HangHoa hangHoa) async {
    final response = await http.post(
      Uri.parse('$url/api/admin/themhanghoa'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(hangHoa.toMap()),
    );

    if (response.statusCode == 200) {
      _hangHoas.add(hangHoa);
      notifyListeners();
    } else {
      throw Exception('Failed to add HangHoa');
    }
  }

  Future<HangHoa> updateHangHoa(String hangHoaMa, HangHoa updatedHangHoa) async {
    try {
      final response = await http.put(
        Uri.parse('$url/api/admin/hanghoa/$hangHoaMa'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedHangHoa.toMap()),
      );

      if (response.statusCode == 200) {
        int index = _hangHoas.indexWhere((hangHoa) => hangHoa.hangHoaMa == hangHoaMa);
        if (index != -1) {
          _hangHoas[index] = updatedHangHoa;
          notifyListeners();
        }
        return HangHoa.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update HangHoa: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update HangHoa: $error');
    }
  }

  Future<void> deleteHangHoa(String hangHoaMa) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/api/admin/hanghoa/$hangHoaMa'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        _hangHoas.removeWhere((hangHoa) => hangHoa.hangHoaMa == hangHoaMa);
        notifyListeners();
      } else {
        throw Exception('Failed to delete HangHoa: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete HangHoa: $error');
    }
  }
}
