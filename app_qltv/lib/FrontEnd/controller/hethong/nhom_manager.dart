import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NhomManager with ChangeNotifier {
  List<Nhom> _nhoms = [];

  List<Nhom> get nhoms => _nhoms;

  int get nhomsLength => _nhoms.length;

  Future<List<Nhom>> fetchNhoms() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$url/api/groups/'),
      headers: {
        "Content-Type": "application/json",
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );

    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of Nhom objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Nhom> nhomList = jsonList.map((e) => Nhom.fromMap(e)).toList();
      _nhoms = nhomList;
      notifyListeners();
      return nhomList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> addNhom(Nhom nhom) async {
    // Thêm nhom vào backend
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/api/groups/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
      body: jsonEncode(nhom.toMap()),
    );

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _nhoms.add(nhom);
      notifyListeners();
    } else {
      throw Exception('Failed to add nhom');
    }
  }

  Future<Nhom> updateNhom(String groupId, String groupMa, String groupTen,
      bool biKhoa, String lyDoKhoa, bool suDung) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.put(
        Uri.parse('$url/api/groups/$groupId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode(<String, dynamic>{
          'GROUP_MA': groupMa,
          'GROUP_TEN': groupTen,
          'BIKHOA': biKhoa ? 1 : 0,
          'LY_DO_KHOA': lyDoKhoa,
          'SU_DUNG': suDung ? 1 : 0,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng Nhom từ dữ liệu nhận được
        Nhom updatedNhom =
            Nhom.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
        _nhoms = _nhoms
            .map((nhom) => nhom.groupId == groupId ? updatedNhom : nhom)
            .toList();
        notifyListeners();
        return updatedNhom;
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update Nhom: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update Nhom: $error');
    }
  }

  Future<void> deleteNhom(int groupId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('$url/api/groups/$groupId'),
        headers: {
          "Content-Type": "application/json",
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, xóa Nhom khỏi danh sách
        _nhoms.removeWhere((nhom) => nhom.groupId == groupId);
        notifyListeners();
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc xóa thất bại
        throw Exception('Failed to delete Nhom: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc xóa thất bại
      throw Exception('Failed to delete Nhom: $error');
    }
  }
}
