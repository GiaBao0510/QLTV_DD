import 'package:app_qltv/FrontEnd/controller/baocao/BaoCaoPhieuDoi.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuDoi.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:pdf/widgets.dart' as pw;

class BaoCaoPhieuDoiScreen extends StatefulWidget {
  static const routeName = "/baocaophieudoi";

  const BaoCaoPhieuDoiScreen({Key? key}) : super(key: key);

  @override
  _BaocaoPhieuDoiScreenState createState() => _BaocaoPhieuDoiScreenState();
}

class _BaocaoPhieuDoiScreenState extends State<BaoCaoPhieuDoiScreen> {
  late Future<List<BaoCaoPhieuDoi>> _baoCaoPhieuDoiFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoPhieuDoi> _filteredBaoCaoPhieuDoiList = [];
  List<BaoCaoPhieuDoi> _baoCaoPhieuDoiList = [];

  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuDoi();
    _searchController.addListener(_filterBaoCaoTonKhoNhomVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoPhieuDoi() async {
    _baoCaoPhieuDoiFuture =
        Provider.of<BaoCaoPhieuDoiManager>(context, listen: false)
            .fetchBaoCaoPhieuDoi();
    _baoCaoPhieuDoiFuture.then((baoCaoPhieuDoi) {
      setState(() {
        _baoCaoPhieuDoiList = baoCaoPhieuDoi;
        _filteredBaoCaoPhieuDoiList = baoCaoPhieuDoi;
      });
    });
  }

  void _filterBaoCaoTonKhoNhomVang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBaoCaoPhieuDoiList = _baoCaoPhieuDoiList.where((phieudoi) {
        return phieudoi.triGiaBan!.toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<pw.Font> loadFont(String fontPath) async {
    final fontData = await rootBundle.load(fontPath);
    final font = pw.Font.ttf(fontData);
    return font;
  }

  //  Future<void> _handleExport(
  //     List<BaoCaoPhieuDoi> baoCaoPhieuDoiList) async {
  //   final doc = pw.Document();
  //   final font = await loadFont("assets/fonts/Roboto-Regular.ttf");
  //   doc.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return buildPrintBaoCaoPhieuDoi(
  //             baoCaoPhieuDoiList, font, _summary);
  //       }));
  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => doc.save());
  // }

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
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              "Báo Cáo Phiếu Đổi",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
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

  FutureBuilder<List<BaoCaoPhieuDoi>> ShowList() {
    return FutureBuilder<List<BaoCaoPhieuDoi>>(
      future: _baoCaoPhieuDoiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredBaoCaoPhieuDoiList.length,
            itemBuilder: (context, index) {
              final phieudoi = _filteredBaoCaoPhieuDoiList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5.0),
                    Text(phieudoi.maPhieu ?? 'unknow',
                        style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 200, 126),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: tableItem(phieudoi)),
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

  Table tableItem(BaoCaoPhieuDoi phieudoi) {
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
                child: Text('Giá Trị Bán',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Giá Trị Mua',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thanh Toán',
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
                child: Text(formatCurrencyDouble(phieudoi.triGiaBan ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieudoi.triGiaMua ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieudoi.thanhToan ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
