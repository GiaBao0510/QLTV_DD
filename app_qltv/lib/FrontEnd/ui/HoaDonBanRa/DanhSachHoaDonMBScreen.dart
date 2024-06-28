import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/HoaDonMBManager.dart';
import 'package:app_qltv/FrontEnd/ui/HoaDonBanRa/ChiTietHoaDonMatBaoScreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DanhSachPhieuCamScreen extends StatefulWidget {
  static const routeName = "/phieudangcamchitiet";

  const DanhSachPhieuCamScreen({Key? key}) : super(key: key);

  @override
  _DanhSachPhieuCamScreen createState() => _DanhSachPhieuCamScreen();
}

class _DanhSachPhieuCamScreen extends State<DanhSachPhieuCamScreen> {
  late Future<List<HoaDonMatBao>> _hoaDonFuture;
  late List<HoaDonMatBao> _hoaDonList; // Khai báo thuộc tính loaiVangList

  @override
  void initState() {
    super.initState();
    _loadDanhSachHoaDon();
    _hoaDonList = []; // Gán giá trị ban đầu cho loaiVangList
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadDanhSachHoaDon() async {
    _hoaDonFuture = Provider.of<HoaDonMatBaoManager>(context, listen: false)
        .fetchDanhSachHoaDonMB();
    _hoaDonFuture.then((hoaDon) {
      setState(() {
        _hoaDonList = hoaDon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 126),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Danh Sách Hóa Đơn",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            SizedBox(
              width: 50,
            )
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: IconButton(
        //       onPressed: () async {
        //         final result = await Navigator.of(context).push(
        //           createRoute((context) => ThemHangHoaScreen()),
        //         );
        //         if (result == true) {
        //           _loadHangHoas(); // Refresh the list when receiving the result
        //         }
        //       },
        //       icon: const Icon(CupertinoIcons.add),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            // SingleChildScrollView for scrolling
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                ShowList(),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  FutureBuilder<List<HoaDonMatBao>> ShowList() {
    return FutureBuilder<List<HoaDonMatBao>>(
      future: _hoaDonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics:
                const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _hoaDonList.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _hoaDonList[index].no.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChiTietHoaDonMatBaoScreen(
                                  hoaDonMatBao: _hoaDonList[index],
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
