
import 'package:app_qltv/FrontEnd/model/danhmuc/kho.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class ChiTietKhoScreen extends StatelessWidget {
  static const routeName = "/chitietkho";

  final Kho kho;

  const ChiTietKhoScreen({
    super.key,
    required this.kho,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(kho.kho_ten ?? ''),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Thông tin chi tiết kho'), 
        ),
      ),
    );
  }
}