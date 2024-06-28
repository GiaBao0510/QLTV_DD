import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NguoiDungManager with ChangeNotifier {
  List<NguoiDung> _nguoidung = [];

  List<NguoiDung> get nguoidung => _nguoidung;

  int get nguoiDungsLength => _nguoidung.length;
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 1;
  int _totalRows = 0;
 // bool _isLoading = false;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalRows => _totalRows;
    // Method to filter users by groupid
  List<NguoiDung> filterNguoiDungsByGroupId(String groupId) {
    return _nguoidung.where((user) => groupId == user.groupId.toString()).toList();
  }

  // Method to fetch and filter users by groupid
  Future<List<NguoiDung>> fetchAndFilterNguoiDungsByGroupId(String groupId) async {
    await fetchNguoiDungs(); // Fetch all users
    return filterNguoiDungsByGroupId(groupId); // Return filtered list
  }

  Future<List<NguoiDung>> fetchNguoiDungs({int page = 1, int pageSize = 10}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    final response = await http.get(
      Uri.parse('$url/api/users?page=$page&pageSize=$pageSize'),
      headers: {
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );

    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NguoiDung objects
      Map<String,dynamic> json = jsonDecode(response.body);
      List<dynamic> data = json['data'];
      List<NguoiDung> nguoidung = data.map((e) => NguoiDung.fromMap(e)).toList();

      _currentPage = json['page'];
      _totalPages = json['totalPages'];
      _totalRows = json['totalRows'];
      //_isLoading = false;
      notifyListeners();
      return nguoidung; 
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }

  Future<void> addNguoiDung(NguoiDung nguoidung) async {
    // Thêm nhom vào backend
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/api/users/'),
      headers:  <String, String>{
        "Content-Type": "application/json",
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
      body: jsonEncode(nguoidung.toMap()),
    );
    

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _nguoidung.add(nguoidung);
      notifyListeners();
    } else {
      throw Exception('Failed to add nguoi dung');
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.put(
        Uri.parse('$url/api/users/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
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
        _nguoidung = _nguoidung.map((nguoiDung) => nguoiDung.userId == userId ? updatedNguoiDung : nguoiDung).toList();
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

    Future<NguoiDung> deleteNguoiDung(int userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('$url/api/users/$userId'),
        headers: {
          "Content-Type": "application/json",
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode(<String,dynamic>{

        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, xóa NguoiDung khỏi danh sách
        //_nguoidung.removeWhere((nguoiDung) => nguoiDung.userId == userId);
        notifyListeners();
         return NguoiDung.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc xóa thất bại
        throw Exception('Failed to delete NguoiDung: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc xóa thất bại
      throw Exception('Failed to deleteeee NguoiDung: $error');
    }
  }
}
