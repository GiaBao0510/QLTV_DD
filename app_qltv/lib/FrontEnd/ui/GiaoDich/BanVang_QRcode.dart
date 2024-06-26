import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

class BanVang_QRcode extends StatefulWidget {
  const BanVang_QRcode({super.key});

  @override
  State<BanVang_QRcode> createState() => _BanVang_QRState();
}

class _BanVang_QRState extends State<BanVang_QRcode> {

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
        title: Row(
          children: [
            Expanded(child: Container()), // Spacer
            const Text("Báo Cáo Phiếu Xuất",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_sharp),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: TextButton(
                      onPressed: () {
                        print('Chuyen sang PDF');
                        //printDoc(_filterPhieuXuatList, ThongTinTinhTong);
                      },
                      child: Text('Export PDF'),
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
          child:Text('${ThuVienUntilState.maQR}') ,
        ),
      ) ,
    );
  }
}
