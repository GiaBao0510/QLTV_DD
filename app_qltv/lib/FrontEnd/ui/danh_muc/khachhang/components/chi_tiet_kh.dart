
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChiTietKhachhangScreen extends StatelessWidget {
  static const routeName = "/chitietkhachhang";

  final Khachhang khachhang;

  const ChiTietKhachhangScreen({
    super.key,
    required this.khachhang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(khachhang.kh_ten ?? ''),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Thông tin chi tiết khách hàng'), 
        ),
      ),
    );
  }
}