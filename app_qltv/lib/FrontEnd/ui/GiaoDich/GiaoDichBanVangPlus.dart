import 'dart:convert';

import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/controller/GiaoDich/BanVang_controller.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/model/GiaoDich/BanVang_model.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BanVangPlus extends StatefulWidget {
  static const routerName = '/giaodichbanvangplus';
  const BanVangPlus({super.key});

  @override
  State<BanVangPlus> createState() => _BanVangPlusState();
}

class _BanVangPlusState extends State<BanVangPlus> {
  final TextEditingController _controller = TextEditingController();

  late Future<TruocKhiThucHienBanVang_model> _thongTinHangHoaFuture;
  late List<TruocKhiThucHienBanVang_model> _hangHoaList = [];

  late Future<List<Khachhang>> _khachHangFuture;
  List<Khachhang> _khachHangList = [];
  List<Khachhang> _filteredKhachHang = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalKhachhang = 0;
  int _totalRows = 0;

  final TextEditingController _tongtien = TextEditingController(),
      _tienbot = TextEditingController(),
      _thanhtoan = TextEditingController(),
      _tenKhachHang = TextEditingController();

  // ignore: non_constant_identifier_names
  Future<void> _LoadData(maSp) async {
    //Lấy thông tin hàng hóa
    print('Mã Sản Phẩm: $maSp');
    _thongTinHangHoaFuture =
        Provider.of<BanvangController>(context, listen: false)
            .FecthThongTinSanPham(maSP: maSp);
    _thongTinHangHoaFuture.then((thongtin) {
      setState(() {
        _hangHoaList.add(thongtin);
      });
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> _LoadDatabyCamera() async {
    //Lấy thông tin hàng hóa
    _thongTinHangHoaFuture =
        Provider.of<BanvangController>(context, listen: false)
            .FecthThongTinSanPham();
    _thongTinHangHoaFuture.then((thongtin) {
      setState(() {
        _hangHoaList.add(thongtin);
      });
    });
  }

  Future<void> _loadKhachhang({int page = 1}) async {
    final manager = Provider.of<KhachhangManage>(context, listen: false);
    // Fetch customer information
    _khachHangFuture = manager.fetchKhachhang(page: page, pageSize: _pageSize);
    final clients = await _khachHangFuture;
    setState(() {
      _khachHangList = clients;
      _filteredKhachHang = clients;
      _currentPage = page;
      _totalRows = manager.totalRows;
    });
  }

  Future<void> _loadTotalKhachhang() async {
    final totalKhachhang =
        await Provider.of<KhachhangManage>(context, listen: false)
            .fetchTotalKhachhang();

    setState(() {
      _totalKhachhang = totalKhachhang;
    });
  }

  //4. Tạo bộ lọc tìm khách hàng dựa trên tên
  void _filterKhachhang() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKhachHang = _khachHangList.where((client) {
        return client.kh_ten!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _updateThanhToan() {
    final tongTien = double.tryParse(_tongtien.text) ?? 0.0;
    final tienBot = double.tryParse(_tienbot.text) ?? 0.0;
    final thanhToan = tongTien - tienBot;
    _thanhtoan.text = thanhToan.toStringAsFixed(2);
  }

  void removeHangHoa(hangHoa) {
    setState(() {
      _hangHoaList.remove(hangHoa);
    });
  }

  void quetMaQR(context) {
    ThuVienUntilState.scanQRcodePlus(context);
    _LoadDatabyCamera();
  }

  void quetBarQR(context) {
    ThuVienUntilState.scanBarcodePlus(context);
    _LoadDatabyCamera();
  }

  void nhapMaSanPham(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nhập Mã Sản Phẩm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Mã Sản Phẩm',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String maSanPham = _controller.text;
                  // Xử lý mã sản phẩm tại đây
                  print('Mã Sản Phẩm: $maSanPham');
                  _LoadData(maSanPham);
                  Navigator.pop(context); // Đóng BottomSheet
                },
                child: const Text('Xác Nhận'),
              ),
              const SizedBox(height: 300),
            ],
          ),
        );
      },
    );
  }

  void showListSanPham() {
    print('DANHSACHHANGHOA');
    List<Map<String, dynamic>> jsonList =
        _hangHoaList.map((item) => item.toMap()).toList();

    // Mã hóa danh sách các map thành chuỗi JSON
    String jsonString = jsonEncode(jsonList);

    print('HANGHOA[]: $jsonString');
  }

  @override
  void initState() {
    super.initState();
    _loadKhachhang();
    _searchController.addListener(_filterKhachhang);
  }

  @override
  void dispose() {
    super.dispose();
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
            const Text("Giao Dịch Bán Vàng",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.add),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      quetMaQR(context);
                    },
                    child: const Text('Mã QR'),
                  )),
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      quetBarQR(context);
                    },
                    child: const Text('Mã Vạch'),
                  )),
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      nhapMaSanPham(context);
                    },
                    child: const Text('Nhập Mã'),
                  )),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: _hangHoaList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 200, 126),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'no.${index + 1}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              '${_hangHoaList[index].TEN_HANG}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            IconButton(
                              icon: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                removeHangHoa(_hangHoaList[index]);
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: chiTietHangHoa(index),
                        )
                      ],
                    )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            thongTinGiaoDich(context)
          ],
        ),
      ),
    );
  }

  Container thongTinGiaoDich(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Form(
          child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                'Thông Tin Giao Dịch',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  readOnly: true,
                  controller: _tenKhachHang,
                  decoration: const InputDecoration(
                    labelText: 'Tên khách hàng:',
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 15.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    // _ThongTinhThucHienBanVang =
                    //     _ThongTinhThucHienBanVang.copyWith(
                    //         TONG_TIEN: double.tryParse(value ?? '') ?? 0.0);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextButton(
                      onPressed: () {
                        BangChonKhachHang(context);
                      },
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Chọn KH',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  readOnly: true,
                  controller: _thanhtoan,
                  decoration: const InputDecoration(
                    labelText: 'Thanh Toán',
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 15.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    // _ThongTinhThucHienBanVang =
                    //     _ThongTinhThucHienBanVang.copyWith(
                    //         TONG_TIEN: double.tryParse(value ?? '') ?? 0.0);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextButton(
                      onPressed: () {
                        showListSanPham();
                      },
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'THANH TOÁN',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // TextFormField(
          //   controller: _tongtien,
          //   decoration: const InputDecoration(
          //     labelText: 'Tổng tiền:',
          //     labelStyle:
          //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     filled: true,
          //     fillColor: Colors.white,
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.white, width: 15.0),
          //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //     ),
          //   ),
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.number,
          //   onSaved: (value) {
          //     // _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(
          //     //     TONG_TIEN: double.tryParse(value ?? '') ?? 0.0);
          //   },
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // TextFormField(
          //   controller: _tienbot,
          //   decoration: const InputDecoration(
          //     labelText: 'Tiền bớt:',
          //     labelStyle:
          //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     filled: true,
          //     fillColor: Colors.white,
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.white, width: 15.0),
          //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //     ),
          //   ),
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.number,
          //   onSaved: (value) {
          //     //   _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(
          //     //       TIEN_BOT: double.tryParse(value ?? '') ?? 0.0);
          //   },
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // TextFormField(
          //   controller: _thanhtoan,
          //   decoration: const InputDecoration(
          //     labelText: 'Thanh toán:',
          //     labelStyle:
          //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     filled: true,
          //     fillColor: Colors.white,
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.white, width: 15.0),
          //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //     ),
          //   ),
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.number,
          //   onSaved: (value) {
          //     // _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(
          //     //     THANH_TOAN: double.tryParse(value ?? '') ?? 0.0);
          //   },
          // ),
        ],
      )),
    );
  }

  Table chiTietHangHoa(int index) {
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
                child: Text('Loại Vàng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Mã Hàng',
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
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_hangHoaList[index].NHOM_TEN ?? ''),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_hangHoaList[index].MA ?? ''),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((_hangHoaList[index].SL ?? 0).toString()),
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
                child: Text('Cân Tổng',
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
                child: Text(
                    formatCurrencyDouble(_hangHoaList[index].TRU_HOT ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(formatCurrencyDouble(_hangHoaList[index].TL_HOT ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    formatCurrencyDouble(_hangHoaList[index].CAN_TONG ?? 0)),
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
                child: Text('Đơn Giá Gốc',
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
                child: Text(
                    formatCurrencyDouble(_hangHoaList[index].DON_GIA_GOC ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    formatCurrencyDouble(_hangHoaList[index].GIA_CONG ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    formatCurrencyDouble(_hangHoaList[index].THANH_TIEN ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Bảng chọn thông tin khách hàng
  Future<void> BangChonKhachHang(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _loadPage(int page) async {
              await _loadKhachhang(page: page);
              setState(() {}); // Update the state within the bottom sheet
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Chọn khách hàng',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Scrollbar(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              ShowListClient(),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible:
                                        _currentPage > 1, // Control visibility
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _loadPage(_currentPage - 1);
                                      },
                                      child: const Text('<'),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Visibility(
                                    visible: true, // Control visibility
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _loadPage(_currentPage + 1);
                                      },
                                      child: const Text('>'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //Show list Khách hàng
  FutureBuilder<List<Khachhang>> ShowListClient() {
    return FutureBuilder<List<Khachhang>>(
      future: _khachHangFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey),
              columns: const [
                DataColumn(
                  label: Text(
                    'Tên',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label:
                      Text('Điện thoại', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Địa chỉ', style: TextStyle(color: Colors.white)),
                ),
              ],
              rows: [
                ..._filteredKhachHang.map((client) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${client.kh_ten}'), onTap: () {
                        // Xử lý khi chọn khách hàng
                        setState(() {
                          _tenKhachHang.text = client.kh_ten!;
                        });
                        Navigator.pop(context); // Đóng BottomSheet
                      }),
                      DataCell(Text('${client.kh_sdt}')),
                      DataCell(Text('${client.kh_dia_chi}')),
                    ],
                  );
                }),
              ],
            ),
          );
        }
      },
    );
  }
}
