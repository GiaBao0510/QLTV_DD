
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/nha_cung_cap_green.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.settings),
            title: const Text('Danh Mục'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Loại Vàng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoaiVangScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Nhóm Vàng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NhomVangScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Hàng Hóa'),
                  onTap: () {
                    // Handle Hàng Hóa tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Kho'),
                  onTap: () {
                    // Handle Kho tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('NCC'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NhaCungCapScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Khách Hàng'),
                  onTap: () {
                    // Handle Khách Hàng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Đơn Vị'),
                  onTap: () {
                    // Handle Đơn Vị tap
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.bell),
            title: const Text('Hệ Thống'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Nhóm Người Dùng'),
                  onTap: () {
                    // Handle Nhóm Người Dùng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Người Dùng'),
                  onTap: () {
                    // Handle Người Dùng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Kết Nối'),
                  onTap: () {
                    // Handle Kết Nối tap
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.bell),
            title: const Text('Báo Cáo'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Phiếu Xuất'),
                  onTap: () {
                    // Handle Báo Cáo Phiếu Xuất tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Tồn Kho Loại Vàng'),
                  onTap: () {
                    // Handle Báo Cáo Tồn Kho Loại Vàng tap
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
