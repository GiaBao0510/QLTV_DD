import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoNhomVang_manager.dart';
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
        return baoCao.data.any(
            (hangHoa) => hangHoa.hangHoaTen!.toLowerCase().contains(query));
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
            const Text("Báo Cáo Tồn Kho Nhóm Vàng",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
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
                  color: Color.fromARGB(255, 218, 218, 218),
                  borderRadius: BorderRadius.circular(
                      15), // Sets border radius to 15 pixels
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text('Báo cáo ${index + 1}'),
                      children: baoCao.data.map((hangHoa) {
                        return ListTile(
                          title: Text(hangHoa.hangHoaTen!),
                          subtitle: Text(
                              'TL Thực: ${hangHoa.canTong}, Giá Công: ${hangHoa.giaCong}'),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tổng TL Thực: ${baoCao.tongTlThuc}'),
                              Text('Tổng TL Hột: ${baoCao.tongTlHot}'),
                              Text('Tổng TL Vàng: ${baoCao.tongTlVang}'),
                              Text('Tổng Công Gốc: ${baoCao.tongCongGo}'),
                              Text('Tổng Giá Công: ${baoCao.tongGiaCong}'),
                            ],
                          ),
                        )
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
}
