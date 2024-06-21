import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/chinh_sua_nguoi_dung.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/them_nguoi_dung.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NguoiDungPage extends StatefulWidget {
  static const routeName = "/nguoidung";

  const NguoiDungPage({super.key});

  @override
  _NguoiDungPageState createState() => _NguoiDungPageState();
}

class _NguoiDungPageState extends State<NguoiDungPage> {
  late Future<List<NguoiDung>> _nguoidungFuture;
  List<NguoiDung> _nhomList = [];
  List<NguoiDung> _filteredNhomList = [];

  @override
  void initState() {
    super.initState();
    // Fetch data khi trang được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NguoiDungManager>(context, listen: false).fetchNguoiDungs();
    });
  }

  Future<void> _loadNguoiDung() async {
    _nguoidungFuture =
        Provider.of<NguoiDungManager>(context, listen: false).fetchNguoiDungs();
    _nguoidungFuture.then((nhoms) {
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
              const Text("Người Dùng",
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
                    createRoute((context) => const ThemNguoiDungScreen()),
                  );
                  if (result == true) {
                    _loadNguoiDung(); // Refresh the list when receiving the result
                  }
                },
                icon: const Icon(CupertinoIcons.add),
              ),
            ),
          ],
        ),
        body: Consumer<NguoiDungManager>(
            builder: (context, nguoidungmanager, child) {
          if (nguoidungmanager.nguoiDungs.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: nguoidungmanager.nguoiDungsLength,
              itemBuilder: (context, index) {
                NguoiDung nguoidung = nguoidungmanager.nguoiDungs[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(nguoidung.userTen ?? 'Null',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nhóm người dùng: ${nguoidung.groupId.toString()}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                        Text('Khóa: ${nguoidung.biKhoa == true ? "Có" : "Không"}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                        Text('Lý do khóa: ${nguoidung.lyDoKhoa ?? 'N/A'}',style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),),
                        Text(
                          'Ngày tạo : ${nguoidung.ngayTao != null ? nguoidung.ngayTao!.toIso8601String() : 'N/A'}',style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        ),
                      ]
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.pencil_circle,color: Colors.black,),
                          onPressed: () async {
                            final result = await Navigator.of(context).push(
                              createRoute(
                                (context) => ChinhSuaNguoiDungScreen(nguoidung),
                              ),
                            );
                            if (result == true) {
                              _loadNguoiDung(); // Refresh the list when receiving the result
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.delete_solid,color: Colors.black,),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Xác nhận"),
                                  content: Text(
                                      "Bạn có chắc chắn muốn xóa người dùng ${nguoidung.userTen?.toUpperCase()}?"),
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
                                        final nguoidungManager =
                                            Provider.of<NguoiDungManager>(
                                                context,
                                                listen: false);
                                        await nguoidungManager.deleteNguoiDung(
                                            nguoidung
                                                .userId!); // Use `loaiId` directly
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        _loadNguoiDung(); // Refresh the list
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
                        //if (nhom.biKhoa == true) Icon(Icons.lock),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }));
  }
}
