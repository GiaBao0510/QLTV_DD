import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhacungcap.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NhaCungCapManager with ChangeNotifier {
  List<NhaCungCap> _nhaCungCaps = [];

  List<NhaCungCap> get nhaCungCaps => _nhaCungCaps;

  int get nhaCungCapsLength => _nhaCungCaps.length;

  Future<List<NhaCungCap>> fetchNhaCungCap() async {
    //Lay acctoken hien da luu ơ phan dang nhap
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse('$url/api/admin/danhsachnhacungcap'),
      headers:{
        'Content-Type': 'application/json',
        "accesstoken": "${prefs.getString('accesstoken')}",
      }
    );
    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<NhaCungCap> nhaCungCapList = jsonList.map((e) => NhaCungCap.fromMap(e)).toList();
        _nhaCungCaps = nhaCungCapList;
        notifyListeners();
        return nhaCungCapList;
      } catch (e) {
        print('Error occurred while mapping data: $e');
        return [];
      }
    } else {
      print('Không có quyền truy cập');
      throw Exception('Failed to load data');
    }
  }

  Future<void> addNhaCungCap(NhaCungCap nhaCungCap) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/api/admin/themnhacungcap'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
      body: jsonEncode({
        'NCC_TEN': nhaCungCap.ncc_ten,
        'GHI_CHU': nhaCungCap.ghi_chu,
        'NGAYBD': nhaCungCap.ngay_bd,
      }),
    );

    if (response.statusCode == 200) {
      _nhaCungCaps.add(nhaCungCap);
      notifyListeners();
    } else {
      throw Exception('Failed to add NhaCungCap');
    }
  }

  Future<NhaCungCap> updateNhaCungCap(String nccMa, String nccTen, String ghiChu, String ngayBd) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.put(
        Uri.parse('$url/api/admin/nhacungcap/$nccMa'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode({
          'NCC_TEN': nccTen,
          'GHI_CHU': ghiChu,
          'NGAYBD': ngayBd,
        }),
      );

      if (response.statusCode == 200) {
        notifyListeners();
        return NhaCungCap.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update NhaCungCap: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update NhaCungCap: $error');
    }
  }

  Future<void> deleteNhaCungCap(int nccMa) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('$url/api/admin/nhacungcap/$nccMa'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
      );

      if (response.statusCode == 200) {
        _nhaCungCaps.removeWhere((nhaCungCap) => nhaCungCap.ncc_ma == nccMa);
        notifyListeners();
      } else {
        throw Exception('Failed to delete NhaCungCap: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete NhaCungCap: $error');
    }
  }
}
