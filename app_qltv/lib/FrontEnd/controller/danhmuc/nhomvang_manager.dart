import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';

import 'package:http/http.dart' as http;

class NhomVangManager with ChangeNotifier {
  List<NhomVang> _nhomVangs = [];

  List<NhomVang> get nhomVangs => _nhomVangs;

  int get nhomVangsLength => _nhomVangs.length;

  Future<List<NhomVang>> fetchLoaiHang() async {
    final response =
        await http.get(Uri.parse('$url/api/admin/danhsachloaihang'));

    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NhomVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<NhomVang> nhomVangList =
          jsonList.map((e) => NhomVang.fromMap(e)).toList();
      _nhomVangs = jsonList.map((e) => NhomVang.fromMap(e)).toList();
      notifyListeners();
      return nhomVangList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<NhomVang> getNhomVangById(int loaiId) async {
    try {
      final response =
          await http.get(Uri.parse('$url/api/admin/loaihang/$loaiId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final nhomVang = NhomVang.fromMap(jsonData);
        return nhomVang;
      } else {
        throw Exception('Failed to load nhom vang by id');
      }
    } catch (error) {
      print('Error fetching Loai vang by id: $error');
      throw Exception('Failed to load nhom vang by id');
    }
  }

  Future<void> addNhomVang(NhomVang nhomVang) async {
    // Thêm nhomVang vào backend
    final response = await http.post(
      Uri.parse('$url/api/admin/themloaihang'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'LOAI_TEN': nhomVang.loaiTen,
        'GHI_CHU': nhomVang.ghiChu,
      }),
    );

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _nhomVangs.add(nhomVang);
      notifyListeners();
    } else {
      throw Exception('Failed to add nhomVang');
    }
  }

  Future<NhomVang> updateLoaiHang(int loaiId, String loaiMa, String loaiTen,
      String ghiChu, int suDung) async {
    try {
      final response = await http.put(
        Uri.parse('$url/api/admin/loaihang/$loaiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'LOAIMA': loaiMa,
          'LOAI_TEN': loaiTen,
          'GHI_CHU': ghiChu,
          'SU_DUNG': suDung,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng NhomVang từ dữ liệu nhận được
        notifyListeners();
        return NhomVang.fromMap(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update LoaiHang: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update LoaiHang: $error');
    }
  }

  Future<NhomVang> deleteNhomVang(int loaiId) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/api/admin/loaihang/$loaiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng NhomVang từ dữ liệu nhận được
        notifyListeners();
        return NhomVang.fromMap(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update LoaiHang: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update LoaiHang: $error');
    }
  }
}
