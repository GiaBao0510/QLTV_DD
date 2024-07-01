import 'package:app_qltv/FrontEnd/controller/CamVang/ChiTietCamVang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/camvang/ChiTietPhieuCamByLoaiVangScreen.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhieuDangCamChiTiet extends StatefulWidget {
  static const routeName = "/phieudangcamchitiet";

  const PhieuDangCamChiTiet({Key? key}) : super(key: key);

  @override
  _PhieuDangCamChiTiet createState() => _PhieuDangCamChiTiet();
}

class _PhieuDangCamChiTiet extends State<PhieuDangCamChiTiet> {
  late Future<List<dynamic>> _loaivangFuture;
  late List<dynamic> _loaiVangList; // Khai báo thuộc tính loaiVangList

  @override
  void initState() {
    super.initState();
    _loadLoaiVang();
    _loaiVangList = []; // Gán giá trị ban đầu cho loaiVangList
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadLoaiVang() async {
    _loaivangFuture =
        Provider.of<ChiTietPhieuCamManager>(context, listen: false)
            .fetchLoaiVang();
    _loaivangFuture.then((loaiVang) {
      setState(() {
        _loaiVangList = loaiVang;
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
        title:  FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("BC Chi Tiết Phiếu Cầm",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900)),
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
  FutureBuilder<List<dynamic>> ShowList() {
    return FutureBuilder<List<dynamic>>(
      future: _loaivangFuture,
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
            itemCount: _loaiVangList.length,
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
                          _loaiVangList[index].loaiVang ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              createRoute(
                                (context) => ChiTietPhieuCamByLoaiVangScreen(
                                    loaiVang: _loaiVangList[index].loaiVang),
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
