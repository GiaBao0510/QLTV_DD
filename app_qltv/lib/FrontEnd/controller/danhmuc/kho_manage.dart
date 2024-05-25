import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/danhmuc/kho.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';

class KhoManage with ChangeNotifier {
  List<Kho> _kho = [];

  List<Kho> get kho => _kho;

  int get khoLength => _kho.length;

  Future<List<Kho>> fetchKho() async {
    final response = await http.get(Uri.parse('$url/api/admin/danhsachkho/'));
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NhomVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Kho> khoList = jsonList.map((e) => Kho.fromMap(e)).toList(); 
      _kho = jsonList.map((e) => Kho.fromMap(e)).toList();
      notifyListeners();
      return khoList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
// kho_id,
//     this.kho_ma,
//     this.kho_ten,
//     this.su_dung
  Future<Kho> updateKho(int kho_id,Kho kho) async {
    try {
      final response = await http.put(
        Uri.parse('$url/api/admin/kho/$kho_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'KHO_TEN': kho.kho_ten,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng kho từ dữ liệu nhận được
        notifyListeners();
        return Kho.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update Kho: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update Kho: $error');
    }
  }

  Future<Kho> deleteKho(int kho_id) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/api/admin/kho/$kho_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng Kho từ dữ liệu nhận được
        notifyListeners();
        return Kho.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update Kho: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update Kho: $error');
    }
  }

}
