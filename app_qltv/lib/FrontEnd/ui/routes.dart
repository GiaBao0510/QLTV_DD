

import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  loaiVang.routeName: (ctx) => loaiVang(),
  NhomVangScreen.routeName: (ctx) => NhomVangScreen(),
  ThemNhomVangScreen.routeName: (ctx) => ThemNhomVangScreen(),
};
