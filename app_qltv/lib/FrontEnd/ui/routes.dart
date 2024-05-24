

// import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/nhom.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/them_nhom.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {

  NhomVangScreen.routeName: (ctx) => NhomVangScreen(),
  ThemNhomVangScreen.routeName: (ctx) => ThemNhomVangScreen(),
  NhomPage.routeName: (ctx) => NhomPage(),
  ThemNhomScreen.routeName: (ctx) => ThemNhomScreen(),
  KhoScreen.routeName:(ctx)=>KhoScreen(),
};

