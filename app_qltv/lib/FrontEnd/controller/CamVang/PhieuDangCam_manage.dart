import 'dart:convert';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/CamVang/PhieuDangCam.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PhieuDangCamManage with ChangeNotifier{
  List<PhieuDangCam_model> _BangBaoCaoPhieuDangCam = [];
  List<PhieuDangCam_model> get BangBaoCaoPhieuDangCam => _BangBaoCaoPhieuDangCam;
  int get BangBaoCaoPhieuDangCam_length => _BangBaoCaoPhieuDangCam.length;

  //Lấy thông tin bảng phiếu đang cầm
  Future<List<PhieuDangCam_model>> fetchPhieuDangCam(
      DateTime ngayBD, DateTime ngayKT, int limit, int offset
      ) async{

    //Biến đổi đầu vào
    String StartDay = DateFormat('yyyy-MM-dd').format(ngayBD);
    String EndDay = DateFormat('yyyy-MM-dd').format(ngayKT);
    String Limit = limit.toString();
    String Offset = offset.toString();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.get(
      Uri.parse("$url/api/cam/dangcam?ngayBD=$StartDay&ngayKT=$EndDay&limit=$Limit&offset=$Offset"),
      headers:{
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );

    if(res.statusCode == 200){
      List<dynamic> json = jsonDecode(res.body);
      List<PhieuDangCam_model> list_phieuDangCam = json.map(
          (e)=> PhieuDangCam_model.fromMap(e)
      ).toList();

      _BangBaoCaoPhieuDangCam = json.map(
              (e)=> PhieuDangCam_model.fromMap(e)
      ).toList();

      notifyListeners();
      return list_phieuDangCam;
    }else{
      throw Exception('Failed to load data.');
    }
  }

  //Lấy thông tin tính tổng
  Future<TinhTongPhieuDangCam_model> fetchTinhTongPhieuDangCam(DateTime ngayBD, DateTime ngayKT) async{
    String StartDay = DateFormat('yyyy-MM-dd').format(ngayBD);
    String EndDay = DateFormat('yyyy-MM-dd').format(ngayKT);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.get(
      Uri.parse("$url/api/cam/tinhtongphieudangcam?ngayBD=$StartDay&ngayKT=$EndDay"),
      headers:{
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );
    print('Ngày bắt đầu: ${StartDay}');
    print('Ngày ết thúc: ${EndDay}');
    print('Dữ liệu tính tổng: ${res.body}');
    if(res.statusCode == 200){
      List<dynamic> json = jsonDecode(res.body);
      //TinhTongPhieuDangCam_model tinhTong = TinhTongPhieuDangCam_model.fromMap(json);

      List<TinhTongPhieuDangCam_model> thongtintinhtong =
        json.map((e) => TinhTongPhieuDangCam_model.fromMap(e)).toList();

      TinhTongPhieuDangCam_model KQ = thongtintinhtong.first;
      notifyListeners();
      return KQ;
    }else{
      throw Exception('Failed to load data.');
    }
  }
}