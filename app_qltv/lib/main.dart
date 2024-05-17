import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/home/home.dart';
import 'package:app_qltv/FrontEnd/ui/routes.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang_manager.dart'; // Import NhomVangManager của bạn

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NhomVangManager(),
      child: MaterialApp(
        title: 'Bao Khoa Gold',
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
        home: const HomeScreen(),
        routes: routes,
      ),
    );
  }
}
