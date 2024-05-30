
import 'package:app_qltv/FrontEnd/model/danhmuc/donvi.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChiTietDonViScreen extends StatelessWidget {
  static const routeName = "/chitietdonvi";

  final Donvi donvi;

  const ChiTietDonViScreen({
    super.key,
    required this.donvi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(donvi.dvi_ten ?? ''),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Thông tin chi tiết đơn vị'), 
        ),
      ),
    );
  }
}