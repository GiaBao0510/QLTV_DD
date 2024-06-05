import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';

class NguoiDungManager with ChangeNotifier {
  List<NguoiDung> _nguoiDungs = [];

  List<NguoiDung> get nguoiDungs => _nguoiDungs;

  int get nguoiDungsLength => _nguoiDungs.length;

    // Method to filter users by groupid
  List<NguoiDung> filterNguoiDungsByGroupId(String groupId) {
    return _nguoiDungs.where((user) => groupId == user.groupId.toString()).toList();
  }

  // Method to fetch and filter users by groupid
  Future<List<NguoiDung>> fetchAndFilterNguoiDungsByGroupId(String groupId) async {
    await fetchNguoiDungs(); // Fetch all users
    return filterNguoiDungsByGroupId(groupId); // Return filtered list
  }

  // List<NguoiDung> filterNguoiDung (String groupId){
  //   return _nguoiDungs.where((nguoidung) => nguoidung.groupId.toString() == groupId).toList();
  // }

  // bool get isDataLoaded => _nguoiDungs.isNotEmpty;

  Future<List<NguoiDung>> fetchNguoiDungs() async {
    final response = await http.get(Uri.parse('$url/api/users/'));

    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NguoiDung objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<NguoiDung> nguoiDungList = jsonList.map((e) => NguoiDung.fromMap(e)).toList(); 
      _nguoiDungs = nguoiDungList;
      notifyListeners();
      return nguoiDungList;    
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> addNguoiDung(NguoiDung nguoidung) async {
    // Thêm nhom vào backend
    final response = await http.post(
      Uri.parse('$url/api/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(nguoidung.toMap()),
    );

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _nguoiDungs.add(nguoidung);
      notifyListeners();
    } else {
      throw Exception('Failed to add nhom');
    }
  }

  Future<NguoiDung> updateNguoiDung(
      int userId,
      int groupId,
      String userMa,
      String userTen,
      String matKhau,
      bool biKhoa,
      String lyDoKhoa,
      DateTime ngayTao,
      bool suDung,
    ) async {
    try {
      final response = await http.put(
        Uri.parse('$url/api/users/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'USER_ID': userId,
          'GROUP_ID': groupId,
          'USER_MA': userMa,
          'USER_TEN': userTen,
          'MAT_KHAU': matKhau,
          'BIKHOA': biKhoa ? 1 : 0,
          'LY_DO_KHOA': lyDoKhoa,
          'NGAY_TAO': ngayTao.toIso8601String(),
          'SU_DUNG': suDung ? 1 : 0,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng NguoiDung từ dữ liệu nhận được
        NguoiDung updatedNguoiDung = NguoiDung.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
        _nguoiDungs = _nguoiDungs.map((nguoiDung) => nguoiDung.userId == userId ? updatedNguoiDung : nguoiDung).toList();
        notifyListeners();
        return updatedNguoiDung;
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update NguoiDung: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update NguoiDung: $error');
    }
  }

    Future<void> deleteNguoiDung(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/api/users/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, xóa NguoiDung khỏi danh sách
        _nguoiDungs.removeWhere((nguoiDung) => nguoiDung.userId == userId);
        notifyListeners();
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc xóa thất bại
        throw Exception('Failed to delete NguoiDung: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc xóa thất bại
      throw Exception('Failed to delete NguoiDung: $error');
    }
  }
}
