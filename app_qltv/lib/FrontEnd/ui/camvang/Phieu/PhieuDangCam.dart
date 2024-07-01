import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:provider/provider.dart';
import './ThongTinChiTietPhieuCam.dart';
import 'package:app_qltv/FrontEnd/Service/export/PDF/PhieuDangCam_PDF.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';

import 'package:app_qltv/FrontEnd/model/CamVang/PhieuDangCam.dart';
import 'package:app_qltv/FrontEnd/controller/CamVang/PhieuDangCam_manage.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';

class PhieuDangCam extends StatefulWidget {
  static const routeName = '/phieudangcam';

  const PhieuDangCam({super.key});
  State<PhieuDangCam> createState() => _PhieuDangCam();
}

class _PhieuDangCam extends State<PhieuDangCam> {
  //--------------------------
  // ------ Thuộc tính -------
  //--------------------------
  late Future<List<PhieuDangCam_model>> _phieuDangCam_Future;
  late Future<List<PhieuDangCam_model>> _AllPhieuDangCam_Future;
  late Future<TinhTongPhieuDangCam_model> _tinhTongPhieuDangCam_Future;
  final TextEditingController _searchController = TextEditingController();
  List<PhieuDangCam_model> _fillterPhieuDangCam = [];
  List<PhieuDangCam_model> _PhieuDangCam_List = [];
  List<PhieuDangCam_model> _All_PhieuDangCam = [];
  late TinhTongPhieuDangCam_model thongTinhTinhTong;
  int pages = 0;
  int SoLuongPhieu = 0;

  //--------------------------
  // ------ phương thức ------
  //--------------------------
  //1. Hàm khởi tạo
  @override
  void initState() {
    super.initState();
    ThuVienUntilState.ngayBD = DateTime.now();
    ThuVienUntilState.ngayKT = DateTime.now();
    _LoadTongTinTinhTong();
    _loadDuLieuPhieuDangCam(pages);
    _loadAllPhieuDangCam();
    _searchController.addListener(_FillterPhieuDangCam);
  }

  //2. Ham huy
  @override
  void dispose() {
    _searchController.dispose();
    ThuVienUntilState.ngayBD = DateTime.now();
    ThuVienUntilState.ngayKT = DateTime.now();
    super.dispose();
  }

  //3.Load dữ liệu tìm kiếm theo ngày
  Future<void> _loadDuLieuPhieuDangCam(int pages) async {
    _phieuDangCam_Future =
        Provider.of<PhieuDangCamManage>(context, listen: false)
            .fetchPhieuDangCam(
                ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT, pages);
    _phieuDangCam_Future.then((PhieuDangCams) {
      setState(() {
        _PhieuDangCam_List = PhieuDangCams;
        _fillterPhieuDangCam = PhieuDangCams;
      });
    });
  }

  //4. Load dữ liệu tất cả các phiếu đang cầm theo ngày
  Future<void> _loadAllPhieuDangCam() async{
    _AllPhieuDangCam_Future =
        Provider.of<PhieuDangCamManage>(context, listen: false)
            .fetchAllPhieuDangCam(
            ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    _AllPhieuDangCam_Future.then((PhieuDangCams) {
      setState(() {
        _All_PhieuDangCam = PhieuDangCams;
      });
    });
  }

  //5.Load dữ liệu tính tổng
  Future<void> _LoadTongTinTinhTong() async {
    _tinhTongPhieuDangCam_Future =
        Provider.of<PhieuDangCamManage>(context, listen: false)
            .fetchTinhTongPhieuDangCam(
                ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    _tinhTongPhieuDangCam_Future.then((values) {
      setState(() {
        thongTinhTinhTong = values;
      });
    });
  }

  //6.Lọc dữ liệu dữ trên max phieu dang cam
  void _FillterPhieuDangCam() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _fillterPhieuDangCam = _PhieuDangCam_List.where((PhieuDangCam) {
        return PhieuDangCam.PHIEU_MA!.toLowerCase().contains(query);
      }).toList();
    });
  }

  //8. Đặt gia trị ngày bắt đầu
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

  //9. Đặt gia trị ngày kêết thúc
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

  //10. Chuyển đổi sang PDF
  Future<void> exportFilePFD() async{
    final front = await loadFont('assets/fonts/Roboto-Regular.ttf');
    final Doc = pw.Document();
    Doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context){
          return buildPrintableData(_All_PhieuDangCam,front ,thongTinhTinhTong);
        }
      )
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => Doc.save());
  }

  //--------------------------
  // ------ Tien ích ---------
  //--------------------------
  //1.Giao diện
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Phiếu đang cầm',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Align',
                  fontWeight: FontWeight.bold),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 228, 200, 126),
            ),
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (BuildContext context){
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                        child: TextButton(
                          onPressed: (){
                            print('Chuyển sang pdf');
                            exportFilePFD();
                          },
                          child: Text('Export PDF'),
                        )
                    )
                  ];
                }
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _loadDuLieuPhieuDangCam(pages),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Colors.grey[100],
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Search_Bar(searchController: _searchController),
                const SizedBox(
                  height: 12,
                ),
                SearchByDay(context),
                const SizedBox(
                  height: 15,
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
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ChangePage(context),
                )
              ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.8,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: const Color.fromARGB(255, 228, 200, 126),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: BangTongQuan(context),
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
      ),
    );
  }

  //2.Thông tin từng phiếu đang cầm
  FutureBuilder<List<PhieuDangCam_model>> ShowList() {
    return FutureBuilder<List<PhieuDangCam_model>>(
        future: _phieuDangCam_Future,
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
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _fillterPhieuDangCam.length,
                itemBuilder: (_, index) {
                  final BaoCao = _fillterPhieuDangCam[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                        //Phan head
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Mã phiếu: ${BaoCao.PHIEU_MA}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {
                                    ThongTinChiTiet(context, BaoCao);
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    size: 30,
                                  )),
                            )
                          ],
                        ),

                        //body
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black87),
                            columns: const [
                              DataColumn(
                                  label: Text(
                                'Định Giá',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Tiền khách nhận',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Tiền nhận thêm',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Tiền cầm mới',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Lãi lỗ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text(
                                      '${formatCurrencyDouble(BaoCao.DINH_GIA ?? 0.0)}')),
                                  DataCell(Text(
                                      '${formatCurrencyDouble(BaoCao.TIEN_KHACH_NHAN ?? 0.0)}')),
                                  DataCell(Text(
                                      '${formatCurrencyDouble(BaoCao.TIEN_THEM ?? 0.0)}')),
                                  DataCell(Text(
                                      '${formatCurrencyDouble(BaoCao.TIEN_MOI ?? 0.0)}')),
                                  DataCell(Text(
                                      '${formatCurrencyDouble(BaoCao.LAI_XUAT ?? 0.0)}%')),
                                ],
                                color: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }

  //3.Bảng tổng quan
  Widget BangTongQuan(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Flexible(
            child: Text(
          'Tổng Quan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 30,
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.black87),
                columns: const [
                  DataColumn(
                      label: Text(
                    'Số lượng',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'Cân tổng',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'TL hột',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'TL thực',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text(
                        '${thongTinhTinhTong.SoLuong}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.TongCanTong ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.Tong_TL_HOT ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.Tong_TLthuc ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                    ],
                    color: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                  )
                ]),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.black87),
                columns: const [
                  DataColumn(
                      label: Text(
                    'Định giá',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'Tiền khách nhận',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'Tiền nhận thêm',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  DataColumn(
                      label: Text(
                    'Tiền cầm mới',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.TongDinhGia ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.TongTienKhachNhan ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.TongTienThem ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                      DataCell(Text(
                        '${formatCurrencyDouble(thongTinhTinhTong.TongTienMoi ?? 0.0)}',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                    ],
                    color: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  //4.Tìm kiếm theo ngày
  Widget SearchByDay(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: TextField(
                controller: ThuVienUntilState.StartDayController,
                readOnly: true,
                decoration: InputDecoration(
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
              child: TextField(
                controller: ThuVienUntilState.EndDayController,
                readOnly: true,
                decoration: InputDecoration(
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
                    _loadDuLieuPhieuDangCam(pages);
                    _LoadTongTinTinhTong();
                    _loadAllPhieuDangCam();
                    setState(() {
                      SoLuongPhieu = thongTinhTinhTong.SoLuong ?? 0;
                    });
                    print('Số lượng : ${SoLuongPhieu}');
                    print('pages phiếu đang cầm: ${pages}');
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff536976), Color(0xff292e49)],
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Tìm kiếm',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  //5.Thông tin hiển thị thêm
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
                  _loadDuLieuPhieuDangCam(pages);
                }
              },
              child: const Text('<'),
            )
        ),

        const SizedBox(width: 50,),
        Visibility(
            visible: pages <= SoLuongPhieu,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  pages+=10;
                });
                if(pages <= SoLuongPhieu){
                  _loadDuLieuPhieuDangCam(pages);
                }
              },
              child: const Text('>'),
            )
        ),
      ],
    );
  }
}
