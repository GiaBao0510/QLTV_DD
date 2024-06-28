import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/chi_tiet_nhompage.dart';
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
            const Text("Nhóm Người Dùng",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
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
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              ChiTietNhom(groupId: nhom.groupMa.toString())));
                    },
                    child: ListTile(
                      title: Text(nhom.groupTen ?? 'No Name',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Mã nhóm: ${nhom.groupMa ?? 'N/A'}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                              Text('Khóa: ${nhom.biKhoa == true ? "Có" : "Không"}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                            ],
                          ),
                          Text('Lý do khóa: ${nhom.lyDoKhoa ?? 'N/A'}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                          Text(
                              'Ngày tạo : ${nhom.ngayTao != null ? nhom.ngayTao!.toIso8601String() : 'N/A'}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                        ],
                      ),
                      trailing: 
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.pencil_circle,color: Colors.black,),
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
                          SizedBox(width: 0,),
                          IconButton(
                            icon: Icon(CupertinoIcons.delete_solid,color: Colors.black,),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Xác nhận"),
                                    content: Text(
                                        "Bạn có chắc chắn muốn xóa nhóm ${nhom.groupTen?.toUpperCase()}?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Hủy"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final nhomManager =
                                              Provider.of<NhomManager>(context,
                                                  listen: false);
                                          await nhomManager.deleteNhom(
                                              int.parse(nhom
                                                  .groupId!)); // Use `loaiId` directly
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _loadNhom(); // Refresh the list
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Xóa thành công!',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.red),
                                                textAlign: TextAlign.center,
                                              ),
                                              backgroundColor: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 2.0), // bo viền 15px
                                              ),
                                              behavior: SnackBarBehavior
                                                  .floating, // hiển thị ở cách đáy màn hình
                                              margin: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  bottom:
                                                      15.0), // cách 2 cạnh và đáy màn hình 15px
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
