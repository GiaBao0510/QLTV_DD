// import 'package:app_qltv/FrontEnd/constants/config.dart';
// import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BaocaophieumuaManage with ChangeNotifier {
//   List<BaoCaoPhieuMua> _PhieuMuas = [];
//   List<BaoCaoPhieuMua> get PhieuMua => _PhieuMuas;

//   int get BaoCaoPhieuMuaLength => _PhieuMuas.length;

//   // Lấy dữ liệu
//   Future<List<BaoCaoPhieuMua>> fetchBaoCaoPhieuMua() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.get(
//       Uri.parse('$url/api/phieu/phieumua'),
//       headers: {
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       },
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> jsonList = jsonDecode(response.body);
//       List<BaoCaoPhieuMua> BaoCaoPhieuMuaList = jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
//       _PhieuMuas = jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
//       notifyListeners();
//       return BaoCaoPhieuMuaList;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   // Lấy dữ liệu theo ngày
//   Future<List<BaoCaoPhieuMua>> fetchBaoCaoPhieuMuaByDate(DateTime ngayBD, DateTime ngayKT) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.get(
//       Uri.parse('$url/api/phieu/phieumuatheongay?ngayBD=${ngayBD.toIso8601String()}&ngayKT=${ngayKT.toIso8601String()}'),
//       headers: {
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       },
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> jsonList = jsonDecode(response.body);
//       List<BaoCaoPhieuMua> BaoCaoPhieuMuaList = jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
//       _PhieuMuas = BaoCaoPhieuMuaList;

//       notifyListeners();
//       return BaoCaoPhieuMuaList;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   // Lấy dữ liệu theo ID
//   Future<BaoCaoPhieuMua> fetchBaoCaoPhieuMuaById(int id) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final response = await http.get(
//       Uri.parse('$url/api/phieu/phieumua/$id'),
//       headers: {
//         "accesstoken": "${prefs.getString('accesstoken')}",
//       },
//     );
//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonMap = jsonDecode(response.body);
//       BaoCaoPhieuMua baoCaoPhieuMua = BaoCaoPhieuMua.fromMap(jsonMap);
//       notifyListeners();
//       return baoCaoPhieuMua;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//   List<BangBaoCaoPhieuMua_model> _bangBaoCaoPhieuMua = [];
//   List<BangBaoCaoPhieuMua_model> get bangBaoCaoPhieuMua => _bangBaoCaoPhieuMua;
//   int get bangBaoCaoPhieuMuaLenght => _bangBaoCaoPhieuMua.length;
// Future<List<BangBaoCaoPhieuMua_model>> LayDuLieuPhieuMua_test() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final response = await http.get(
//     Uri.parse('$url/api/phieu/phieumua'),
//     headers: {
//       "accesstoken": "${prefs.getString('accesstoken')}",
//     },
//   );
//   print(response.body);
//   if (response.statusCode == 200) {
//     List<dynamic>? jsonList = jsonDecode(response.body);
//     if (jsonList != null) {
//       List<BangBaoCaoPhieuMua_model> BangBaoCaoPhieuMuaList = jsonList.map(
//         (e) => BangBaoCaoPhieuMua_model.fromMap(e)
//       ).toList();
//       _bangBaoCaoPhieuMua = BangBaoCaoPhieuMuaList;
//       notifyListeners();
//       return BangBaoCaoPhieuMuaList;
//     } else {
//       // Không có dữ liệu nào được tải thành công, trả về một danh sách rỗng
//       _bangBaoCaoPhieuMua = [];
//       return [];
//     }
//   } else {
//     // Xử lý các trường hợp lỗi khác (ví dụ: response.statusCode không phải là 200)
//     throw Exception('Failed to load data');
//   }
// }}

import 'dart:convert';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaocaophieumuaManeger with ChangeNotifier {
  // List<BaoCaoPhieuMua> _BaoCaoPhieuMua = [];

  // List<BaoCaoPhieuMua> get baoCaoPhieuMua => _BaoCaoPhieuMua;

  // int get baoCaoPhieuMuaLength => _BaoCaoPhieuMua.length;

  Future<List<BaoCaoPhieuMua>> fecthbaoCaoPhieuMua() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$url/api/phieu/phieumua'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<BaoCaoPhieuMua> BaoCaoPhieuMuaList =
          jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
      //_BaoCaoPhieuMua = jsonList.map((e) => BaoCaoPhieuMua.fromMap(e)).toList();
      notifyListeners();
      return BaoCaoPhieuMuaList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
//   List<BangBaoCaoPhieuMuaModel> _bangBaoCaoPhieuMua = [];
//   List<BangBaoCaoPhieuMuaModel> get bangBaoCaoPhieuMua => _bangBaoCaoPhieuMua;
//   int get bangBaoCaoPhieuMuaLenght => _bangBaoCaoPhieuMua.length;
// Future<List<BangBaoCaoPhieuMuaModel>> LayDuLieuPhieuMua_test() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final response = await http.get(
//     Uri.parse('$url/api/phieu/phieumua'),
//     headers: {
//       "accesstoken": "${prefs.getString('accesstoken')}",
//     },
//   );
//   print(response.body);
//   if (response.statusCode == 200) {
//     List<dynamic>? jsonList = jsonDecode(response.body);
//     if (jsonList != null) {
//       List<BangBaoCaoPhieuMuaModel> BangBaoCaoPhieuMuaList = jsonList.map(
//         (e) => BangBaoCaoPhieuMuaModel.fromMap(e)
//       ).toList();
//       _bangBaoCaoPhieuMua = BangBaoCaoPhieuMuaList;
//       notifyListeners();
//       return BangBaoCaoPhieuMuaList;
//     } else {
//       // Không có dữ liệu nào được tải thành công, trả về một danh sách rỗng
//       _bangBaoCaoPhieuMua = [];
//       return [];
//     }
//   } else {
//     // Xử lý các trường hợp lỗi khác (ví dụ: response.statusCode không phải là 200)
//     throw Exception('Failed to load data');
//   }
// }
// }
