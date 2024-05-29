import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/chinh_sua_nhom.dart';
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                                createRoute(
                                  (context) => ChinhSuaNhomScreen(nhom),
                                ),
                              );
                              if (result == true) {
                                _loadNhom(); // Refresh the list when receiving the result
                              }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Xác nhận"),
                                content: Text("Bạn có chắc chắn muốn xóa nhóm ${nhom.groupTen?.toUpperCase()}?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text("Hủy"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final nhomManager = Provider.of<NhomManager>(context, listen: false);
                                      await nhomManager.deleteNhom(int.parse(nhom.groupId!)); // Use `loaiId` directly
                                      Navigator.of(context).pop(); // Close the dialog
                                      _loadNhom(); // Refresh the list
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Xóa thành công!', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            side: const BorderSide(color: Colors.grey, width: 2.0), // bo viền 15px
                                          ),
                                          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
                                          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
                                        ),
                                      );
                                    },
                                    child: const Text("Xóa"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      if (nhom.biKhoa == true) Icon(Icons.lock),
                    ],
                  ),
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

// void _editNhom(BuildContext context, Nhom nhom) {
//   // Navigate to the edit screen or show a dialog to edit the nhom
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => EditNhomScreen(nhom: nhom),
//     ),
//   );
// }

// void _deleteNhom(BuildContext context, Nhom nhom) async {
//   final nhomManager = Provider.of<NhomManager>(context, listen: false);
//   try {
//     // Assume that you have a method in NhomManager to delete a nhom
//     await nhomManager.deleteNhom(nhom.groupId);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Xóa thành công!', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
//         backgroundColor: Colors.grey,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//           side: BorderSide(color: Colors.grey, width: 2.0),
//         ),
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
//       ),
//     );
//   } catch (error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Không thể xóa nhóm: $error', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
//         backgroundColor: Colors.grey,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//           side: BorderSide(color: Colors.grey, width: 2.0),
//         ),
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
//       ),
//     );
//   }
// }

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
