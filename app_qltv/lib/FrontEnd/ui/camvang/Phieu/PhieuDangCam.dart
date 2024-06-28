import 'dart:async';

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
  late Future<TinhTongPhieuDangCam_model> _tinhTongPhieuDangCam_Future;
  final TextEditingController _searchController = TextEditingController();
  List<PhieuDangCam_model> _fillterPhieuDangCam = [];
  List<PhieuDangCam_model> _PhieuDangCam_List = [];
  late TinhTongPhieuDangCam_model thongTinhTinhTong;
  final dkCuon = ScrollController();

  //--------------------------
  // ------ phương thức ------
  //--------------------------
  //1. Hàm khởi tạo
  @override
  void initState() {
    super.initState();
    ThuVienUntilState.ngayBD = DateTime.now();
    ThuVienUntilState.ngayKT = DateTime.now();
    ThuVienUntilState.offset = 0;
    _LoadTongTinTinhTong();
    _loadDuLieuPhieuDangCam();
    _searchController.addListener(_FillterPhieuDangCam);
    dkCuon.addListener(LoadDataWhenEndPage);
    _refreshData();
  }

  //2. Ham huy
  @override
  void dispose() {
    _searchController.dispose();
    ThuVienUntilState.scrollController.dispose();
    super.dispose();
  }

  //3.Load dữ liệu tìm kiếm theo ngày
  Future<void> _loadDuLieuPhieuDangCam() async {
    _phieuDangCam_Future =
        Provider.of<PhieuDangCamManage>(context, listen: false)
            .fetchPhieuDangCam(
                ThuVienUntilState.ngayBD,
                ThuVienUntilState.ngayKT,
                ThuVienUntilState.limit,
                ThuVienUntilState.offset);

    if (ThuVienUntilState.offset == 0) {
      _phieuDangCam_Future.then((PhieuDangCams) {
        setState(() {
          _PhieuDangCam_List = PhieuDangCams;
          _fillterPhieuDangCam = PhieuDangCams;
        });
      });
    } else {
      _phieuDangCam_Future.then((PhieuDangCams) {
        for (int i = 0; i < PhieuDangCams.length; i++) {
          PhieuDangCam_model item = PhieuDangCams[i];
          setState(() {
            _fillterPhieuDangCam.add(item);
          });
        }
      });
    }
  }

  //4.Load dữ liệu tính tổng
  Future<void> _LoadTongTinTinhTong() async {
    _tinhTongPhieuDangCam_Future =
        Provider.of<PhieuDangCamManage>(context, listen: false)
            .fetchTinhTongPhieuDangCam(
                ThuVienUntilState.ngayBD, ThuVienUntilState.ngayKT);
    _tinhTongPhieuDangCam_Future.then((values) {
      setState(() {
        print("Giá trị Tính tống: ${values}");
        thongTinhTinhTong = values;
      });
    });
  }

  //5.Lọc dữ liệu dữ trên max phieu dang cam
  void _FillterPhieuDangCam() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _fillterPhieuDangCam = _PhieuDangCam_List.where((PhieuDangCam) {
        return PhieuDangCam.PHIEU_MA!.toLowerCase().contains(query);
      }).toList();
    });
  }

  //6. Làm mới dữ liệu
  Future<void> _refreshData() async {
    ThuVienUntilState.ngayBD = DateTime.now();
    ThuVienUntilState.ngayKT = DateTime.now();
    ThuVienUntilState.offset = 0;
    ThuVienUntilState.StartDayController.clear();
    ThuVienUntilState.EndDayController.clear();
    await _LoadTongTinTinhTong();
    await _loadDuLieuPhieuDangCam();
  }

  //7. Đặt gia trị ngày bắt đầu
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

  //8. Đặt gia trị ngày kêết thúc
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
    //print('Ngày kết thúc đã chọn: $ngayKT');
  }

  //9. Điều kện cuộn
  void LoadDataWhenEndPage() {
    if (dkCuon.position.pixels >= dkCuon.position.maxScrollExtent - 100) {
      print('Đến cuối trang');
      print('Offset: ${ThuVienUntilState.offset}');
      setState(() {
        ThuVienUntilState.offset += 10;
      });
      _loadDuLieuPhieuDangCam();
    } else {
      print('Chưa cuối trang');
    }
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
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 28,
          ),
          title: Row(
            children: [
              const Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Phiếu đang cầm',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Align',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                    onPressed: () {
                      print('Chuyển sang phần chuyển đổi PDF');
                      //printDoc(data);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(2, 5, 2, 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffededed), Color(0xffdee8e8)],
                          stops: [0.25, 0.75],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(4, 8))
                        ],
                      ),
                      child: Center(
                          child: Text(
                        'Export PDF',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                    )),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [Colors.orange, Colors.amber])
              color: Color.fromARGB(255, 228, 200, 126),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
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
                  controller: dkCuon,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          ShowList(),
                          const SizedBox(
                            height: 5,
                          ),
                          NutLoadDuLieu(context),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
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
                          // gradient: LinearGradient(
                          //   colors: [Color(0xffff512f), Color(0xfff09819)],
                          //   stops: [0, 1],
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          // ),
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
                controller: dkCuon,
                shrinkWrap: true,
                //reverse: true,
                itemCount: _fillterPhieuDangCam.length,
                itemBuilder: (_, index) {
                  final BaoCao = _fillterPhieuDangCam[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      // gradient: const LinearGradient(
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
                    setState(() {
                      ThuVienUntilState.offset = 0;
                    });
                    _loadDuLieuPhieuDangCam();
                    _LoadTongTinTinhTong();
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
  Widget NutLoadDuLieu(BuildContext context) {
    if (_fillterPhieuDangCam.length == 0) {
      return Text('');
    }
    return Container(
      width: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffccd2ff), Color(0xffbfc4df)],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {
          //Kiểm tra nếu đạ độ dai tối đa thì không load thêm
          int DoDaiToiDa = thongTinhTinhTong.SoLuong ?? 0;
          print('ĐỘ dài tối đa mới lấy: ${DoDaiToiDa}');
          print('ĐỘ dài hiện tại: ${ThuVienUntilState.offset}');
          if (ThuVienUntilState.offset >= DoDaiToiDa) {
            print('Đạt tối đa');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                'Đã hết dữ liệu để hiển thị',
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            setState(() {
              ThuVienUntilState.offset += 10;
            });
            _loadDuLieuPhieuDangCam();
          }
        },
        child: Text(
          'Xem thêm...',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
