import 'package:app_qltv/FrontEnd/ui/GiaoDich/GiaoDichBanVangPlus.dart';
import 'package:app_qltv/FrontEnd/ui/HoaDonBanRa/DanhSachHoaDonMBScreen.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCaoPhieuMua.dart';

import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_KhoVangMuaVao.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_PhieuDoi.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TopKhachHang.dart';

import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/dvi.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoNhomVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/hang_hoa.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/khachhang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/nha_cung_cap_green.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoLoaiVang.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/ketnoi/ket_noi_page.dart';
import '../../danh_muc/BaoCao/BaoCao_PhieuXuat.dart';
import 'package:app_qltv/FrontEnd/ui/camvang/Phieu/PhieuDangCam.dart';
import 'package:app_qltv/FrontEnd/ui/camvang/Phieu/PhieuDangCamChiTiet.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/nguoi_dung_page.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/nhompage.dart';
import 'package:app_qltv/FrontEnd/ui/HoaDonBanRa/TaoHoaDonNhap.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/temp.dart';
import 'package:app_qltv/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_manager/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'dart:core';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  //Lấy tên người dùng
  Future<String> _getTenAdmin() async {
    return await SessionManager().getString('username');
  }

  //Lấy ngày giơ hiện tại
  String _getDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formatDate = formatter.format(now);
    return formatDate;
  }

  //Quyển của ứng dụng  trên thiết bị
  Future<void> _request_permission() async {
    await openAppSettings();
  }

  //Thực hiện đănng xuất
  Future<void> Logout(BuildContext context) async {
    try {
      String path = logout;
      var res = await http
          .post(Uri.parse(path), headers: {"Content-Type": "application/json"});
      print(res.body);

      SessionManager().setString('username', '');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: " Đăng xuất thành công",
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    } catch (e) {
      print('Lỗi khi thực hiện đăng xuất: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    ThuVienUntilState.maHangHoa = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: const Text(
                    'Phần Mềm Vàng',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 25),
                  ),
                  accountEmail: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle_outlined,
                              size: 33, color: Colors.black),
                          const SizedBox(width: 8),
                          FutureBuilder<String>(
                            future: _getTenAdmin(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 43.0),
                          child: Text(
                            '${_getDate()}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/drawer_header.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/category.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Danh Mục',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/gold-ingot.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Loại Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoaiVangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/treasure.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Nhóm Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NhomVangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/box.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Hàng Hóa',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HangHoaScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/database.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Kho',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KhoScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/boy.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('NCC',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NhaCungCapScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/avatar-design.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Khách Hàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KhachhangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/computer-worker.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Đơn Vị',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DonviScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/management.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Hệ Thống',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/users.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Nhóm Người Dùng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NhomPage()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/person.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Người Dùng ',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NguoiDungPage()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/remote-access.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Kết Nối',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KetNoiPage()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/access-control.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Quản lý quyền',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          _request_permission();
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/pawnshop.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Cầm Vàng',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/MortgageDocument.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Phiếu Đang Cầm',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhieuDangCam()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/DetailOfMortgageDocument.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Phiếu Đang Cầm Chi Tiết ',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PhieuDangCamChiTiet()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/transaction.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Giao Dịch',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/money-transfer.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Giao Dịch Bán Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BanVangPlus()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/clipboard.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Báo Cáo',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/budget.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Phiếu Xuất',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoPhieuXuatScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/report.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Tồn Kho Loại Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          // Handle Báo Cáo Tồn Kho Loại Vàng tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoTonKhoLoaiVangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/clipboards.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Tồn Kho Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          //Handle Báo Cáo Tồn Kho Loại Vàng tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BaoCaoTonKhoVangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/documents.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Tồn Theo Nhóm Vàng',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoTonKhoNhomVangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/shopping-bag.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Kho Vàng Mua Vào',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KhoVangMuaVaoScreen()),
                          );
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0), // Khoảng cách thụt lề
                    //   child: ListTile(
                    //     leading: Image.asset(
                    //       'assets/images/paper.png',
                    //       width: 24.0,
                    //       height: 24.0,
                    //     ),
                    //     title: const Text('In Phiếu Xuất',
                    //         style: TextStyle(fontWeight: FontWeight.w800)),
                    //     onTap: () {
                    //       // Handle Báo Cáo Tồn Kho Loại Vàng tap
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/presentation.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Khách Hàng Giao Dịch',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoTopKhachHangScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/shopping-list.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Phiếu Mua Vào',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoPhieuMuaScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/document.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Báo Cáo Phiếu Đổi',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BaoCaoPhieuDoiScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/billofsale.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: const Text('Hóa Đơn Bán Ra',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/invoiceList.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Danh Sách Hóa Đơn',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DanhSachHoaDonMBScreen()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0), // Khoảng cách thụt lề
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/addInvoice.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        title: const Text('Thêm Hóa Đơn ',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ThemHoaDon_nhap()),
                          );
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0), // Khoảng cách thụt lề
                    //   child: ListTile(
                    //     leading: Image.asset(
                    //       'assets/images/deleteInvoice.png',
                    //       width: 24.0,
                    //       height: 24.0,
                    //     ),
                    //     title: const Text('Xóa hóa đơn ',
                    //         style: TextStyle(fontWeight: FontWeight.w800)),
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const PhieuDangCamChiTiet()),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0), // Khoảng cách thụt lề
                    //   child: ListTile(
                    //     leading: Image.asset(
                    //       'assets/images/InvoiceAdjustment.png',
                    //       width: 24.0,
                    //       height: 24.0,
                    //     ),
                    //     title: const Text('Điều chỉnh hóa đơn ',
                    //         style: TextStyle(fontWeight: FontWeight.w800)),
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const PhieuDangCamChiTiet()),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 16.0), // Khoảng cách thụt lề
                    //   child: ListTile(
                    //     leading: Image.asset(
                    //       'assets/images/ChangeBill.png',
                    //       width: 24.0,
                    //       height: 24.0,
                    //     ),
                    //     title: const Text('Thay thế hóa đơn ',
                    //         style: TextStyle(fontWeight: FontWeight.w800)),
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const PhieuDangCamChiTiet()),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),

          //Phần kiêm tra chuc nang
          // Container(
          //   child: ListTile(
          //     leading: Image.asset('assets/images/test.png'),
          //     title: Text('Test chức năng'),
          //     onTap: () {},
          //   ),
          // ),

          //Nút đăng xuất
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: ElevatedButton(
              onPressed: () {
                print('Đã bấm đăng xuất');
                Logout(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(252, 158, 21, 1),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Align'),
                    ),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.logout)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class drawer extends StatelessWidget {
//   const drawer({
//     super.key,
//   });
//
//
// }
