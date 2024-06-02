import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<NhomVang> _filteredNhomVangList = [];
  List<NhomVang> _nhomVangList = [];

  @override
  void initState() {
    super.initState();
    _loadNhomVangs();
    _searchController.addListener(_filterNhomVangs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNhomVangs() async {
    _nhomVangFuture = Provider.of<NhomVangManager>(context, listen: false).fetchLoaiHang();
    _nhomVangFuture.then((nhomVangs) {
      setState(() {
        _nhomVangList = nhomVangs;
        _filteredNhomVangList = nhomVangs;
      });
    });
  }

  void _filterNhomVangs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNhomVangList = _nhomVangList.where((nhomVang) {
        return nhomVang.loaiTen!.toLowerCase().contains(query);
      }).toList();
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
            const Text("Nhóm Vàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
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
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView( // SingleChildScrollView for scrolling
            child: Column(
              children: [
                Search_Bar(searchController: _searchController),
                const SizedBox(height: 12.0),
                ShowList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  FutureBuilder<List<NhomVang>> ShowList() {
    return FutureBuilder<List<NhomVang>>(
      future: _nhomVangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredNhomVangList.length,
            reverse: true,
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
                              _filteredNhomVangList[index].loaiTen ?? '',
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Mã: ${_filteredNhomVangList[index].loaiMa}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                              const SizedBox(width: 20),
                             
                            ],
                          ),
                          Row(
                            children: [
                              
                              Text(
                                "Ký hiệu: ${_filteredNhomVangList[index].ghiChu}",
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
                                  (context) => ChinhSuaNhomVangScreen(nhomVang: _filteredNhomVangList[index]),
                                ),
                              );
                              if (result == true) {
                                _loadNhomVangs(); // Refresh the list when receiving the result
                              }
                            },
                            child: const Icon(
                              CupertinoIcons.pencil_circle,
                              color: Colors.black,
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
                                    content: Text("Bạn có chắc chắn muốn xóa nhóm vàng ${_filteredNhomVangList[index].loaiTen?.toUpperCase()}?"),
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
                                          await nhomVangManager.deleteNhomVang(_filteredNhomVangList[index].loaiId!); // Use `loaiId` directly
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
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
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
