import 'dart:convert';
import 'dart:ffi';

import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/controller/GiaoDich/BanVang_controller.dart';
import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/HoaDonMBManager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/model/GiaoDich/BanVang_model.dart';
import 'package:app_qltv/FrontEnd/model/GiaoDich/ProductMB.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
  late final List<TruocKhiThucHienBanVang_model> _hangHoaList = [];
  late final List<Product> _productList = [];
  Product product = Product(
    code: '',
    prodName: '',
    prodUnit: '',
    prodQuantity: 0,
    prodPrice: 0,
    vatRate: 0,
    vatAmount: 0.0,
    total: 0,
    amount: 0,
    prodAttr: 0,
  );

  late Future<List<Khachhang>> _khachHangFuture;
  List<Khachhang> _filteredKhachHang = [];
  String nameKH = '_____';
  String maKH = '';
  int _currentPage = 1;
  double _totalThanhToan = 0;

  // ignore: non_constant_identifier_names
  Future<void> _LoadData(maSp) async {
    //Lấy thông tin hàng hóa
    print('Mã Sản Phẩm: $maSp');
    _thongTinHangHoaFuture =
        Provider.of<BanvangController>(context, listen: false)
            .FecthThongTinSanPham(maSP: maSp);
    _thongTinHangHoaFuture.then((thongtin) {
      product = product.copyWith(
        code: thongtin.HANGHOAID,
        prodName: thongtin.TEN_HANG,
        prodUnit: '',
        prodQuantity: thongtin.SL,
        prodPrice: thongtin.THANH_TIEN,
        vatRate: 0,
        vatAmount: 0.0,
        total: thongtin.THANH_TIEN,
        amount: thongtin.THANH_TIEN,
        prodAttr: 0,
      );
      setState(() {
        _hangHoaList.add(thongtin);
        _productList.add(product);
        _totalThanhToan = _totalThanhToan + thongtin.THANH_TIEN!;
      });
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> _LoadDatabyCamera() async {
    //Lấy thông tin hàng hóa
    _thongTinHangHoaFuture =
        Provider.of<BanvangController>(context, listen: false)
            .ThongTinSanPham();
    _thongTinHangHoaFuture.then((thongtin) {
      product = product.copyWith(
        code: thongtin.HANGHOAID,
        prodName: thongtin.TEN_HANG,
        prodUnit: '',
        prodQuantity: thongtin.SL,
        prodPrice: thongtin.THANH_TIEN,
        vatRate: 0,
        vatAmount: 0.0,
        total: thongtin.THANH_TIEN,
        amount: thongtin.THANH_TIEN,
        prodAttr: 0,
      );
      setState(() {
        _hangHoaList.add(thongtin);
        _productList.add(product);
        _totalThanhToan = _totalThanhToan + thongtin.THANH_TIEN!;
      });
    });
  }

  Future<void> _loadKhachhang({int page = 1}) async {
    final manager = Provider.of<KhachhangManage>(context, listen: false);
    // Fetch customer information
    _khachHangFuture = manager.fetchKhachhang(page: page, pageSize: 10);
    final clients = await _khachHangFuture;
    setState(() {
      _filteredKhachHang = clients;
      _currentPage = page;
    });
  }

  void removeHangHoa(hangHoa) {
    setState(() {
      _hangHoaList.remove(hangHoa);
      _productList.removeWhere((product) => product.code == hangHoa.HANGHOAID);
    });
  }

  void quetMaQR(context) async {
    await ThuVienUntilState.scanQRcodePlus(context);
    _LoadDatabyCamera();
  }

  void quetBarQR(context) async {
    ThuVienUntilState.scanBarcodePlus(context);
    await _LoadDatabyCamera();
  }

  void nhapMaSanPham(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
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
                    print('Mã Sản Phẩm: $maSanPham');
                    _LoadData(maSanPham);
                    Navigator.pop(context); // Đóng BottomSheet
                  },
                  child: const Text('Xác Nhận'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showListSanPham() {
    print('DANHSACHHANGHOA');
    List<Map<String, dynamic>> jsonList =
        _productList.map((item) => item.toMap()).toList();

    // Mã hóa danh sách các map thành chuỗi JSON
    String jsonString = jsonEncode(jsonList);

    List<Map<String, dynamic>> jsonList2 =
        _hangHoaList.map((item) => item.toMap()).toList();

    // Mã hóa danh sách các map thành chuỗi JSON
    String jsonString2 = jsonEncode(jsonList2);
    print('HANGHOA_BaoKhoa[]: $jsonString2');
    print('HANGHOA_MatBao[]: $jsonString');
  }

  Future<bool> sendInvoiceMatBao() async {
    try {
      HoaDonMatBaoManager manager = HoaDonMatBaoManager();
      DateTime date = DateTime.now();
      String formattedDateNow = DateFormat('dd/MM/yyyy').format(date);
      String fKey = await manager.getFKey();
      // print('=========fkey: $fKey =========');
      // print('=========formattedDateNow: $formattedDateNow =========');
      await manager.postHoaDonMatBao(
        fkey: fKey,
        arisingDate: formattedDateNow,
        so: "",
        maKH: maKH,
        cusName: nameKH,
        buyer: "Tập đoàn X",
        cusAddress: "",
        cusPhone: "",
        cusTaxCode: "",
        cusEmail: "",
        paymentMethod: "",
        products: _productList,
        total: _totalThanhToan,
        discountAmount: 0.0,
        vatAmount: 0.0,
        amount: _totalThanhToan,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendPhieuXuat() async {
    try {
      BanvangController manager = BanvangController();
      await manager.ThucHienGiaoDichBanVangPlus(
        maKH: maKH,
        khachDua: 0,
        tienBot: 0,
        hangHoa: _hangHoaList,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  void handleThanhToan() async {
    showListSanPham();

    bool invoiceSuccess = await sendInvoiceMatBao();
    bool phieuXuatSuccess = await sendPhieuXuat();

    if (invoiceSuccess && phieuXuatSuccess) {
      setState(() {
        _hangHoaList.clear();
        _productList.clear();
        _totalThanhToan = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gửi hóa đơn và phiếu xuất thành công!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gửi hóa đơn hoặc phiếu xuất thất bại.')));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadKhachhang();
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
              child: _hangHoaList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              quetMaQR(context);
                            },
                            child: const Text(
                              'Mã QR',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 228, 200, 126),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              quetBarQR(context);
                            },
                            child: const Text(
                              'Mã Vạch',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 228, 200, 126),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              nhapMaSanPham(context);
                            },
                            child: const Text(
                              'Nhập Mã',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 228, 200, 126),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'no.${index + 1}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    '${_hangHoaList[index].TEN_HANG}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      nameKH,
                      style: const TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        formatCurrencyDouble(_totalThanhToan),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 231, 107, 40),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    onPressed: () {
                      handleThanhToan();
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'THANH TOÁN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
  // ignore: non_constant_identifier_names
  Future<void> BangChonKhachHang(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void loadPage(int page) async {
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
                                        loadPage(_currentPage - 1);
                                      },
                                      child: const Text('<'),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Visibility(
                                    visible: true, // Control visibility
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loadPage(_currentPage + 1);
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
  // ignore: non_constant_identifier_names
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
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            // Xử lý khi chọn khách hàng
                            setState(() {
                              nameKH = client.kh_ten!;
                              maKH = client.kh_ma!;
                            });
                            Navigator.pop(context); // Đóng BottomSheet
                          },
                          child: Text('${client.kh_ten}'),
                        ),
                      ),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            // Xử lý khi chọn khách hàng
                            setState(() {
                              nameKH = client.kh_ten!;
                              maKH = client.kh_ma!;
                            });
                            Navigator.pop(context); // Đóng BottomSheet
                          },
                          child: Text('${client.kh_sdt}'),
                        ),
                      ),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            // Xử lý khi chọn khách hàng
                            setState(() {
                              nameKH = client.kh_ten!;
                              maKH = client.kh_ma!;
                            });
                            Navigator.pop(context); // Đóng BottomSheet
                          },
                          child: Text('${client.kh_dia_chi}'),
                        ),
                      ),
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
