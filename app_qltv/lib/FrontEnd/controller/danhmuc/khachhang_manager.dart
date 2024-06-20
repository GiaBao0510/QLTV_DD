// import 'dart:convert';
// import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:app_qltv/FrontEnd/constants/config.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class KhachhangManage with ChangeNotifier {
//   List<Khachhang> _khachhang = [];

//   List<Khachhang> get khachhang => _khachhang;

//   int get khachhangLength => _khachhang.length;

//   Future<List<Khachhang>> fetchKhachhang() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.get(
//       Uri.parse('$url/api/admin/danhsachkhachhang/'),
//       headers: {
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       }
//     );
//     if (response.statusCode == 200) {

//       final List<dynamic> data = json.decode(response.body);

//     return data.map((item) => Khachhang.fromMap(item)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//   Future<void> addKhachhang(Khachhang khachhang) async {
//     // Thêm Khachhang vào backend
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

//         }),  
//   //  KH_ID                int zerofill not null auto_increment,
//   //  KH_MA                varchar(50),
//   //  KH_TEN               national varchar(50),
//   //  CMND                 national varchar(50),
//   //  DIEN_THOAI           varchar(50),
//   //  DIA_CHI              national char(100),
//   //  SU_DUNG              bool,
//   //  GHI_CHU              national varchar(50),

//     );

//     if (response.statusCode == 200) {
//       // Nếu thành công, thêm vào danh sách nội bộ và thông báo thay đổi
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
 // bool _isLoading = false;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
 // bool get isLoading => _isLoading;
  
  Future<List<Khachhang>> fetchKhachhang({int page = 1, int pageSize = 10}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   // _isLoading = true;
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
      //_isLoading = false;
      notifyListeners();
      return khachhang;
    } else {
      //_isLoading = false;
      notifyListeners();
      throw Exception('Failed to load data');
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
      // If successful, add to the local list and notify listeners
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
        body: jsonEncode(<String, dynamic>{
        }),
      );

      if (response.statusCode == 200) {
        // Nếu server trả về mã status 200 OK, tiến hành parse JSON để tạo ra một đối tượng dvi từ dữ liệu nhận được
        notifyListeners();
        return Khachhang.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Nếu server không trả về mã status 200 OK, ném một Exception để thông báo rằng việc cập nhật thất bại
        throw Exception('Failed to update khach hang: ${response.statusCode}');
      }
    } catch (error) {
      // Nếu có bất kỳ lỗi nào xảy ra trong quá trình gửi request hoặc xử lý response, ném một Exception để thông báo rằng việc cập nhật thất bại
      throw Exception('Failed to update khach hang: $error');
    }
  }

}
