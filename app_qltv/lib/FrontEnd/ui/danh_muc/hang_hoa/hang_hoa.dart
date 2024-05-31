import 'package:app_qltv/FrontEnd/controller/danhmuc/hanghoa_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/components/chi_tiet_don_hang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/components/chinh_sua_hang_hoa.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/components/them_hang_hoa.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';

import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart';

import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';

import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HangHoaScreen extends StatefulWidget {
  static const routeName = "/hanghoa";

  const HangHoaScreen({Key? key}) : super(key: key);

  @override
  _HangHoaScreenState createState() => _HangHoaScreenState();
}

class _HangHoaScreenState extends State<HangHoaScreen> {
  late Future<List<HangHoa>> _hangHoaFuture;
  final TextEditingController _searchController = TextEditingController();
  List<HangHoa> _filteredHangHoaList = [];
  List<HangHoa> _hangHoaList = [];
  late List<LoaiVang> loaiVangList; // Khai báo thuộc tính loaiVangList
  late List<NhomVang> nhomVangList; // Khai báo thuộc tính nhomVangList

  @override
  void initState() {
    super.initState();
    _loadHangHoas();
    _searchController.addListener(_filterHangHoas);
    // Gán giá trị cho loaiVangList và nhomVangList ở đây
    loaiVangList = []; // Gán giá trị ban đầu cho loaiVangList
    nhomVangList = []; 
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHangHoas() async {
    _hangHoaFuture =
        Provider.of<HangHoaManager>(context, listen: false).fetchHangHoas();
    _hangHoaFuture.then((hangHoas) {
      setState(() {
        _hangHoaList = hangHoas;
        _filteredHangHoaList = hangHoas;
      });
    });
  }

  void _filterHangHoas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHangHoaList = _hangHoaList.where((hangHoa) {
        return hangHoa.hangHoaTen!.toLowerCase().contains(query);
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
            const Text("Hàng Hóa",
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
                  createRoute((context) => ThemHangHoaScreen()),
                );
                if (result == true) {
                  _loadHangHoas(); // Refresh the list when receiving the result
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
          child: SingleChildScrollView(
            // SingleChildScrollView for scrolling
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
  FutureBuilder<List<HangHoa>> ShowList() {
    return FutureBuilder<List<HangHoa>>(
      future: _hangHoaFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics:
                NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredHangHoaList.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                 Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => ChiTietHangHoaScreen(
      hangHoa: _filteredHangHoaList[index],
      loaiVangList: loaiVangList, // Thêm tham số loaiVangList vào đây
      nhomVangList: nhomVangList, // Đảm bảo cũng cung cấp tham số nhomVangList
    ),
  ),
);

                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
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
                                    "Mã Hàng: ${_filteredHangHoaList[index].hangHoaMa}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              _filteredHangHoaList[index].hangHoaTen ?? '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        //  Row(
                        //   children: [
                        //     Text(
                        //       "Mã Loại Vàng: ${int.parse(_filteredHangHoaList[index].nhomHangId!).toString()}",
                        //       style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Ngày Sản Xuất: ${_filteredHangHoaList[index].ngaySanXuat}",
                        //       style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: Tooltip(
                        //         message: _filteredHangHoaList[index].ghiChu ?? '',
                        //         child: Text(
                        //           "Ghi Chú: ${_filteredHangHoaList[index].ghiChu}",
                        //           style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  GestureDetector editMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          createRoute(
            (context) =>
                ChinhSuaHangHoaScreen(hangHoa: _filteredHangHoaList[index]),
          ),
        );
        if (result == true) {
          _loadHangHoas(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
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
              content: Text(
                  "Bạn có chắc chắn muốn xóa hàng hóa ${_filteredHangHoaList[index].hangHoaTen?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final hangHoaManager =
                        Provider.of<HangHoaManager>(context, listen: false);
                    await hangHoaManager.deleteHangHoa(
                        _filteredHangHoaList[index]
                            .hangHoaMa!); // Use `hangHoaId` directly
                    Navigator.of(context).pop(); // Close the dialog
                    _loadHangHoas(); // Refresh the list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Xóa thành công!',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                              color: Colors.grey, width: 2.0), // bo viền 15px
                        ),
                        behavior: SnackBarBehavior
                            .floating, // hiển thị ở cách đáy màn hình
                        margin: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
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
}
