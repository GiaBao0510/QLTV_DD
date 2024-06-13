import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCaoPhieuMua.dart';

import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_KhoVangMuaVao.dart';

import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoNhomVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/components/them_dvi.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/dvi/dvi.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/hang_hoa/hang_hoa.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/khachhang/khachhang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/nha_cung_cap_green.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/ketnoi/ket_noi_page.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/nguoi_dung_page.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/nhompage.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/them_nhom.dart';
import 'package:app_qltv/FrontEnd/ui/components/NotConnectInternet.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_TonKhoLoaiVang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCao_PhieuXuat.dart';
import 'package:app_qltv/FrontEnd/ui/camvang/Phieu/PhieuDangCam.dart';
import 'package:app_qltv/FrontEnd/ui/camvang/Phieu/PhieuDangCamChiTiet.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoaiVangScreen.routeName: (ctx) => LoaiVangScreen(),
  KhachhangScreen.routeName: (ctx) => KhachhangScreen(),
  NhomVangScreen.routeName: (ctx) => NhomVangScreen(),
  ThemNhomVangScreen.routeName: (ctx) => ThemNhomVangScreen(),
  NhomPage.routeName: (ctx) => NhomPage(),
  NguoiDungPage.routeName: (ctx) => NguoiDungPage(),
  KetNoiPage.routeName: (ctx) => KetNoiPage(),
  ThemNhomScreen.routeName: (ctx) => ThemNhomScreen(),
  HangHoaScreen.routeName: (ctx) => HangHoaScreen(),
  KhoScreen.routeName: (ctx) => KhoScreen(),
  NhaCungCapScreen.routeName: (ctx) => NhaCungCapScreen(),
  KhachhangScreen.routeName: (ctx) => KhachhangScreen(),
  DonviScreen.routeName: (ctx) => DonviScreen(),
  ThemDonviScreen.routeName: (ctx) => ThemDonviScreen(),
  InterfaceConnectionError.routerName: (ctx) => InterfaceConnectionError(),
  BaoCaoTonKhoLoaiVangScreen.routeName: (ctx) => BaoCaoTonKhoLoaiVangScreen(),
  BaoCaoTonKhoVangScreen.routeName: (ctx) => BaoCaoTonKhoVangScreen(),
  PhieuDangCam.routeName: (ctx) => PhieuDangCam(),
  PhieuDangCamChiTiet.routeName: (ctx) => PhieuDangCamChiTiet(),
  BaoCaoTonKhoNhomVangScreen.routeName: (ctx) => BaoCaoTonKhoNhomVangScreen(),
  BaoCaoPhieuXuatScreen.routeName: (ctx) => BaoCaoPhieuXuatScreen(),

  BaoCaoPhieuMuaScreen.routeName:(ctx) => BaoCaoPhieuMuaScreen(),

  KhoVangMuaVaoScreen.routeName: (ctx) => KhoVangMuaVaoScreen(),

};
