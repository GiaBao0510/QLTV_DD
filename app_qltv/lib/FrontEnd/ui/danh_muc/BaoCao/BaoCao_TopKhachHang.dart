import 'package:app_qltv/FrontEnd/controller/baocao/BaoCaoTopKhachHang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCao_TopKhachHang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';

class BaoCaoTopKhachHangScreen extends StatefulWidget {
  static const routeName = "/baocaophieudoi";

  const BaoCaoTopKhachHangScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoTopKhachHangScreenState createState() =>
      _BaoCaoTopKhachHangScreenState();
}

class _BaoCaoTopKhachHangScreenState extends State<BaoCaoTopKhachHangScreen> {
  late Future<List<TopKhachHang>> _baoCaoTopKhachHangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<TopKhachHang> _filteredTopKhachHangList = [];
  List<TopKhachHang> _baoCaoTopKhachHangList = [];

  @override
  void initState() {
    super.initState();
    _loadTopKhachHang();
    _searchController.addListener(_filterBaoCaoTonKhoNhomVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTopKhachHang() async {
    _baoCaoTopKhachHangFuture =
        Provider.of<TopKhachHangManager>(context, listen: false)
            .fetchBaoCaoTopKhachHang();
    _baoCaoTopKhachHangFuture.then((baoCaoTopKhachHang) {
      setState(() {
        _baoCaoTopKhachHangList = baoCaoTopKhachHang;
        _filteredTopKhachHangList = baoCaoTopKhachHang;
      });
    });
  }

  void _filterBaoCaoTonKhoNhomVang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTopKhachHangList = _filteredTopKhachHangList.where((khachHang) {
        return khachHang.tenKH!.toString().toLowerCase().contains(query);
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
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Khách Hàng Giao Dịch",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: IconButton(
        //       onPressed: () async {
        //         _handleExport(_filteredTopKhachHangList);
        //       },
        //       icon: Image.asset("assets/images/export.png"),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Search_Bar(searchController: _searchController),
              const SizedBox(height: 12.0),
              Expanded(
                child: ShowList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<TopKhachHang>> ShowList() {
    return FutureBuilder<List<TopKhachHang>>(
      future: _baoCaoTopKhachHangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredTopKhachHangList.length,
            itemBuilder: (context, index) {
              final topKhachHang = _filteredTopKhachHangList[index];
              return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: tableItem(topKhachHang));
            },
          );
        }
      },
    );
  }

  Padding tableItem(TopKhachHang topKhachHang) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Table(
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
                  child: Text('Tên Khách Hàng',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tổng Tiền Mua',
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
                  child: Text(topKhachHang.tenKH!),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(formatCurrencyDouble(topKhachHang.tongTien ?? 0)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
