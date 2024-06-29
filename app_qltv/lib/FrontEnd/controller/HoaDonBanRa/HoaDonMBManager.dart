import 'dart:convert';

import 'package:app_qltv/FrontEnd/model/GiaoDich/ProductMB.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HoaDonMatBao {
  final int stt;
  final int no;
  final String pattern;
  final String serial;
  final String fkey;
  final String cusCode;
  final String cusName;
  final String cusTaxCode;
  final String cusAddress;
  final String cusEmail;
  final String so;
  final String paymentMethod;
  final String arisingDate;
  final double total;
  final double amount;
  final String maThongDiep;
  final String mltDiep;
  final String mccqt;
  final String loaiHoaDon;
  final String trangThaiHD;
  final String extra1;

  HoaDonMatBao({
    required this.stt,
    required this.no,
    required this.pattern,
    required this.serial,
    required this.fkey,
    required this.cusCode,
    required this.cusName,
    required this.cusTaxCode,
    required this.cusAddress,
    required this.cusEmail,
    required this.so,
    required this.paymentMethod,
    required this.arisingDate,
    required this.total,
    required this.amount,
    required this.maThongDiep,
    required this.mltDiep,
    required this.mccqt,
    required this.loaiHoaDon,
    required this.trangThaiHD,
    required this.extra1,
  });

  factory HoaDonMatBao.fromMap(Map<String, dynamic> map) {
    return HoaDonMatBao(
      stt: map['STT'] ?? 0,
      no: map['No'] ?? 0,
      pattern: map['Pattern'] ?? '',
      serial: map['Serial'] ?? '',
      fkey: map['Fkey'] ?? '',
      cusCode: map['CusCode'] ?? '',
      cusName: map['CusName'] ?? '',
      cusTaxCode: map['CusTaxCode'] ?? '',
      cusAddress: map['CusAddress'] ?? '',
      cusEmail: map['CusEmail'] ?? '',
      so: map['SO'] ?? '',
      paymentMethod: map['PaymentMethod'] ?? '',
      arisingDate: map['ArisingDate'] ?? '',
      total: map['Total']?.toDouble() ?? 0.0,
      amount: map['Amount']?.toDouble() ?? 0.0,
      maThongDiep: map['MaThongDiep'] ?? '',
      mltDiep: map['MLTDiep'] ?? '',
      mccqt: map['MCCQT'] ?? '',
      loaiHoaDon: map['LoaiHoaDon'] ?? '',
      trangThaiHD: map['TrangThaiHD'] ?? '',
      extra1: map['Extra1'] ?? '',
    );
  }
}

class HoaDonMatBaoManager with ChangeNotifier {
  String _stt = '';
  String get stt => _stt;

  Future<List<HoaDonMatBao>> fetchDanhSachHoaDonMB(
      {String dateStart = '2024-01-01', String dateEnd = '2024-01-01'}) async {
    final response = await http.post(
      Uri.parse('https://api-demo.matbao.in/api/v2/invoice/SearchInvByDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "ApiUserName": "admin",
        "ApiPassword": "Gtybf@12sd",
        "ApiInvPattern": "1",
        "ApiInvSerial": "C24TAT",
        "ArisingDateFrom": dateStart,
        "ArisingDateTo": dateEnd
      }),
    );
    if (response.statusCode == 200) {
      // Parse JSON and extract "data" array
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonList = jsonResponse['data'];
      _stt = jsonResponse['messages'];
      List<HoaDonMatBao> phieuCamVangList =
          jsonList.map((e) => HoaDonMatBao.fromMap(e)).toList();
      notifyListeners();
      return phieuCamVangList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> postHoaDonMatBao({
    required String fkey,
    required String arisingDate,
    required String so,
    required String maKH,
    required String cusName,
    required String buyer,
    required String cusAddress,
    required String cusPhone,
    required String cusTaxCode,
    required String cusEmail,
    required String paymentMethod,
    required List<Product> products,
    required double total,
    required double discountAmount,
    required double vatAmount,
    required double amount,
  }) async {
    final response = await http.post(
      Uri.parse(
          'https://api-demo.matbao.in/api/v2/invoice/importAndPublishInv'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "ApiUserName": "admin",
        "ApiPassword": "Gtybf@12sd",
        "ApiInvPattern": "1",
        "ApiInvSerial": "C24TAT",
        "Fkey": fkey,
        "ArisingDate": arisingDate,
        "SO": so,
        "MaKH": maKH,
        "CusName": cusName,
        "Buyer": buyer,
        "CusAddress": cusAddress,
        "CusPhone": cusPhone,
        "CusTaxCode": cusTaxCode,
        "CusEmail": cusEmail,
        "CusEmailCC": "",
        "CusBankName": "",
        "CusBankNo": "",
        "PaymentMethod": paymentMethod,
        "DonViTienTe": 704,
        "Products": products.map((e) => e.toMap()).toList(),
        "Total": total,
        "DiscountAmount": discountAmount,
        "VATAmount": vatAmount,
        "Amount": amount,
        "InvType": 1
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      _stt = jsonResponse['messages'];
      notifyListeners();
    } else {
      throw Exception('Failed to post data');
    }
  }
}
