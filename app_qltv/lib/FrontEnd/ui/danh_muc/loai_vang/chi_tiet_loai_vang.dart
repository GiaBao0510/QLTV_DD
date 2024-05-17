
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang/loaivang.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChiTietLoaiVangScreen extends StatelessWidget {
  static const routeName = "/chitietloaivang";

  final LoaiVang loaiVang;

  const ChiTietLoaiVangScreen({
    super.key,
    required this.loaiVang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(loaiVang.nhomTen ?? ''),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Thông tin chi tiết loại vàng'), // Đây là nơi bạn có thể hiển thị thông tin chi tiết của loại vàng
        ),
      ),
    );
  }
}