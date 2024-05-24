import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/components/chinh_sua_loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/components/them_loai_vang.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/chinh_sua_loai_vang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LoaiVangScreen extends StatefulWidget {
  static const routeName = "/loaivang";

  const LoaiVangScreen({Key? key}) : super(key: key);

  @override
  _LoaiVangScreenState createState() => _LoaiVangScreenState();
}

class _LoaiVangScreenState extends State<LoaiVangScreen> {
  late Future<List<LoaiVang>> _loaiVangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<LoaiVang> _filteredLoaiVanngList = [];
  List<LoaiVang> _loaiVangList = [];

  @override
  void initState() {
    super.initState();
    _loadLoaiVanngs();
    _searchController.addListener(_filterLoaiVanngs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadLoaiVanngs() async {
    _loaiVangFuture = Provider.of<LoaiVangManager>(context, listen: false).fetchLoaiHang();
    _loaiVangFuture.then((loaiVangs) {
      setState(() {
        _loaiVangList = loaiVangs;
        _filteredLoaiVanngList = loaiVangs;
      });
    });
  }

  void _filterLoaiVanngs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLoaiVanngList = _loaiVangList.where((loaiVang) {
        return loaiVang.nhomTen!.toLowerCase().contains(query);
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
            const Text("Loại Vàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => const ThemLoaiVangScreen()),
                );
                if (result == true) {
                  _loadLoaiVanngs(); // Refresh the list when receiving the result
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
  FutureBuilder<List<LoaiVang>> ShowList() {
    return FutureBuilder<List<LoaiVang>>(
      future: _loaiVangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredLoaiVanngList.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(50, 169, 169, 169),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _filteredLoaiVanngList[index].nhomTen ?? '',
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              editMethod(context, index),
                              const SizedBox(width: 10),
                              deleteMethod(context, index),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Mã: ${_filteredLoaiVanngList[index].nhomHangMa}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Đơn giá vốn: ${_filteredLoaiVanngList[index].donGiaVon?.toStringAsFixed(0).replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},'
                            )}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Đơn giá mua: ${_filteredLoaiVanngList[index].donGiaMua?.toStringAsFixed(0).replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},'
                            )}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Đơn giá bán: ${_filteredLoaiVanngList[index].donGiaBan?.toStringAsFixed(0).replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},'
                            )}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Đơn giá cầm: ${_filteredLoaiVanngList[index].donGiaCam?.toStringAsFixed(0).replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},'
                            )}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
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

  GestureDetector deleteMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận"),
              content: Text("Bạn có chắc chắn muốn xóa nhà cung cấp ${_filteredLoaiVanngList[index].nhomTen?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final nhaCungCapManager = Provider.of<LoaiVangManager>(context, listen: false);
                    await nhaCungCapManager.deleteLoaiVang(_filteredLoaiVanngList[index].nhomHangId!); // Use `ncc_id` directly
                    Navigator.of(context).pop(); // Close the dialog
                    _loadLoaiVanngs(); // Refresh the list
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
    );
  }

  GestureDetector editMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          createRoute(
            (context) => ChinhSuaLoaiVangScreen(loaiVang: _filteredLoaiVanngList[index]),
          ),
        );
        if (result == true) {
          _loadLoaiVanngs(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
    );
  }



}
