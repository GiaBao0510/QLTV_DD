import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/components/chi_tiet_kh.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/components/them_kh.dart';

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

  Future<void> _loadKhachhang() async {
    _khachhangFuture = Provider.of<KhachhangManage>(context, listen: false).fetchKhachhang();
    _khachhangFuture.then((khachhangs) {
      setState(() {
        _khachhangList = khachhangs;
        _filteredKhachhangList = khachhangs;
      });
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
            const Text("Khách hàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
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
                  _loadKhachhang(); // Refresh the list when receiving the result
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
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredKhachhangList.length,
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
                                  _filteredKhachhangList[index].kh_ten ?? '',
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
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
                            "Mã: ${_filteredKhachhangList[index].kh_ma}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                    ]
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
              content: Text("Bạn có chắc chắn muốn xóa đơn vị ${_filteredKhachhangList[index].kh_ten?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final khachhangManage = Provider.of<KhachhangManage>(context, listen: false);
                    await khachhangManage.deleteKhachhang(int.parse(_filteredKhachhangList[index].kh_id!)); 
                    Navigator.of(context).pop(); // Close the dialog
                    _loadKhachhang(); // Refresh the list
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

  
}
