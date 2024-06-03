  //>>>>  Thự viện
import 'package:flutter/material.dart';
import 'dart:io';
  //>>>>    Biến


  //>>>>>>    Hàm
//1.Định dạng lại đơn vị tiền tệ VND
String DinhDangDonViTien_VND(value) {
  late String formattedValue;
  if(value is int){
    formattedValue = value.toString().replaceAllMapped(
      RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"),
          (Match m) => '${m[1]}.',
    );
  }
  if(value is double){
    formattedValue = value.toStringAsFixed(3).replaceAllMapped(
      RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"),
          (Match m) => '${m[1]}.',
    );
  }
  if(value is num){
    formattedValue = value.toStringAsFixed(3).replaceAllMapped(
      RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"),
          (Match m) => '${m[1]}.',
    );
  }
  return formattedValue ;
}

//2. Kiểm tra kết nối Internet
Future<bool> ActiveConnection() async{
  try{
    final result = await InternetAddress.lookup('google.com');
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      return true;
    }
    return false;
  }catch(err){
    return false;
  }
}