import 'dart:convert';

import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoaiVang {
  final String loaiVang;

  LoaiVang({required this.loaiVang});

  factory LoaiVang.fromMap(Map<String, dynamic> map) {
    return LoaiVang(
      loaiVang: map['LOAI_VANG'] ?? '',
    );
  }
}

class PhieuCamVang {
  final int phieuCamVangId;
  final String khTen;
  final String tenHangHoa;
  final String dienThoai;
  final String diaChi;
  final String ngayLap;
  final String ngayCam;
  final String phieuMa;
  final int canTong;
  final int dinhGia;
  final String tuNgay;
  final String ngayQuaHan;
  final int tienKhachNhan;
  final int tienThem;
  final int tlThuc;
  final int tlHot;
  final int tienCamMoi;
  final double laiXuat;
  final int donGia;
  final int soNgayTinhDuoc;
  final int soNgayHetHan;
  final int thanhTien;
  final String matPhieu;
  final String lyDoMatPhieu;
  final String ghiChu;
  final String loaiVang;

  PhieuCamVang({
    required this.phieuCamVangId,
    required this.khTen,
    required this.tenHangHoa,
    required this.dienThoai,
    required this.diaChi,
    required this.ngayLap,
    required this.ngayCam,
    required this.phieuMa,
    required this.canTong,
    required this.dinhGia,
    required this.tuNgay,
    required this.ngayQuaHan,
    required this.tienKhachNhan,
    required this.tienThem,
    required this.tlThuc,
    required this.tlHot,
    required this.tienCamMoi,
    required this.laiXuat,
    required this.donGia,
    required this.soNgayTinhDuoc,
    required this.soNgayHetHan,
    required this.thanhTien,
    required this.matPhieu,
    required this.lyDoMatPhieu,
    required this.ghiChu,
    required this.loaiVang,
  });

  factory PhieuCamVang.fromMap(Map<String, dynamic> map) {
    return PhieuCamVang(
      phieuCamVangId: map['PHIEU_CAM_VANG_ID'] ?? 0,
      khTen: map['KH_TEN'] ?? '',
      tenHangHoa: map['TEN_HANG_HOA'] ?? '',
      dienThoai: map['DIEN_THOAI'] ?? '',
      diaChi: map['DIA_CHI'] ?? '',
      ngayLap: map['NGAY_LAP'] ?? '',
      ngayCam: map['NGAY_CAM'] ?? '',
      phieuMa: map['PHIEU_MA'] ?? '',
      canTong: map['CAN_TONG'] ?? 0,
      dinhGia: map['DINHGIA'] ?? 0,
      tuNgay: map['TU_NGAY'] ?? '',
      ngayQuaHan: map['NGAY_QUA_HAN'] ?? '',
      tienKhachNhan: map['TIEN_KHACH_NHAN'] ?? 0,
      tienThem: map['TIEN_THEM'] ?? 0,
      tlThuc: map['TL_THUC'] ?? 0,
      tlHot: map['TL_HOT'] ?? 0,
      tienCamMoi: map['TIEN_CAM_MOI'] ?? 0,
      laiXuat: (map['LAI_XUAT'] is int
              ? map['LAI_XUAT'].toDouble()
              : map['DON_LAI_XUATGIA']) ??
          0.0,
      donGia: map['DON_GIA'] ?? 0,
      soNgayTinhDuoc: map['SO_NGAY_TINH_DUOC'] ?? 0,
      soNgayHetHan: map['SO_NGAY_HET_HAN'] ?? 0,
      thanhTien: map['THANH_TIEN'] ?? 0,
      matPhieu: map['MAT_PHIEU'] ?? '',
      lyDoMatPhieu: map['LY_DO_MAT_PHIEU'] ?? '',
      ghiChu: map['GHI_CHU'] ?? '',
      loaiVang: map['LOAI_VANG'] ?? '',
    );
  }
}

class ChiTietPhieuCamManager with ChangeNotifier {
  Future<List<dynamic>> fetchLoaiVang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$url/api/cam/chitietphieucam'), headers: {
      "accesstoken": "${prefs.getString('accesstoken')}",
    });
    if (response.statusCode == 200) {
      // Parse JSON array and convert to list of NhomVang objects
      List<dynamic> jsonList = jsonDecode(response.body);
      List<dynamic> loaiVangList =
          jsonList.map((e) => LoaiVang.fromMap(e)).toList();
      notifyListeners();
      return loaiVangList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  int _totalRow = 0;
  int get totalRow => _totalRow;

  Future<List<dynamic>> fetchByLoaiVang(
      {String loaiVang = '16K', int page = 1, int pageSize = 10}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(
            '$url/api/cam/chitietphieucambyloaivang?loaivang=$loaiVang&page=$page&pageSize=$pageSize'),
        headers: {
          "accesstoken": "${prefs.getString('accesstoken')}",
        });
    if (response.statusCode == 200) {
      // Parse JSON and extract "data" array
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonList = jsonResponse['data'];
      _totalRow = jsonResponse['total'];
      List<dynamic> phieuCamVangList =
          jsonList.map((e) => PhieuCamVang.fromMap(e)).toList();
      notifyListeners();
      return phieuCamVangList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
