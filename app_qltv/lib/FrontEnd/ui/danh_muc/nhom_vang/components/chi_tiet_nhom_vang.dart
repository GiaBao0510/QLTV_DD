
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChiTietNhomVangScreen extends StatelessWidget {
  static const routeName = "/chitietnhomvang";

  final NhomVang nhomvang;

  const ChiTietNhomVangScreen({
    super.key,
    required this.nhomvang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(nhomvang.loaiTen ?? ''),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Thông tin chi tiết loại vàng'), // Đây là nơi bạn có thể hiển thị thông tin chi tiết của loại vàng
        ),
      ),
    );
  }
}