import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/danhmuc/donvi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonviManage with ChangeNotifier {
  List<Donvi> _donvi = [];

  List<Donvi> get donvi => _donvi;

  int get donviLength => _donvi.length;

  // if (response.statusCode == 200) {
  //   final List<dynamic> data = json.decode(response.body);

  //   return data.map((item) => Donvi.fromMap(item)).toList();
  Future<List<Donvi>> fetchDonvi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$url/api/phieu/khovangmuavao'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of Donvi objects
      // List<dynamic> jsonList = jsonDecode(response.body);
      // List<Donvi> donviList = jsonList.map((e) => Donvi.fromMap(e)).toList();
      // _donvi = jsonList.map((e) => Donvi.fromMap(e)).toList();
      // notifyListeners();
      // return donviList;
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => Donvi.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addDonvi(Donvi donvi) async {
    // Thêm Donvi vào backend
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/api/admin/themNSdonvi/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
      body: jsonEncode(<String, dynamic>{
        'DON_VI_TEN': donvi.dvi_ten,
        'GHI_CHU': donvi.dvi_ghichu,
        'DON_VI_TEN_HD': donvi.dvi_ten_hd,
        'DIA_CHI_HD': donvi.dvi_dia_chi_hd,
        'DIEN_THOAI': donvi.dvi_sdt,
        'TEN_GIAO_DICH': donvi.dvi_ten_gd,
        'TAO_LUU_Y': donvi.dvi_luu_y,
        'SU_DUNG': 1,
      }),
    );

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _donvi.add(donvi);
      notifyListeners();
    } else {
      throw Exception('Failed to add donvi');
    }
  }

  Future<Donvi> updateDonvi(int dvi_id, Donvi donvi) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.put(
        Uri.parse('$url/api/admin/nsDonVi/$dvi_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode(<String, dynamic>{
          'DON_VI_TEN': donvi.dvi_ten,
          'GHI_CHU': donvi.dvi_ghichu,
          'DON_VI_TEN_HD': donvi.dvi_ten_hd,
          'DIA_CHI_HD': donvi.dvi_dia_chi_hd,
          'DIEN_THOAI': donvi.dvi_sdt,
          'TEN_GIAO_DICH': donvi.dvi_ten_gd,
          'TIEU_DE_PHIEU_BAN': donvi.dvi_tde_pban,
          'TAO_LUU_Y': donvi.dvi_luu_y,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng dvi từ dữ liệu nhận được
        notifyListeners();
        return Donvi.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update Donvi: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update Donvi: $error');
    }
  }

  Future<Donvi> deleteDonvi(int dvi_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('$url/api/admin/nsDonVi/$dvi_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng dvi từ dữ liệu nhận được
        notifyListeners();
        return Donvi.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update Donvi: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update Donvi: $error');
    }
  }
}
