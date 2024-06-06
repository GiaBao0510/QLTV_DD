import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../model/danhmuc/loaivang.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:http/http.dart' as http;

class LoaiVangManager with ChangeNotifier {
  List<LoaiVang> _loaiVangs = [];

  List<LoaiVang> get loaiVangs => _loaiVangs;

  int get loaiVangsLength => _loaiVangs.length;

  Future<List<LoaiVang>> fetchLoaiHang() async {
    final response = await http.get(Uri.parse('$url/api/productType/'));
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NhomVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<LoaiVang> loaiVangList =
          jsonList.map((e) => LoaiVang.fromMap(e)).toList();
      _loaiVangs = jsonList.map((e) => LoaiVang.fromMap(e)).toList();
      notifyListeners();
      return loaiVangList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<LoaiVang> getLoaiVangById(int loaiId) async {
    try {
      final response =
          await http.get(Uri.parse('$url/api/productType/$loaiId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final loaiVang = LoaiVang.fromMap(jsonData);
        return loaiVang;
      } else {
        throw Exception('Failed to load nhom vang by id');
      }
    } catch (error) {
      print('Error fetching Loai vang by id: $error');
      throw Exception('Failed to load nhom vang by id');
    }
  }

  Future<void> addLoaiVang(LoaiVang loaiVang) async {
    // Thêm loaiVang vào backend
    final response = await http.post(
      Uri.parse('$url/api/productType/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'NHOM_TEN': loaiVang.nhomTen,
        'DON_GIA_VON': loaiVang.donGiaVon,
        'DON_GIA_MUA': loaiVang.donGiaMua,
        'DON_GIA_BAN': loaiVang.donGiaBan,
        'DON_GIA_CAM': loaiVang.donGiaCam,
        'GHI_CHU': loaiVang.ghiChu,
        'MUA_BAN': 0,
        'SU_DUNG': 1,
        'NHOMCHAID': loaiVang.nhomChaId,
      }),
    );

    if (response.statusCode == 200) {
      // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
      _loaiVangs.add(loaiVang);
      notifyListeners();
    } else {
      throw Exception('Failed to add loaiVang');
    }
  }

  Future<void> updateLoaiVang(int loaiId, LoaiVang loaiVang) async {
    try {
      final response = await http.put(
        Uri.parse('$url/api/productType/$loaiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'NHOM_TEN': loaiVang.nhomTen,
          'DON_GIA_VON': loaiVang.donGiaVon,
          'DON_GIA_MUA': loaiVang.donGiaMua,
          'DON_GIA_BAN': loaiVang.donGiaBan,
          'DON_GIA_CAM': loaiVang.donGiaCam,
          'GHI_CHU': loaiVang.ghiChu,
          'NHOMCHAID': loaiVang.nhomChaId,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng NhomVang từ dữ liệu nhận được
        notifyListeners();
        // print('Status 200!');
        // print(response.body);
        // return LoaiVang.fromMap(
        //     jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update LoaiHang: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      print('Error updating LoaiVang: $error');
      throw Exception('Failed to update LoaiHang: $error');
    }
  }

  Future<void> deleteLoaiVang(String loaiId) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/api/productType/$loaiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng LoaiVang từ dữ liệu nhận được
        notifyListeners();
        // return LoaiVang.fromMap(
        // jsonDecode(response.body) as Map<String, dynamic>);
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
