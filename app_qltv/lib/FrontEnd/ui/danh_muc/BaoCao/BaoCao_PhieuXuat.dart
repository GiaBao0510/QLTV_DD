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

  late Future<ThongTinTinhTong_model> _ThongTinTinhTongFuture;
  ThongTinTinhTong_model _ThongTinTinhTong = ThongTinTinhTong_model(
      SoLuongHang: 0,
      TongCanTong: 0.0,
      TongTLhot: 0.0,
      TongTLvang: 0.0,
      TongThanhTien: 0.0,
      TongGiaGoc: 0.0,
      TongLaiLo: 0.0);

  int pages = 5; //So dong toi da duoc tai len
  int loadElements = 5; //Moi lan load chi lây 5 phân tử
  int SoLuong = 0;

  //Phuong thuc khoi tao truoc build
  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuXuat();
    _LoadSummary();
    _searchController.addListener(_filterBaoCaoPhieuXuat);
    thuvien  =ThuVienUntilState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoPhieuXuat() async {
    //--- Ghi phuương thức --------
    //1.Load bang dữ liệu
    _bangBaoCaoPhieuXuatFuture =
        Provider.of<BaocaophieuxuatManage>(context, listen: false)
            .LayDuLieuPhieuXuat_test(ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT, pages);
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
  Future<void> printDoc(List<BangBaoCaoPhieuXuat_model> data,
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
        ThuVienUntilState.StartDayController.text = ThuVienUntilState.dateFormat.format(ThuVienUntilState.ngayBD);
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
        ThuVienUntilState.EndDayController.text = ThuVienUntilState.dateFormat.format(ThuVienUntilState.ngayKT);
      });
    }
    //print('Ngày kết thúc đã chọn: $ngayKT');
  }

  //7. Load tinh tong
  Future<void> _LoadSummary() async {
    _ThongTinTinhTongFuture =
        Provider.of<BaocaophieuxuatManage>(context, listen: false)
            .TinhTongPhieuXuat(ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    _ThongTinTinhTongFuture.then((tinhtong) {
      print('thong tin tinh tong: ${tinhtong}');
      setState(() {
        _ThongTinTinhTong = tinhtong;
      });
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
                        //printDoc(_filterPhieuXuatList, ThongTinTinhTong);
                      },
                      child: Text('Export PDF'),
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadBaoCaoPhieuXuat(),
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('${_ThongTinTinhTong}');
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    color: Colors.red,
                  ),
                  width: 50,
                  height: 50,
                  child: Text('${_ThongTinTinhTong}'),
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
                    gradient: LinearGradient(
                      colors: [Color(0xffe65c00), Color(0xfff9d423)],
                      stops: [0, 1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                          child: Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "Phiếu xuất mã: ${BaoCao.MaPhieuXuat}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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

//   //Hiển thị thông tin chi tiết
  Future<void> ThongTinChiTiet(
      BuildContext context, BangBaoCaoPhieuXuat_model item) async {
    double tongChung_CanTong = 0.0,
        tongChung_TLhot = 0.0,
        tongChung_TLvang = 0.0,
        tongChung_ThanhTien = 0.0,
        tongChung_GiaGoc = 0.0,
        tongChung_LaiLo = 0.0;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: Text(
              'Thông tin chi tiết',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          content: FractionallySizedBox(
            heightFactor: 0.6,
            child: Scrollbar(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Thông tin hàng hóa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 20),
                      ),
                      ...item.PhieuXuat.map((hanghoa) {
                        //Vong lap xu ly tinh tong
                        for (int i = 0; i < item.PhieuXuat.length; i++) {
                          tongChung_CanTong += hanghoa.CAN_TONG;
                          tongChung_TLhot += hanghoa.TL_HOT;
                          tongChung_TLvang += hanghoa.TL_Vang;
                          tongChung_ThanhTien += hanghoa.THANH_TIEN;
                          tongChung_GiaGoc += hanghoa.GIA_CONG;
                          tongChung_LaiLo += hanghoa.LaiLo;
                        }

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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' ${hanghoa.HANGHOAMA}'),
                                ]),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'Tên hàng hóa: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' ${hanghoa.HANG_HOA_TEN}'),
                                ]),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'Loại vàng: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' ${hanghoa.LOAIVANG}'),
                                ]),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'Cân tổng: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' ${hanghoa.NGAY_XUAT}'),
                                ]),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'Đơn giá: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Tổng quan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: 'Cân tổng: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        ' ${formatCurrencyDouble(tongChung_CanTong)}'),
                              ]),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: 'Tl hột: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        ' ${formatCurrencyDouble(tongChung_LaiLo)}'),
                              ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Flexible(
                    child: ListTile(
                  leading: Icon(Icons.print),
                  title: Text('In'),
                  onTap: () {
                    print('in phiếu xuất');
                    printInvoice(item);
                  },
                )),
                Flexible(
                    child: ListTile(
                  leading: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Đóng',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                )),
              ],
            ),
          ],
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
                    _loadBaoCaoPhieuXuat();
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                      decoration:  BoxDecoration(
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
}
