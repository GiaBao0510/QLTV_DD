import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoVang.dart';

class BaocaotonkhovangManager with ChangeNotifier{

  //Data
  List<Data> _BaoCaoTonKhoVang = [];
  List<Data> get baoCaoTonKhoVang => _BaoCaoTonKhoVang;
  int get baoCaoTonKhoVang_lenght => _BaoCaoTonKhoVang.length;

  //Tinh tong
  List<tinhTong> _tinhTong = [];
  List<tinhTong> get TinhTong => _tinhTong;
  int get TinhTong_length => _tinhTong.length;

  Future<List<dynamic>> fetchBaoCaoTonKhoVang() async{
    final res = await http.get( Uri.parse('$url/api/admin/baocaotonkho') );

    if(res.statusCode == 200){

        final jsonList = jsonDecode(res.body);
        final jsonResult = jsonList['result'] as List<dynamic>;
        final jsonTinhTong = jsonList['tinhTong'] as  List<dynamic>;

        List<Data>  baocaotonkhovangList = jsonResult.map((e)=> Data.fromMap(e)).toList();
        List<tinhTong> tinhTongList = jsonTinhTong.map((e) => tinhTong.fromMap(e)).toList();
        _tinhTong = tinhTongList;
        _BaoCaoTonKhoVang = baocaotonkhovangList;

        notifyListeners();
        return [ baocaotonkhovangList,tinhTongList];

    }else{
      throw Exception('Failed to load data');
    }
  }
}