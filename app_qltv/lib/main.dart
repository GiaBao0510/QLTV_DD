import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoPhieuXuat_manage.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoLoaiVang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/don_vi_manage.dart';

import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';

import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoNhomVang_manager.dart';

import 'package:app_qltv/FrontEnd/controller/danhmuc/kho_manage.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/hanghoa_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhacungcap_manager.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/kho.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:app_qltv/FrontEnd/ui/components/NotConnectInternet.dart';
import 'package:app_qltv/FrontEnd/ui/home/home.dart';
import 'package:app_qltv/FrontEnd/ui/routes.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart'; // Import NhomVangManager của bạn
import 'package:session_manager/session_manager.dart';
import 'package:app_qltv/FrontEnd/ui/home/component/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Kiểm tra xem đang nhap hay chua voi kiem tra có ket noi mang hay chua
  Future<Widget> KiemTraDangNhap(BuildContext context) async {
    // >>>>>> kIỂM TRA KẾT NỐI MẠNG
    final result = await ActiveConnection();
    print("Ket noi: $result");
    if (result == true) {
      //Nếu kết nôi mạng thành công thi chuyeen sang kiem tra dang nhap
      // >>>>>> kIỂM TRA ĐĂNG NHẬP
      //Lấy thông tin
      String taiKhoan = await SessionManager().getString('username');

      //Nếu chưa có tìa khoản thì chuyển sang trang đăng nhập
      if (taiKhoan.isEmpty) {
        return LoginPage();
      }

      // >>>>>>>>>>>>>>>>>>>>>>> Vấn đề <<<<<<<<<<<<<<<<<<<<<<<<<
      // var res = await http.post(Uri.parse(checkValid), headers: {"Content-Type": "application/json"},);
      //
      // print(res.body);
      // final thongtinphanhoi = jsonDecode(res.body);
      // final hieuluc = thongtinphanhoi['valid'] as int;
      //
      // //Nếu chưa có tài khoản cn hiệu lực không. Nếu hết hiệu lực thì đăng nhập
      // if(hieuluc == 0){
      //   return const LoginPage();
      // }
      return const HomeScreen();
    } else {
      return InterfaceConnectionError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NhomVangManager()),
        ChangeNotifierProvider(create: (context) => LoaiVangManager()),
        ChangeNotifierProvider(create: (context) => NhaCungCapManager()),
        ChangeNotifierProvider(create: (context) => NhomManager()),
        ChangeNotifierProvider(create: (context) => NguoiDungManager()),
        ChangeNotifierProvider(create: (context) => KhoManage()),
        ChangeNotifierProvider(create: (context) => DonviManage()),
        ChangeNotifierProvider(create: (context) => KhachhangManage()),
        ChangeNotifierProvider(create: (context) => HangHoaManager()),
        ChangeNotifierProvider(
            create: (context) => BaoCaoTonKhoNhomVangManager()),
        ChangeNotifierProvider(
            create: (context) => BaoCaoTonKhoLoaiVangManager()),
        ChangeNotifierProvider(create: (context) => BaocaophieuxuatManage()),
      ],
      child: MaterialApp(
        title: 'Phần mềm vàng',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // Thiết lập màu nền cho AppBar
            foregroundColor: Colors.black, // Thiết lập màu chữ cho AppBar
            elevation: 0, // Xóa bỏ hiệu ứng đổ bóng của AppBar
          ),
        ),
        home: FutureBuilder<Widget>(
          future: KiemTraDangNhap(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        routes: routes,
      ),
    );
  }
}
