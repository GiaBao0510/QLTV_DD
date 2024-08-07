import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
import '../../../controller/danhmuc/BaoCaoPhieuXuat_manage.dart';
import '../../../ui/components/FormatCurrency.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import '../../../Service/export/PDF/BangBaoCaoPhieuXuat_PDF.dart';
import '../../../Service/export/PDF/PhieuXuat_PDF.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import '../../../Service/ThuVien.dart';

class BaoCaoPhieuXuatScreen extends StatefulWidget {
  static const routeName = '/baocaophieuxuat';
  const BaoCaoPhieuXuatScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoPhieuXuat createState() => _BaoCaoPhieuXuat();
}

class _BaoCaoPhieuXuat extends State<BaoCaoPhieuXuatScreen> {
  // --- Thuộc tính ---
  late Future<List<BangBaoCaoPhieuXuat_model>> _bangBaoCaoPhieuXuatFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BangBaoCaoPhieuXuat_model> _filterPhieuXuatList = [];
  List<BangBaoCaoPhieuXuat_model> _PhieuXuatList = [];
  late ThuVienUntilState thuvien;

  ThongTinTinhTong_model _ThongTinTinhTong = ThongTinTinhTong_model(
      SoLuongHang: 0, TongCanTong: 0.0, TongTLhot: 0.0,
      TongTLvang: 0.0, TongThanhTien: 0.0, TongGiaGoc: 0.0,
      TongLaiLo: 0.0);

  int pages = 0; //So dong toi da duoc tai len
  int SoLuongPhieuXuat = 0;

  //Phuong thuc khoi tao truoc build
  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuXuat(pages);
    _searchController.addListener(_filterBaoCaoPhieuXuat);
    thuvien = ThuVienUntilState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    ThuVienUntilState.EndDayController.clear();
    ThuVienUntilState.StartDayController.clear();
    super.dispose();
  }

  Future<void> _loadBaoCaoPhieuXuat(int pages) async {
    //--- Ghi phuương thức --------
    //1.Load bang dữ liệu
    _bangBaoCaoPhieuXuatFuture =
        Provider.of<BaocaophieuxuatManage>(context, listen: false)
            .LayDuLieuPhieuXuat_test(
                ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT, pages);
    _bangBaoCaoPhieuXuatFuture.then((BaoCaos) {
      setState(() {
        _PhieuXuatList = BaoCaos;
        _filterPhieuXuatList = BaoCaos;
      });
    });
  }

  //2.Lọc dữ liệu
  void _filterBaoCaoPhieuXuat() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filterPhieuXuatList = _PhieuXuatList.where((phieuxuat) {
        return phieuxuat.MaPhieuXuat.toLowerCase().contains(query);
      }).toList();
    });
  }

  //3. Chuyển sang xuất phiếu PDF theo tưng hàng
  Future<void> printInvoice(BangBaoCaoPhieuXuat_model item) async {
    final font = await LoadFont('assets/fonts/Roboto-Regular.ttf');
    final Doc = pw.Document();
    Doc.addPage(pw.Page(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return CreateInvoice(item, font);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => Doc.save());
  }

  //4.Chuyển sang phần xuất file PDF Dang bảng
  Future<void> printDoc(List<BangBaoCaoPhieuXuat_model> data) async {
    final font = await loadFont('assets/fonts/Roboto-Regular.ttf');
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(data, font, _ThongTinTinhTong);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  //5. Choọn ngay bat dau
  void _SelectStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ThuVienUntilState.ngayBD,
        firstDate: DateTime(1999),
        lastDate: DateTime(2200));
    if (picked != null && picked != ThuVienUntilState.ngayBD) {
      setState(() {
        ThuVienUntilState.ngayBD = picked;
        ThuVienUntilState.StartDayController.text =
            ThuVienUntilState.dateFormat.format(ThuVienUntilState.ngayBD);
      });
    }
  }

  //6. Choọn ngay ket thuc
  void _SelectEndDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ThuVienUntilState.ngayKT,
        firstDate: DateTime(1999),
        lastDate: DateTime(2200));
    if (picked != null && picked != ThuVienUntilState.ngayKT) {
      setState(() {
        ThuVienUntilState.ngayKT = picked;
        ThuVienUntilState.EndDayController.text =
            ThuVienUntilState.dateFormat.format(ThuVienUntilState.ngayKT);
      });
    }
  }

  //7. Load tinh tong
  Future<void> _LoadSummary() async {
    final thongTinTinhTong = await Provider.of<BaocaophieuxuatManage>(context,listen: false).TinhTongPhieuXuat(ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    setState(() {
      _ThongTinTinhTong = thongTinTinhTong;
    });
  }

  //8. Load so luong phieu xuat
  Future<void> LaySoLuongPhieuXuat() async{
    final _baoCaoPhieuXuatController = Provider.of<BaocaophieuxuatManage>(context, listen: false);
    int SL = await _baoCaoPhieuXuatController.SoLuongPhieuXuat(ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    setState(() {
      SoLuongPhieuXuat = SL;
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
            const Text("Báo Cáo Phiếu Xuất",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_sharp),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: TextButton(
                      onPressed: () {
                        print('Chuyen sang PDF');
                        printDoc(_filterPhieuXuatList);
                      },
                      child: Text('Export PDF'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: TextButton(
                      onPressed: () {
                        print('Chuyen sang Excel');
                      },
                      child: Text('Export Excel'),
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadBaoCaoPhieuXuat(pages),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Column(
              children: [
                Search_Bar(searchController: _searchController),
                const SizedBox(
                  height: 12,
                ),
                SearchByDay(context),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            ShowList(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ChangePage(context)
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xffff8008), Color(0xffffc837)],
                      stops: [0, 1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Tổng quan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ),

                      const SizedBox(height: 20,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.black87),
                            columns: [
                              DataColumn(label: Text('Số lượng',style: TextStyle(color: Colors.white),) ),
                              DataColumn(label: Text('Cân tổng',style: TextStyle(color: Colors.white),) ),
                              DataColumn(label: Text('TL hột',style: TextStyle(color: Colors.white),) ),
                              DataColumn(label: Text('TL vàng',style: TextStyle(color: Colors.white),) ),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('${_ThongTinTinhTong.SoLuongHang}')),
                                DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongCanTong)}')),
                                DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongTLhot)}')),
                                DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongTLvang)}')),
                              ]),
                            ],
                          dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                        ),
                      ),

                      const SizedBox(height: 20,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black87),
                          columns: [
                            DataColumn(label: Text('Thành tiền',style: TextStyle(color: Colors.white),) ),
                            DataColumn(label: Text('Giá công',style: TextStyle(color: Colors.white),) ),
                            DataColumn(label: Text('Lãi lỗ',style: TextStyle(color: Colors.white),) ),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongThanhTien)}')),
                              DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongGiaGoc)}')),
                              DataCell(Text('${formatCurrencyDouble(_ThongTinTinhTong.TongLaiLo)}')),
                            ]),
                          ],
                          dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.white,
        tooltip: 'Show Bottom Sheet',
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset('assets/images/list.png'),
        ),
      ),
    );
  }

  //Thông tin từng phiếu báo cáo
  FutureBuilder<List<BangBaoCaoPhieuXuat_model>> ShowList() {
    return FutureBuilder<List<BangBaoCaoPhieuXuat_model>>(
        future: _bangBaoCaoPhieuXuatFuture,
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
              itemCount: _filterPhieuXuatList.length,
              itemBuilder: (_, index) {
                final BaoCao = _filterPhieuXuatList[index];
                return Container(
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  decoration: BoxDecoration(
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
                      //Tieu de
                      Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              children: [
                                Text(
                                  "Phiếu xuất mã: ${BaoCao.MaPhieuXuat}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                IconButton(
                                    onPressed: () {
                                      ThongTinChiTiet(context, BaoCao);
                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 30,
                                    )),
                              ],
                            ),
                          )),

                      const SizedBox(
                        height: 15,
                      ),

                      //Liêt kê hàng hóa trong từng phiếu xuất
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black87),
                            columns: [
                              DataColumn(
                                  label: Text(
                                'Hàng hóa',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Đơn giá',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Thành tiền',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Giá gốc',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Lãi lỗi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ],
                            rows: [
                              ...BaoCao.PhieuXuat.map((hanghoa) {
                                return DataRow(
                                    cells: [
                                      DataCell(Text('${hanghoa.HANG_HOA_TEN}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(hanghoa.DON_GIA)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(hanghoa.THANH_TIEN)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(hanghoa.GiaGoc)}')),
                                      DataCell(Text(
                                          '${formatCurrencyDouble(hanghoa.LaiLo)}')),
                                    ],
                                    color: MaterialStateColor.resolveWith(
                                        (states) => Colors.white));
                              }),
                            ]),
                      )
                    ],
                  ),
                );
              },
            );
          }
        });
  }

  //Hiển thị thông tin chi tiết
  Future<void> ThongTinChiTiet(
      BuildContext context, BangBaoCaoPhieuXuat_model item) async {
    double tongChung_CanTong = 0.0,
        tongChung_TLhot = 0.0,
        tongChung_TLvang = 0.0,
        tongChung_ThanhTien = 0.0,
        tongChung_GiaGoc = 0.0,
        tongChung_LaiLo = 0.0;

    // Vòng lặp xử lý tính tổng
    for (var hanghoa in item.PhieuXuat) {
      tongChung_CanTong += hanghoa.CAN_TONG;
      tongChung_TLhot += hanghoa.TL_HOT;
      tongChung_TLvang += hanghoa.TL_Vang;
      tongChung_ThanhTien += hanghoa.THANH_TIEN;
      tongChung_GiaGoc += hanghoa.GIA_CONG;
      tongChung_LaiLo += hanghoa.LaiLo;
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          Align(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: 'Mã: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' ${item.MaPhieuXuat}'),
                              ]),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Thông tin hàng hóa',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 20),
                          ),
                          ...item.PhieuXuat.map((hanghoa) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange)),
                              child: Column(
                                children: [
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Mã hàng hóa: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' ${hanghoa.HANGHOAMA}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Tên hàng hóa: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: ' ${hanghoa.HANG_HOA_TEN}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Loại vàng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' ${hanghoa.LOAIVANG}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Cân tổng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.CAN_TONG)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'TL hột: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.TL_HOT)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'TL vàng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.TL_Vang)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Ngày xuất: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: ' ${hanghoa.NGAY_XUAT}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Đơn giá: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.DON_GIA)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Thành tiền: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.THANH_TIEN)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Giá công: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.GIA_CONG)}'),
                                    ]),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Lãi lỗ: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${formatCurrencyDouble(hanghoa.LaiLo)}'),
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          Text(
                            'Tổng quan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: [
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'Cân tổng: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_CanTong)}'),
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'TL hột: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_TLhot)}'),
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'TL vàng: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_TLvang)}'),
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'Thành tiền: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_ThanhTien)}'),
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'Giá gốc: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_GiaGoc)}'),
                                  ]),
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'Lãi lỗ: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' ${formatCurrencyDouble(tongChung_LaiLo)}'),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.print),
                      label: Text('In'),
                      onPressed: () {
                        print('in phiếu xuất');
                        printInvoice(item);
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.close, color: Colors.red),
                      label: Text(
                        'Đóng',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
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
            ],
          ),
        );
      },
    );
  }

  //Tao widget tim kiem theo ngày
  Widget SearchByDay(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: TextFormField(
                controller: ThuVienUntilState.StartDayController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Ngày bắt đầu',
                  labelStyle: TextStyle(fontSize: 12),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: TextStyle(fontSize: 15),
                onTap: () => _SelectStartDate(),
              )),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              flex: 1,
              child: TextFormField(
                controller: ThuVienUntilState.EndDayController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Ngày kết thúc',
                  labelStyle: TextStyle(fontSize: 12),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: TextStyle(fontSize: 15),
                onTap: () => _SelectEndDate(),
              )),
          Flexible(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    _loadBaoCaoPhieuXuat(pages);
                    LaySoLuongPhieuXuat();
                    _LoadSummary();
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff536976), Color(0xff292e49)],
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Tìm kiếm',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  //Tính năng chuyển trang khi người dùng bấm
  Widget ChangePage(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: pages >= 0,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  pages-=10;
                });
                if(pages >= 0){
                  _loadBaoCaoPhieuXuat(pages);
                }
              },
              child: const Text('<'),
            )
        ),

        const SizedBox(width: 50,),
        Visibility(
            visible: pages <= SoLuongPhieuXuat,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  pages+=10;
                });
                if(pages <= SoLuongPhieuXuat){
                  _loadBaoCaoPhieuXuat(pages);
                }
              },
              child: const Text('>'),
            )
        ),
      ],
    );
  }

}
