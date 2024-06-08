import 'package:app_qltv/FrontEnd/ui/hethonng/ketnoi/chinh_sua_ket_noi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/hethong/ketnoi.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/ketnoi_manager.dart';


class KetNoiPage extends StatelessWidget {
  static const routeName = "/ketnoi";
  const KetNoiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin Kết Nối'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChinhSuaKetNoiPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<KetNoi>(
        future: Provider.of<KetnoiManager>(context, listen: false).fetchketnoi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Không có dữ liệu.'));
          } else {
            final ketNoi = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Host: ${ketNoi.host}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Database: ${ketNoi.database}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('User: ${ketNoi.user}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Port: ${ketNoi.port}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
