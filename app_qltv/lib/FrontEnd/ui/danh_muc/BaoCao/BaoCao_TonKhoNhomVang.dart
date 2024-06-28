import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoNhomVang_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoNhomVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';

class BaoCaoTonKhoNhomVangScreen extends StatefulWidget {
  static const routeName = "/baocaotonkhonhomvang";

  const BaoCaoTonKhoNhomVangScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoTonKhoNhomVangScreenState createState() =>
      _BaoCaoTonKhoNhomVangScreenState();
}

class _BaoCaoTonKhoNhomVangScreenState
    extends State<BaoCaoTonKhoNhomVangScreen> {
  late Future<List<BaoCaoTonKhoNhomVang>> _baoCaoTonKhoNhomVangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoTonKhoNhomVang> _filteredBaoCaoTonKhoNhomVangList = [];
  List<BaoCaoTonKhoNhomVang> _baoCaoTonKhoNhomVangList = [];

  @override
  void initState() {
    super.initState();
    _loadBaoCaoTonKhoNhomVang();
    _searchController.addListener(_filterBaoCaoTonKhoNhomVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoTonKhoNhomVang() async {
    _baoCaoTonKhoNhomVangFuture =
        Provider.of<BaoCaoTonKhoNhomVangManager>(context, listen: false)
            .fetchBaoCaoTonKhoNhomVang();
    _baoCaoTonKhoNhomVangFuture.then((baoCaos) {
      setState(() {
        _baoCaoTonKhoNhomVangList = baoCaos;
        _filteredBaoCaoTonKhoNhomVangList = baoCaos;
      });
    });
  }

  void _filterBaoCaoTonKhoNhomVang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBaoCaoTonKhoNhomVangList =
          _baoCaoTonKhoNhomVangList.where((baoCao) {
        return baoCao.loaiTen.toLowerCase().contains(query);
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
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Tồn Kho Theo Nhóm Vàng",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
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

  FutureBuilder<List<BaoCaoTonKhoNhomVang>> ShowList() {
    return FutureBuilder<List<BaoCaoTonKhoNhomVang>>(
      future: _baoCaoTonKhoNhomVangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredBaoCaoTonKhoNhomVangList.length,
            itemBuilder: (context, index) {
              final baoCao = _filteredBaoCaoTonKhoNhomVangList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        baoCao.loaiTen,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      tilePadding:
                          const EdgeInsets.only(left: 20, top: 5, bottom: 0),
                      backgroundColor: Colors.transparent,
                      childrenPadding:
                          const EdgeInsets.only(left: 10, top: 0, bottom: 10),
                      children: baoCao.data.map((hangHoa) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(50, 169, 169, 169),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    hangHoa.hangHoaTen!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                tableItem(hangHoa),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Công Gốc: ${formatCurrencyDouble(hangHoa.congGoc ?? 0)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Giá Công: ${formatCurrencyDouble(hangHoa.giaCong ?? 0)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 15.0, top: 10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(100, 169, 169, 169),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const ListTile(
                                title: Text(
                                  'Tổng:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              tableSumary(baoCao),
                              const SizedBox(height: 10),
                              tableSumaryCurrency(baoCao),
                            ]))),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Table tableItem(HangHoa hangHoa) {
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
                child: Text('TL Thực',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Hột',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Vàng',
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
                child: Text(formatCurrencyDouble(hangHoa.canTong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(hangHoa.tlHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(hangHoa.tlVang ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Table tableSumary(BaoCaoTonKhoNhomVang baoCao) {
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
                child: Text('Tổng TL Thực',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng TL Hột',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng TL Vàng',
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
                child: Text(formatCurrencyDouble(baoCao.tongTlThuc)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongTlHot)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongTlVang)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Table tableSumaryCurrency(BaoCaoTonKhoNhomVang baoCao) {
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
                child: Text('Tổng Công Gốc',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng Giá Công',
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
                child: Text(formatCurrencyDouble(baoCao.tongCongGo)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyInteger(baoCao.tongGiaCong)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
