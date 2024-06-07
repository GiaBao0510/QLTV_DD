// import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
// import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
// import 'package:flutter/material.dart';

// class ChiTietNhomPage extends StatelessWidget{
//   static const routeName = '/chitietnhom';

//   final NguoiDungManager nguoidungManager = NguoiDungManager();
//   final String groupId;
//   ChiTietNhomPage(
//     this.groupId,{super.key}
//   );

//   @override
//   Widget build(BuildContext context) {
//     List<NguoiDung> nguoidungs = nguoidungManager.filterNguoiDung(groupId.toString());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chi tiết nhóm $groupId'),
//       ),
//       body: ListView.builder(
//         itemCount: nguoidungs.length,
//         itemBuilder: (context, index){
//           NguoiDung nguoidung = nguoidungs[index];
//           return ListTile(
//             title: Text(nguoidung.userTen ?? 'No Name'),
//             subtitle: Text(nguoidung.groupId.toString()),
//           );
//         },
//       )
//     );
//   }
// }

import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';

class ChiTietNhom extends StatelessWidget {
  static const routeName = '/chitietnhom';

  final String groupId;

  ChiTietNhom({super.key, required this.groupId});

  late NguoiDungManager nguoiDungManager = NguoiDungManager();

  
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết Nhóm $groupId'),
      ),
      body: FutureBuilder<List<NguoiDung>>(
        future: Provider.of<NguoiDungManager>(context, listen: false).fetchAndFilterNguoiDungsByGroupId(groupId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có người dùng nào trong nhóm n'));
          } else {
            List<NguoiDung> nguoiDungs = snapshot.data!;
            return ListView.builder(
              itemCount: nguoiDungs.length,
              itemBuilder: (context, index) {
                NguoiDung nguoiDung = nguoiDungs[index];
                return ListTile(
                  title: Text(nguoiDung.userTen.toString()), // Assuming 'name' is a property of NguoiDung
                  subtitle: Text('ID: ${nguoiDung.groupId}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
