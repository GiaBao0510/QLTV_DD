  //>>>>  Thự viện
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';

  //>>>>>>>>>>>>>>>>>>>>>>
  //>>>>    Biến
  //>>>>>>>>>>>>>>>>>>>>>>

  //>>>>>>>>>>>>>>>>>>>>>>
  //>>>>>>    Hàm
  //>>>>>>>>>>>>>>>>>>>>>>
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

//3.Lấy ngày giờ hiện tại
String CurrentDateAndTime(){
  final now = DateTime.now();
  final formatter = DateFormat('dd/MM/yyyy HH:mm a');
  String formatterDate = formatter.format(now);
  return formatterDate;
}

  //Thu vien
class ThuVienUntil extends StatefulWidget {
  const ThuVienUntil({super.key});

  @override
  State<ThuVienUntil> createState() => ThuVienUntilState();
}

class ThuVienUntilState extends State<ThuVienUntil> {

    //>>>>>>>>>>>>>>>>>>>>>>
    //>>>>    Thuộc tính
    //>>>>>>>>>>>>>>>>>>>>>>
  static int limit = 10;       //Số lần cho hiển thị tối đa
  static int offset = 0;       //Số lần bỏ qua
  static int increase = 15;    //Số lần tăng khi bỏ qua
  static DateTime ngayBD = DateTime.now();   //Ngày bắt đầu
  static DateTime ngayKT = DateTime.now();   //Ngày kết thúc

  static ScrollController scrollController = ScrollController();
  static TextEditingController StartDayController = TextEditingController();
  static TextEditingController EndDayController = TextEditingController();
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    //>>>>>>>>>>>>>>>>>>>>>>
    //>>>>  phương thức
    //>>>>>>>>>>>>>>>>>>>>>>
  //1. Chọn ngày bắt đầu
   void SelectStartDay() async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ngayBD,
      firstDate: DateTime(1999),
      lastDate: DateTime(2200),
    );
    if(picked != null && picked != ngayBD){
      setState((){
        ngayBD = picked;
        StartDayController.text = dateFormat.format(ngayBD);
      });
    }
  }

  //2. Chọn ngày kết thúc
  void SelectEndDay() async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ngayKT,
      firstDate: DateTime(1999),
      lastDate: DateTime(2200),
    );
    if(picked != null && picked != ngayKT){
      setState((){
        ngayKT = picked;
        EndDayController.text = dateFormat.format(ngayKT);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


