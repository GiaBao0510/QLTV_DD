import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/them_nhom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';

class NhomPage extends StatefulWidget {
  static const routeName = "/nhom";

  const NhomPage({super.key});

  @override
  _NhomPageState createState() => _NhomPageState();
}

class _NhomPageState extends State<NhomPage> {
  late Future<List<Nhom>> _nhomFuture;
  List<Nhom> _filteredNhomList = [];
  List<Nhom> _nhomList = [];

  @override
  void initState() {
    super.initState();
    // Fetch data khi trang được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NhomManager>(context, listen: false).fetchNhoms();
    });
  }

  Future<void> _loadNhom() async {
    _nhomFuture = Provider.of<NhomManager>(context, listen: false).fetchNhoms();
    _nhomFuture.then((nhoms) {
      setState(() {
        _nhomList = nhoms;
        _filteredNhomList = nhoms;
      });
    });
  }

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
        title: Row(
          children: [
            Expanded(child: Container()), // Spacer
            const Text("Nhóm Người Dùng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => const ThemNhomScreen()),
                );
                if (result == true) {
                  _loadNhom(); // Refresh the list when receiving the result
                }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: Consumer<NhomManager>(
        builder: (context, nhomManager, child) {
          if (nhomManager.nhoms.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: nhomManager.nhomsLength,
              itemBuilder: (context, index) {
                Nhom nhom = nhomManager.nhoms[index];
                return ListTile(
                  title: Text(nhom.groupTen ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mã nhóm: ${nhom.groupMa ?? 'N/A'}'),
                      Text('Khóa: ${nhom.biKhoa == true ? "Có" : "Không"}'),
                      Text('Lý do khóa: ${nhom.lyDoKhoa ?? 'N/A'}'),
                      Text('Sử dụng: ${nhom.suDung == true ? "Có" : "Không"}'),
                      Text('Ngày tạo: ${nhom.ngayTao != null ? nhom.ngayTao!.toIso8601String() : 'N/A'}'),
                    ],
                  ),
                  trailing: nhom.biKhoa == true ? Icon(Icons.lock) : null,

                );
              },
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Điều hướng đến trang thêm nhóm mới
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddNhomPage()),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

// class AddNhomPage extends StatelessWidget {
//   final TextEditingController groupMaController = TextEditingController();
//   final TextEditingController groupTenController = TextEditingController();
//   final TextEditingController lyDoKhoaController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thêm nhóm mới'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: groupMaController,
//               decoration: InputDecoration(labelText: 'Mã nhóm'),
//             ),
//             TextField(
//               controller: groupTenController,
//               decoration: InputDecoration(labelText: 'Tên nhóm'),
//             ),
//             TextField(
//               controller: lyDoKhoaController,
//               decoration: InputDecoration(labelText: 'Lý do khóa'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final newNhom = Nhom(
//                   groupMa: groupMaController.text,
//                   groupTen: groupTenController.text,
//                   biKhoa: false,
//                   lyDoKhoa: lyDoKhoaController.text,
//                   suDung: true,
//                   ngayTao: DateTime.now(),
//                 );
//                 Provider.of<NhomManager>(context, listen: false).addNhom(newNhom);
//                 Navigator.pop(context);
//               },
//               child: Text('Thêm nhóm'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
