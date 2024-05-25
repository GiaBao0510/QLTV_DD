import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoVang.dart';

class BaocaotonkhovangManager with ChangeNotifier{
  List<BaoCaoTonKhoVang> _BaoCaoTonKhoVang = [];
  List<BaoCaoTonKhoVang> get baoCaoTonKhoVang => _BaoCaoTonKhoVang;
  
  int get baoCaoTonKhoVang_lenght => _BaoCaoTonKhoVang.length;
  
  Future<List<BaoCaoTonKhoVang>> fetchBaoCaoTonKhoVang() async{
    final res = await http.get( Uri.parse('$url/api/admin/baocaotonkho') );

    if(res.statusCode == 200){
      try{
        List<dynamic> jsonList = jsonDecode(res.body);
        List<BaoCaoTonKhoVang> baocaotonkhovangList = jsonList.map((e)=> BaoCaoTonKhoVang.fromMap(e)).toList();
        _BaoCaoTonKhoVang = baocaotonkhovangList;
        notifyListeners();
        return baocaotonkhovangList;
      }catch(e){
        print('Error occurred while mapping data: $e');
        return [];
      }
    }else{
      throw Exception('Failed to load data');
    }
  }
}