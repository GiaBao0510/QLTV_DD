import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';

class Table_BaoCaoTonKhoLoaiVang extends StatefulWidget{
  const Table_BaoCaoTonKhoLoaiVang({super.key});
  State<Table_BaoCaoTonKhoLoaiVang> createState() => _Table_BaoCaoTonKhoLoaiVang();
}

class _Table_BaoCaoTonKhoLoaiVang extends State<Table_BaoCaoTonKhoLoaiVang>{
  //Thuộc tính
  bool isListViSible = false,       //Kiểm tra xem có hiển thị danh sách hay khng
        isLoadData = false;         //Kiểm tra xem dữ liệu đã load lên hay chưa
  List<dynamic> _baocaotonkholoaivangList = [];
  List<dynamic> _Filter_baocaotonkholoaivangList = [];
  final TextEditingController _searchController = TextEditingController();

  //-------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //    >>>   Các phương thức   <<<

    //1. Truy xuất lấy thông tin
  Future<List<dynamic>> BaoCaoTonKhoLoaiVang_List() async{
    String path = url+'/api/admin/baocaotonkholoaivang';
    var res = await http.get(Uri.parse(path), headers: {"Content-Type": "application/json"} );
    print(res.body);
    Map<String, dynamic> jsondata = jsonDecode(res.body);
    List<dynamic> resultList = jsondata['data'];
    Map<String, dynamic> tinhTongList = jsondata['sumary'];

    return [resultList, tinhTongList];
  }

    //2. Load dữ liêệu
  Future<void> LoadData() async{
    final result = await BaoCaoTonKhoLoaiVang_List();
    _baocaotonkholoaivangList = result[0];
    _Filter_baocaotonkholoaivangList = result[0];
    isLoadData = true;
  }

    //Phương thưc tim tên hang hoa
  void _filterBaoCaoTonKhoLoaiVang(){
    final query = _searchController.text.toLowerCase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        title: const Text('Báo cáo tồn kho loại vàng', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Align', fontWeight: FontWeight.bold), ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [ Colors.blueAccent, Colors.lightBlue ]
              )
          ),
        ),
      ),
      body: Stack(children: [
          GestureDetector(
            onTap: (){
              setState(() {
                isListViSible = false;
              });
            },
            child: Scrollbar(
              child: ListView(
                children: [
                  Column(
                    children: [
                      FutureBuilder<List<dynamic>>(
                          future: BaoCaoTonKhoLoaiVang_List(),
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const Center(child: CircularProgressIndicator(),);
                            }else if(snapshot.hasError){
                              return Center(child: Text('Error: ${snapshot.error}'),);
                            }else{
                              final data = snapshot.data!;

                              return const Column(
                                children:  [

                                  //Phần baảng


                                  //Phần tổng tính toán
                                ],
                              );
                            }
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      ],),
    );
  }
}