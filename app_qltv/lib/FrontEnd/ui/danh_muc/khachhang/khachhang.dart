import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/components/chi_tiet_kh.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/components/them_kh.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KhachhangScreen extends StatefulWidget {
  static const routeName = "/khach";

  const KhachhangScreen({Key? key}) : super(key: key);

  @override
  _KhachhangScreenState createState() => _KhachhangScreenState();
}

class _KhachhangScreenState extends State<KhachhangScreen> {
  late Future<List<Khachhang>> _khachhangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Khachhang> _filteredKhachhangList = [];
  List<Khachhang> _khachhangList = [];
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalKhachhang = 0;
  int _totalRows = 0;
  @override
  void initState() {
    super.initState();
    _loadKhachhang();
    _searchController.addListener(_filterKhachhang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadKhachhang({int page = 1}) async {
    final manager = Provider.of<KhachhangManage>(context, listen: false);

       _khachhangFuture = manager.fetchKhachhang(page: page, pageSize: _pageSize);
    _khachhangFuture.then((khachhangs) {
      setState(() {
        _khachhangList = khachhangs;
        _filteredKhachhangList = khachhangs;
        _currentPage = page;
        _totalRows = manager.totalRows;
       
      });
    });
  }
  
  Future<void> _loadTotalKhachhang() async {
    final totalKhachhang = await Provider.of<KhachhangManage>(context, listen: false).fetchTotalKhachhang();
   
    setState(() {
      _totalKhachhang = totalKhachhang;
    });
  }

  void _filterKhachhang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKhachhangList = _khachhangList.where((khachhang) {
        return khachhang.kh_ten!.toLowerCase().contains(query);
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
            const Text(
              "Khách hàng",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => const ThemKhachhangScreen()),
                );
                if (result == true) {
                  _loadKhachhang(page: _currentPage);
                  _loadTotalKhachhang();
                }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        //child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                
                Search_Bar(searchController: _searchController),
                const SizedBox(height: 12.0),
                Expanded(child: ShowList(),),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _currentPage > 1,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadKhachhang(page: _currentPage - 1);
                        },
                        child: const Text("Trang trước"),
                      ),
                    ),
                    Visibility(
                      visible: _currentPage <
                          Provider.of<KhachhangManage>(context, listen: false)
                              .totalPages,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadKhachhang(page: _currentPage + 1);
                        },
                        child: const Text("Trang kế tiếp"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      //),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 228, 200, 126),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Tổng Quan',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: tableTotal({
                          'total': _totalRows.toDouble(),
                        },
                      ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        tooltip: 'Show Bottom Sheet',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/list.png'),
        ),
      ),
    
      );
    
  }

  FutureBuilder<List<Khachhang>> ShowList() {
    return FutureBuilder<List<Khachhang>>(
      future: _khachhangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
           // shrinkWrap: true,
           // physics: NeverScrollableScrollPhysics(),
            itemCount: _filteredKhachhangList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
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
                                  "Mã: ${_filteredKhachhangList[index].kh_ma}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              deleteMethod(context, index),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _filteredKhachhangList[index].kh_ten ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "CMND: ${_filteredKhachhangList[index].kh_cmnd}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Điện thoại: ${_filteredKhachhangList[index].kh_sdt}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Địa chỉ: ${_filteredKhachhangList[index].kh_dia_chi}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Ghi chú: ${_filteredKhachhangList[index].kh_ghi_chu}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
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

  GestureDetector deleteMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận"),
              content: Text(
                "Bạn có chắc chắn muốn xóa đơn vị ${_filteredKhachhangList[index].kh_ten?.toUpperCase()}?",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final khachhangManage =
                        Provider.of<KhachhangManage>(context, listen: false);
                    await khachhangManage.deleteKhachhang(
                        int.parse(_filteredKhachhangList[index].kh_id!));
                    Navigator.of(context).pop(); // Close the dialog
                    _loadKhachhang(); // Refresh the list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Xóa thành công!',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,
                        ),
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
Table tableTotal(Map<String, double> total) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng Khách hàng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
           
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${total['total']?.toInt() ?? 0}'),
              ),
            ),
            
          ],
        ),
        
      ],
    );
  }
}
