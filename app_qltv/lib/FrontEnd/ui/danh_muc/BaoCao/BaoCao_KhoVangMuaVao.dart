import 'package:app_qltv/FrontEnd/controller/baocao/KhoVangMuaVao_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCao_KhoVangMuaVao.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoNhomVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';

class KhoVangMuaVaoScreen extends StatefulWidget {
  static const routeName = "/KhoVangMuaVao";

  const KhoVangMuaVaoScreen({Key? key}) : super(key: key);

  @override
  _KhoVangMuaVaoScreenState createState() => _KhoVangMuaVaoScreenState();
}

class _KhoVangMuaVaoScreenState extends State<KhoVangMuaVaoScreen> {
  late Future<List<KhoVangMuaVao>> _KhoVangMuaVaoFuture;
  final TextEditingController _searchController = TextEditingController();
  List<KhoVangMuaVao> _filteredKhoVangMuaVaoList = [];
  List<KhoVangMuaVao> _khoVangMuaVaoList = [];

  @override
  void initState() {
    super.initState();
    _loadKhoVangMuaVao();
    _searchController.addListener(_filterBaoCaoTonKhoNhomVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadKhoVangMuaVao() async {
    _KhoVangMuaVaoFuture =
        Provider.of<KhoVangMuaVaoManager>(context, listen: false)
            .fecthKhoVangMuaVao();
    _KhoVangMuaVaoFuture.then((khoVangMuaVao) {
      setState(() {
        _khoVangMuaVaoList = khoVangMuaVao;
        _filteredKhoVangMuaVaoList = khoVangMuaVao;
      });
    });
  }

  void _filterBaoCaoTonKhoNhomVang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKhoVangMuaVaoList = _khoVangMuaVaoList.where((khovang) {
        return khovang.tenHangHoa!.toLowerCase().contains(query);
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
            child: Text("Kho Vàng Mua Vào",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
          )),
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

  FutureBuilder<List<KhoVangMuaVao>> ShowList() {
    return FutureBuilder<List<KhoVangMuaVao>>(
      future: _KhoVangMuaVaoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredKhoVangMuaVaoList.length,
            itemBuilder: (context, index) {
              final khoVang = _filteredKhoVangMuaVaoList[index];
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
                        khoVang.tenHangHoa!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      tilePadding:
                          const EdgeInsets.only(left: 20, top: 5, bottom: 0),
                      backgroundColor: Colors.transparent,
                      childrenPadding: const EdgeInsets.only(
                          left: 20, top: 0, bottom: 10, right: 20),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nhóm Vàng: ${khoVang.tenNhomHang!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        tableItem(khoVang),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Table tableItem(KhoVangMuaVao khovang) {
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
                child: Text('TL Lọc',
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
                child: Text(formatCurrencyDouble(khovang.tLThuc ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(khovang.tLHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(khovang.tLLoc ?? 0)),
              ),
            ),
          ],
        ),
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Cân Tổng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Số Lượng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Đơn Giá',
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
                child: Text(formatCurrencyDouble(khovang.canTong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(khovang.soLuong.toString()),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(khovang.donGia ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
