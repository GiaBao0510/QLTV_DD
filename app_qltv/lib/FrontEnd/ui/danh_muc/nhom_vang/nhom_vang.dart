import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/chi_tiet_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/chinh_sua_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NhomVangScreen extends StatefulWidget {
  static const routeName = "/nhomvang";

  const NhomVangScreen({Key? key}) : super(key: key);

  @override
  _NhomVangScreenState createState() => _NhomVangScreenState();
}

class _NhomVangScreenState extends State<NhomVangScreen> {
  late Future<List<NhomVang>> _nhomVangFuture;

   @override
  void initState() {
    super.initState();
    _loadNhomVangs();
  }

  Future<void> _loadNhomVangs() async {
    _nhomVangFuture = Provider.of<NhomVangManager>(context, listen: false).fetchLoaiHang();
    setState(() {});
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
            const Text("Nhóm Vàng", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900 )),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => const ThemNhomVangScreen()),
                );
                if (result == true) {
                  _loadNhomVangs(); // Refresh the list when receiving the result
                }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: FutureBuilder<List<NhomVang>>(
            future: _nhomVangFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<NhomVang> nhomVangList = snapshot.data!;
                return ListView.builder(
                  itemCount: nhomVangList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(50, 169, 169, 169),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left) of the column
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    nhomVangList[index].loaiTen ?? '',
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Loại mã: ${nhomVangList[index].loaiMa}",
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "Ký hiệu: ${nhomVangList[index].ghiChu}",
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.of(context).push(
                                      createRoute(
                                        (context) => ChinhSuaNhomVangScreen(nhomVang: nhomVangList[index]),
                                      ),
                                    );
                                    if (result == true) {
                                      _loadNhomVangs(); // Refresh the list when receiving the result
                                    }
                                  },
                                  child: const Icon(
                                    CupertinoIcons.pencil_circle,
                                    // color: Color.fromARGB(200, 255, 140, 0),
                                    color: Colors.black
                                  ),
                                ),
                                const SizedBox(width: 10), 
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Xác nhận"),
                                          content: Text("Bạn có chắc chắn muốn xóa nhóm vàng ${nhomVangList[index].loaiTen?.toUpperCase()}?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: const Text("Hủy"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                final nhomVangManager = Provider.of<NhomVangManager>(context, listen: false);
                                                await nhomVangManager.deleteNhomVang(nhomVangList[index].loaiId!); // Use `loaiId` directly
                                                Navigator.of(context).pop(); // Close the dialog
                                                _loadNhomVangs(); // Refresh the list
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
                                  child: const Icon(
                                    CupertinoIcons.delete_solid, 
                                    // color: Colors.red,
                                    color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ChiTietNhomVangScreen(nhomvang: nhomVangList[index]),
                        //     ),
                        //   );
                        // },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}


