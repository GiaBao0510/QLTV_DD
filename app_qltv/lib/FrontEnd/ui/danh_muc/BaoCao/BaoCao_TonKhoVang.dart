import 'package:app_qltv/FrontEnd/Service/export/Excel/BaoCaoTonKhoVang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../model/danhmuc/BaoCaoTonKhoVang.dart';
import '../../../controller/danhmuc/BaoCaoTonKhoVang_manager.dart';
import '../../components/search_bar.dart';
import '../../../ui/components/FormatCurrency.dart';
import '../../../Service/export/PDF/BaoCaoTonKhoVang_PDF.dart';

class BaoCaoTonKhoVangScreen extends StatefulWidget {
  static const routeName = '/baocaotonkhovang';
  const BaoCaoTonKhoVangScreen({Key? key}) : super(key: key);
  @override
  _BaoCaoTonKhoVangScreen createState() => _BaoCaoTonKhoVangScreen();
}

class _BaoCaoTonKhoVangScreen extends State<BaoCaoTonKhoVangScreen> {
  late Future<List<BaoCaoTonKhoVang_Model>> _BaoCaoTonKhoVangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoTonKhoVang_Model> _filterBaoCaoTonKhoVang = [];
  List<BaoCaoTonKhoVang_Model> _BaoCaoTonKhoVangList = [];
  var thongTinTinhTong2;

  double tong_TLthuc = 0.0,
      tong_TLhot = 0.0,
      tong_TLvang = 0.0,
      tong_CongGoc = 0.0,
      tong_GiaCong = 0.0,
      tong_ThanhTien = 0.0;

  @override
  void initState() {
    super.initState();
    LoadData();
    _searchController.addListener(_filterBaocaoTonKho);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ----- Phương thức ------
  //1. Load dữ liệu
  Future<void> LoadData() async {
    _BaoCaoTonKhoVangFuture =
        Provider.of<BaocaotonkhovangManager>(context, listen: false)
            .fetchBaoCaoTonKhoVang();
    _BaoCaoTonKhoVangFuture.then((baocao) {
      setState(() {
        _BaoCaoTonKhoVangList = baocao;
        _filterBaoCaoTonKhoVang = baocao;
      });

      //Xu ly tinh tong
      for (int i = 0; i < _filterBaoCaoTonKhoVang.length; i++) {
        final item = _filterBaoCaoTonKhoVang[i];
        tong_TLvang += item.TL_vang;
        tong_TLthuc += item.TL_Thuc;
        tong_TLhot += item.TL_hot;
        tong_GiaCong += item.GIA_CONG;
        tong_CongGoc += item.CONG_GOC;
        tong_ThanhTien += item.ThanhTien;
      }
    });
  }

  //2. Lọc dữ liệu
  void _filterBaocaoTonKho() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filterBaoCaoTonKhoVang = _BaoCaoTonKhoVangList.where((element) {
        return element.NHOM_TEN.toLowerCase().contains(query);
      }).toList();
    });
  }

  //3. Xuất bảng PDF
  Future<void> printDoc(List<BaoCaoTonKhoVang_Model> data,
      Map<String, dynamic> GetThongTinTinhTong) async {
    final font = await loadFont('assets/fonts/Roboto-Regular.ttf');
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(data, font, GetThongTinTinhTong);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  void printExcel(List<BaoCaoTonKhoVang_Model> data,
      Map<String, dynamic> GetThongTinTinhTong) {
    exportExcelTonKhoVang(data, GetThongTinTinhTong);
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
            const Text("Báo Cáo Tồn Kho",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {
                      thongTinTinhTong2 = {
                        'tong_TLvang': tong_TLvang,
                        'tong_TLthuc': tong_TLthuc,
                        'tong_TLhot': tong_TLhot,
                        'tong_GiaCong': tong_GiaCong,
                        'tong_CongGoc': tong_CongGoc,
                        'tong_ThanhTien': tong_ThanhTien
                      };

                      printDoc(_filterBaoCaoTonKhoVang, thongTinTinhTong2);
                    },
                    child: Text('Export PDF'),
                  )),
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {
                      thongTinTinhTong2 = {
                        'tong_TLvang': tong_TLvang,
                        'tong_TLthuc': tong_TLthuc,
                        'tong_TLhot': tong_TLhot,
                        'tong_GiaCong': tong_GiaCong,
                        'tong_CongGoc': tong_CongGoc,
                        'tong_ThanhTien': tong_ThanhTien
                      };

                      printExcel(_filterBaoCaoTonKhoVang, thongTinTinhTong2);
                    },
                    child: Text('Export Excel'),
                  )),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Column(
            children: [
              Search_Bar(searchController: _searchController),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: Scrollbar(
                child: ListView(
                  children: [ShowList()],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  //Giao diện bang báo cáo
  FutureBuilder<List<BaoCaoTonKhoVang_Model>> ShowList() {
    return FutureBuilder<List<BaoCaoTonKhoVang_Model>>(
        future: _BaoCaoTonKhoVangFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 10),
            ));
          } else {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                reverse: true,
                itemCount: _filterBaoCaoTonKhoVang.length,
                itemBuilder: (BuildContext context, int index) {
                  final baocao = _filterBaoCaoTonKhoVang[index];

                  return Container(
                      margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [Color(0xffe65c00), Color(0xfff9d423)],
                        //   stops: [0, 1],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        color: const Color.fromARGB(255, 228, 200, 126),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    ' Loại: ${baocao.NHOM_TEN}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' Số lượng: ${baocao.SoLuong}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                              onPressed: () {
                                print('nút chi tiết');
                                ThongTinChiTiet(context, baocao);
                              },
                              icon: Icon(
                                Icons.info_outline,
                                size: 30,
                              ),
                            )),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black87),
                              columns: [
                                DataColumn(
                                    label: Text('TL thực',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('TL hột',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('TL vàng',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('Công gốc',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('Giá công',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('Thành tiền',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                              ],
                              rows: [
                                DataRow(
                                    cells: [
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.TL_Thuc)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.TL_hot)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.TL_vang)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.CONG_GOC)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.GIA_CONG)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(baocao.ThanhTien)}')),
                                    ],
                                    color: MaterialStateColor.resolveWith(
                                        (states) => Colors.white))
                              ],
                            ),
                          ),
                        ],
                      ));
                });
          }
        });
  }

  //Hiển thi chi tiết
  Future<void> ThongTinChiTiet(
      BuildContext context, BaoCaoTonKhoVang_Model item) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Thông tin chi tiết',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Loại: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' ${item.NHOM_TEN}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Số lượng: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' ${item.SoLuong}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'TL thực: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${formatCurrencyDouble(item.TL_Thuc)}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'TL hột: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${formatCurrencyDouble(item.TL_hot)}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'TL vàng: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${formatCurrencyDouble(item.TL_vang)}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Công gốc: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${formatCurrencyDouble(item.CONG_GOC)}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Giá công: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${formatCurrencyDouble(item.GIA_CONG)}')
                          ])),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Thành tiền: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    ' ${formatCurrencyDouble(item.ThanhTien)}')
                          ])),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.close_outlined, color: Colors.red),
                  label: Text(
                    'Đóng',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
