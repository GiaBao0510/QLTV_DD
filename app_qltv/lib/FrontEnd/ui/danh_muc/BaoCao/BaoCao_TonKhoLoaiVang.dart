import 'package:app_qltv/FrontEnd/Service/export/PDF/BaoCaoTonKhoLoaiVang_PDF.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoLoaiVang_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoLoaiVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/Chart_LoaiVang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:pdf/widgets.dart' as pw;

class BaoCaoTonKhoLoaiVangScreen extends StatefulWidget {
  static const routeName = "/baocaotonkholoaivang";

  const BaoCaoTonKhoLoaiVangScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoTonKhoLoaiVangScreenState createState() =>
      _BaoCaoTonKhoLoaiVangScreenState();
}

class _BaoCaoTonKhoLoaiVangScreenState
    extends State<BaoCaoTonKhoLoaiVangScreen> {
  late Future<List<BaoCaoTonKhoLoaiVang>> _baoCaoTonKhoLoaiVangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoTonKhoLoaiVang> _filteredBaoCaoTonKhoLoaiVangList = [];
  List<BaoCaoTonKhoLoaiVang> _baoCaoTonKhoLoaiVangList = [];
  late Map<String, double> _summary;
  late Map<String, double> _percentage;
  // ignore: unused_field
  String _selectedItem = '';

  @override
  void initState() {
    super.initState();
    _summary = {
      'tongTLThuc': 0.0,
      'tongTLHot': 0.0,
      'tongTLVang': 0.0,
      'tongCongGoc': 0.0,
      'tongGiaCong': 0.0,
      'tongThanhTien': 0.0
    };
    _loadBaoCaoTonKhoLoaiVang();
    _searchController.addListener(_filterBaoCaoTonKhoLoaiVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoTonKhoLoaiVang() async {
    _baoCaoTonKhoLoaiVangFuture =
        Provider.of<BaoCaoTonKhoLoaiVangManager>(context, listen: false)
            .fetchBaoCaoTonKhoLoaiVang();
    _baoCaoTonKhoLoaiVangFuture.then((baoCao) {
      setState(() {
        _baoCaoTonKhoLoaiVangList = baoCao;
        _filteredBaoCaoTonKhoLoaiVangList = baoCao;
        _calculateSummary();
      });
    });
  }

  void _filterBaoCaoTonKhoLoaiVang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBaoCaoTonKhoLoaiVangList =
          _baoCaoTonKhoLoaiVangList.where((baoCao) {
        return baoCao.data.any((loaiVangTonKho) =>
            loaiVangTonKho.hangHoaTen?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  void _calculateSummary() {
    double tongTLThuc = 0.0;
    double tongTLHot = 0.0;
    double tongTLVang = 0.0;
    double tongCongGoc = 0.0;
    double tongGiaCong = 0.0;
    double tongThanhTien = 0.0;

    for (BaoCaoTonKhoLoaiVang baoCao in _baoCaoTonKhoLoaiVangList) {
      tongTLThuc += baoCao.tongTlThuc!;
      tongTLHot += baoCao.tongTlHot!;
      tongTLVang += baoCao.tongTlVang!;
      tongCongGoc += baoCao.tongCongGoc!;
      tongGiaCong += baoCao.tongGiaCong!;
      tongThanhTien += baoCao.tongThanhTien!;
    }

    _summary = {
      'tongTLThuc': tongTLThuc,
      'tongTLHot': tongTLHot,
      'tongCongGoc': tongCongGoc,
      'tongTLVang': tongTLVang,
      'tongGiaCong': tongGiaCong,
      'tongThanhTien': tongThanhTien,
    };
  }

  void _onOptionSelected(String option) {
    setState(() {
      _selectedItem = option;
    });
    // Gọi hàm tùy chọn khi chọn một tùy chọn
    switch (option) {
      case 'Export':
        _handleExport(_baoCaoTonKhoLoaiVangList);
        break;
      case 'QuyDoi':
        _handleQuyDoi();
        break;
      case 'ThongKe':
        _handleThongKe();
        break;
    }
  }

  void _calculatePercentage() {
    // Khởi tạo một map để lưu trữ tổng trọng lượng của mỗi nhóm
    Map<String, double> totalWeightByGroup = {};
    double totalWeightAllGroups = 0;
    // Tính tổng trọng lượng của mỗi nhóm
    for (BaoCaoTonKhoLoaiVang baoCao in _baoCaoTonKhoLoaiVangList) {
      String nhomTen = baoCao.nhomTen;
      double trongLuong = baoCao.tongThanhTien ?? 0.0;
      // Thêm trọng lượng vào tổng của nhóm
      totalWeightByGroup[nhomTen] =
          (totalWeightByGroup[nhomTen] ?? 0.0) + trongLuong;
      totalWeightAllGroups += baoCao.tongThanhTien!;
      // In ra giá trị để kiểm tra
      print('Nhóm: $nhomTen, Trọng lượng: $trongLuong');
    }
    // In ra tổng trọng lượng của tất cả các nhóm
    print('Tổng trọng lượng tất cả các nhóm: $totalWeightAllGroups');
    // Tính phần trăm cho mỗi nhóm
    Map<String, double> percentageByGroup = {};
    totalWeightByGroup.forEach((nhomTen, totalWeight) {
      double percentage = totalWeight / totalWeightAllGroups * 100;
      percentageByGroup[nhomTen] = percentage;
      print(
          'Nhóm: $nhomTen, Tổng trọng lượng: $totalWeight, Phần trăm: $percentage');
    });

    // Gán kết quả vào _percentage
    setState(() {
      _percentage = percentageByGroup;
    });
  }

  Future<void> _handleExport(
      List<BaoCaoTonKhoLoaiVang> baoCaoTonKhoLoaiVangList) async {
    final doc = pw.Document();
    final font = await loadFontLoaiVang("assets/fonts/Roboto-Regular.ttf");
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableLoaiVang(
              baoCaoTonKhoLoaiVangList, font, _summary);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  void _handleQuyDoi() {
    print('Option 2 selected');
    // Thực hiện các hành động khác cho Option 2 ở đây
  }

  void _handleThongKe() {
    print('Option 3 selected');
    _calculatePercentage();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PieChartDialog(_percentage);
      },
    );
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
        title:  const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Báo Cáo Tồn Kho Nhóm Vàng",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900)),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: _onOptionSelected,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Export',
                  child: Center(child: Text('Export')),
                ),
                const PopupMenuItem<String>(
                  value: 'QuyDoi',
                  child: Center(child: Text('Quy Đổi')),
                ),
                const PopupMenuItem<String>(
                  value: 'ThongKe',
                  child: Center(child: Text('Thống Kê')),
                ),
              ];
            },
          ),
        ],
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
                        child: tableTotal(_summary),
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

  // ignore: non_constant_identifier_names
  FutureBuilder<List<BaoCaoTonKhoLoaiVang>> ShowList() {
    return FutureBuilder<List<BaoCaoTonKhoLoaiVang>>(
      future: _baoCaoTonKhoLoaiVangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredBaoCaoTonKhoLoaiVangList.length,
            itemBuilder: (context, index) {
              final baoCao = _filteredBaoCaoTonKhoLoaiVangList[index];
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
                        baoCao.nhomTen,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      tilePadding:
                          const EdgeInsets.only(left: 20, top: 5, bottom: 0),
                      backgroundColor: Colors.transparent,
                      childrenPadding:
                          const EdgeInsets.only(left: 10, top: 0, bottom: 10),
                      children: baoCao.data.map((loaiVangTonKho) {
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
                                    loaiVangTonKho.hangHoaTen!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                tableItem(loaiVangTonKho),
                                const SizedBox(height: 10),
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
                        color: Color.fromARGB(255, 201, 201, 201),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text(
                                'Tổng:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            tableSummary(baoCao),
                            const SizedBox(height: 10),
                            tableSummaryCurrency(baoCao),
                          ],
                        ),
                      ),
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

  Table tableItem(LoaiVangTonKho loaiVangTonKho) {
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
                child: Text(formatCurrencyDouble(loaiVangTonKho.canTong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(loaiVangTonKho.tlHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(loaiVangTonKho.tlVang ?? 0)),
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
                child: Text('Công Gốc',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Giá Công',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thành Tiền',
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
                child: Text(formatCurrencyDouble(loaiVangTonKho.congGoc ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(loaiVangTonKho.giaCong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(formatCurrencyDouble(loaiVangTonKho.thanhTien ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Table tableSummary(BaoCaoTonKhoLoaiVang baoCao) {
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
                child: Text(formatCurrencyDouble(baoCao.tongTlThuc ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongTlHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongTlVang ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Table tableSummaryCurrency(BaoCaoTonKhoLoaiVang baoCao) {
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
                child: Text('Công Gốc',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Giá Công',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thành Tiền',
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
                child: Text(formatCurrencyDouble(baoCao.tongCongGoc ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongGiaCong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(baoCao.tongThanhTien ?? 0)),
              ),
            ),
          ],
        ),
      ],
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
                child: Text(formatCurrencyDouble(total['tongTLThuc'] ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(total['tongTLHot '] ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(total['tongTLVang'] ?? 0)),
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
                child: Text('Công Gốc',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Giá Công',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thành Tiền',
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
                child: Text(formatCurrencyDouble(total['tongCongGoc'] ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(total['tongGiaCong'] ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(total['tongThanhTien'] ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
