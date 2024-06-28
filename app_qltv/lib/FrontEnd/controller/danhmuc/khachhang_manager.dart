import 'dart:convert';
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhachhangManage with ChangeNotifier {
  List<Khachhang> _khachhang = [];
  List<Khachhang> get khachhang => _khachhang;
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 1;
  int _totalKhachhang = 0;
  int _totalRows = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalKhachhang => _totalKhachhang;
  int get totalRows => _totalRows;


  Future<List<Khachhang>> fetchKhachhang({int page = 1, int pageSize = 10}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();

    final response = await http.get(
      Uri.parse("$url/api/admin/danhsachkhachhang?page=$page&pageSize=$pageSize"),
      headers: {
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> data = json['data'];
      List<Khachhang> khachhang = data.map((e) => Khachhang.fromMap(e)).toList();

      _currentPage = json['page'];
      _totalPages = json['totalPages'];
      _totalRows = json['totalRows'];
      notifyListeners();
      return khachhang;
    } else {
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }

Future<int> fetchTotalKhachhang() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("$url/api/users/all/countUsers"),
      headers: {
        "accesstoken": prefs.getString('accesstoken') ?? '',
      },
    );

    if (response.statusCode == 200) {

      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> data = json['totalUsers'] ?? 0;
      
      List<Khachhang> khachhang = data.map((e) => Khachhang.fromMap(e)).toList();
      _totalKhachhang =json['totalKhachhang'];
      notifyListeners();
      return _totalKhachhang;
    } else {
      throw Exception('Failed to load total Khachhang');
    }
  } catch (error) {
    print('Error fetching total Khachhang: $error');
    throw Exception('Failed to load total Khachhang');
  }
}


  Future<void> addKhachhang(Khachhang khachhang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/api/admin/themkhachhang/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
      body: jsonEncode(<String, dynamic>{
        'KH_TEN': khachhang.kh_ten,
        'CMND': khachhang.kh_cmnd,
        'DIEN_THOAI': khachhang.kh_sdt,
        'DIA_CHI': khachhang.kh_dia_chi,
        'SU_DUNG': 1,
        'GHI_CHU': khachhang.kh_ghi_chu,
      }),
    );

    if (response.statusCode == 200) {
      _khachhang.add(khachhang);
      notifyListeners();
    } else {
      throw Exception('Failed to add khach hang');
    }
  }

  Future<Khachhang> deleteKhachhang(int kh_id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('$url/api/admin/khachhang/$kh_id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accesstoken": "${prefs.getString('accesstoken')}",
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      if (response.statusCode == 200) {
        notifyListeners();
        return Khachhang.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to delete khach hang: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete khach hang: $error');
    }
  }
}

// import 'dart:convert';
// import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:app_qltv/FrontEnd/constants/config.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class KhachhangManage with ChangeNotifier {
//   List<Khachhang> _khachhang = [];
//   List<Khachhang> get khachhang => _khachhang;
//   int _currentPage = 1;
//   int _pageSize = 10;
//   int _totalPages = 1;
//  // bool _isLoading = false;
//   int get currentPage => _currentPage;
//   int get totalPages => _totalPages;
//  // bool get isLoading => _isLoading;
  
//   Future<List<Khachhang>> fetchKhachhang({int page = 1, int pageSize = 10}) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//    // _isLoading = true;
//     notifyListeners();

//     final response = await http.get(
//       Uri.parse("$url/api/admin/danhsachkhachhang?page=$page&pageSize=$pageSize"),
//       headers: {
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       },
//     );

//     if (response.statusCode == 200) {
//       Map<String, dynamic> json = jsonDecode(response.body);
//       List<dynamic> data = json['data'];
//       List<Khachhang> khachhang = data.map((e) => Khachhang.fromMap(e)).toList();

//       _currentPage = json['page'];
//       _totalPages = json['totalPages'];
//       //_isLoading = false;
//       notifyListeners();
//       return khachhang;
//     } else {
//       //_isLoading = false;
//       notifyListeners();
//       throw Exception('Failed to load data');
//     }
//   }


//   Future<void> addKhachhang(Khachhang khachhang) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.post(
//       Uri.parse('$url/api/admin/themkhachhang/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       },
//       body: jsonEncode(<String, dynamic>{
//         'KH_TEN': khachhang.kh_ten,
//         'CMND': khachhang.kh_cmnd,
//         'DIEN_THOAI': khachhang.kh_sdt,
//         'DIA_CHI': khachhang.kh_dia_chi,
//         'SU_DUNG': 1,
//         'GHI_CHU': khachhang.kh_ghi_chu,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // If successful, add to the local list and notify listeners
//       _khachhang.add(khachhang);
//       notifyListeners();
//     } else {
//       throw Exception('Failed to add khach hang');
//     }
//   }

//   Future<Khachhang> deleteKhachhang(int kh_id) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final response = await http.delete(
//         Uri.parse('$url/api/admin/khachhang/$kh_id'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           "accesstoken": "${prefs.getString('accesstoken')}",
//         },
//         body: jsonEncode(<String, dynamic>{
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng dvi từ dữ liệu nhận được
//         notifyListeners();
//         return Khachhang.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
//       } else {
//         // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
//         throw Exception('Failed to update khach hang: ${response.statusCode}');
//       }
//     } catch (error) {
//       // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
//       throw Exception('Failed to update khach hang: $error');
//     }
//   }

// }
