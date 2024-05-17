
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang.dart';
import 'package:flutter/cupertino.dart';
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
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Text("Thông Tin Nhóm Vàng", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
            ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Mã Loại"),
                  Text("${nhomvang.loaiMa}"),
                ],
              ),
            ],
          ), 
        ),
      ),
    );
  }
}