

import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang/loaivang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang/loaivang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/chi_tiet_loai_vang.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class loaiVang extends StatelessWidget {
  static const routeName = "/loaivang";

  const loaiVang({super.key});

    @override
  Widget build(BuildContext context) {
    // Lấy danh sách các mục từ LoaiVangManager
    final List<LoaiVang> items = LoaiVangManager().items;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text("Loại Vàng"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            // Hiển thị thông tin của mỗi đối tượng LoaiVang trong danh sách
            return ListTile(
              title: Text(items[index].nhomTen ?? ''),
              // subtitle: Text("Đơn giá mua: ${items[index].donGiaMua}"),
              // Xử lý sự kiện khi nhấn vào một mục
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChiTietLoaiVangScreen(loaiVang: items[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}