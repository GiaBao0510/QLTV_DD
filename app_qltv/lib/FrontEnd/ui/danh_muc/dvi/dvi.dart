import 'package:app_qltv/FrontEnd/model/danhmuc/donvi.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/don_vi_manage.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/components/chi_tiet_dvi.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/components/chinh_sua_dv.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/components/them_dvi.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonviScreen extends StatefulWidget {
  static const routeName = "/dvi";

  const DonviScreen({Key? key}) : super(key: key);

  @override
  _DonviScreenState createState() => _DonviScreenState();
}

class _DonviScreenState extends State<DonviScreen> {
  late Future<List<Donvi>> _donviFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Donvi> _filteredDonviList = [];
  List<Donvi> _donviList = [];

  @override
  void initState() {
    super.initState();
    _loadDonvi();
    _searchController.addListener(_filterDonvi);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDonvi() async {
    _donviFuture =
        Provider.of<DonviManage>(context, listen: false).fetchDonvi();
    _donviFuture.then((donvis) {
      setState(() {
        _donviList = donvis;
        _filteredDonviList = donvis;
      });
    });
  }

  void _filterDonvi() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDonviList = _donviList.where((donvi) {
        return donvi.dvi_ten!.toLowerCase().contains(query);
      }).toList();
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
            const Text("Đơn vị",
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
                  createRoute((context) => const ThemDonviScreen()),
                );
                if (result == true) {
                  _loadDonvi(); // Refresh the list when receiving the result
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
  FutureBuilder<List<Donvi>> ShowList() {
    return FutureBuilder<List<Donvi>>(
      future: _donviFuture,
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
            itemCount: _filteredDonviList.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _filteredDonviList[index].dvi_ten ?? '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mã: ${_filteredDonviList[index].dvi_ma}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "Địa chỉ: ${_filteredDonviList[index].dvi_ghichu}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "Tên hóa đơn: ${_filteredDonviList[index].dvi_ten_hd}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "Địa chỉ hóa đơn: ${_filteredDonviList[index].dvi_dia_chi_hd}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "SĐT: ${_filteredDonviList[index].dvi_sdt}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "Tên giao dịch: ${_filteredDonviList[index].dvi_ten_gd}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "Lưu ý: ${_filteredDonviList[index].dvi_luu_y}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Địa chỉ: ${_filteredDonviList[index].dvi_ghichu}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Tên hóa đơn: ${_filteredDonviList[index].dvi_ten_hd}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Địa chỉ hóa đơn: ${_filteredDonviList[index].dvi_dia_chi_hd}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "SĐT: ${_filteredDonviList[index].dvi_sdt}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Tên giao dịch: ${_filteredDonviList[index].dvi_ten_gd}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                    //  Column(
                    //   children: [
                    //     Text(
                    //       "Lưu ý: ${_filteredDonviList[index].dvi_luu_y}",
                    //       style: const TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 14),
                    //     ),
                    //   ],
                    // ),
                  ]),
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
              content: Text(
                  "Bạn có chắc chắn muốn xóa đơn vị ${_filteredDonviList[index].dvi_ten?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final donviManage =
                        Provider.of<DonviManage>(context, listen: false);
                    await donviManage.deleteDonvi(
                        int.parse(_filteredDonviList[index].dvi_id!));
                    Navigator.of(context).pop(); // Close the dialog
                    _loadDonvi(); // Refresh the list
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

  GestureDetector editMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          createRoute(
            (context) => ChinhSuaDonViScreen(donvi: _filteredDonviList[index]),
          ),
        );
        if (result == true) {
          _loadDonvi(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
    );
  }
}
