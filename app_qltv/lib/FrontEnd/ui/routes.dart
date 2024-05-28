
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCaoTonKhoVang/BaoCao_TonKhoVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/hang_hoa.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/nha_cung_cap_green.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/nhompage.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/them_nhom.dart';
import 'package:app_qltv/FrontEnd/ui/components/NotConnectInternet.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCaoTonKhoVang/BaoCao_TonKhoLoaiVang.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = {
  LoaiVangScreen.routeName: (ctx) => LoaiVangScreen(),
  NhomVangScreen.routeName: (ctx) => NhomVangScreen(),
  ThemNhomVangScreen.routeName: (ctx) => ThemNhomVangScreen(),
  NhomPage.routeName: (ctx) => NhomPage(),
  ThemNhomScreen.routeName: (ctx) => ThemNhomScreen(),
  HangHoaScreen.routeName:(ctx)=>HangHoaScreen(),
  KhoScreen.routeName:(ctx)=>KhoScreen(),
  NhaCungCapScreen.routeName:(ctx)=>NhaCungCapScreen(),
  InterfaceConnectionError.routerName:(ctx)=>InterfaceConnectionError(),

  Table_BaoCaoTonKhoLoaiVang.routeName:(ctx)=>Table_BaoCaoTonKhoLoaiVang(),
  Table_BaoCaoTonKhoVang.routeName:(ctx)=>Table_BaoCaoTonKhoVang(),
};

