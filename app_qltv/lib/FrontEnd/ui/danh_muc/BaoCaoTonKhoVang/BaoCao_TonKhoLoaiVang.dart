import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

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
  Map<String, dynamic> ThongTinTinhTong = {};
  final TextEditingController _searchController = TextEditingController();
  double TongTL_Thuc = 0.0, TongTL_hot= 0.0, TongTL_Vang= 0.0,
        TongCongGoc= 0.0, TongGiaCong= 0.0,TongThanhTien= 0.0;

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
  Future<List<dynamic>> BaoCaoTonKhoLoaiVang_List() async {
    String path = url + '/api/admin/baocaotonkholoaivang';
    var res = await http.get( Uri.parse(path),headers: {"Content-Type": "application/json"} );
    //print(res.body);
    Map<String,dynamic> jsonData = jsonDecode(res.body);
    List<dynamic> resultList = jsonData['data'];
    Map<String,dynamic> tinhTongList = jsonData['sumary'];

    return [resultList,tinhTongList];
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
                  colors: [ Colors.orange, Colors.amber ]
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
                      //Phần thân
                      FutureBuilder<List<dynamic>>(
                          future: BaoCaoTonKhoLoaiVang_List(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              final data = snapshot.data!;
                              final resultList = data[0];
                              final tinhTongList = data[1];

                              return SingleChildScrollView(
                                scrollDirection:  Axis.horizontal,
                                child: DataTable(
                                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black87),
                                  columns: [
                                    DataColumn(label: Text('Loại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
                                    DataColumn(label: Text('Mã', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('Tên hàng hóa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('Nhóm vàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('TL_Thực', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('TL hột', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('TL vàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('Công gốc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('Giá công', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                    DataColumn(label: Text('Thành tiền', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                                  ],
                                  rows: List.generate(
                                      data.length,
                                          (index){
                                        final thongtin = data[index]['data'];
                                        final tinhtong =  data[index]['sumary'];

                                        return DataRow(
                                          color: MaterialStateColor.resolveWith((state){
                                            return index %2 == 0 ? Colors.black12: Colors.white;
                                          }),
                                          cells:[
                                            DataCell(Text('${thongtin['NHOM_TEN'] ?? ''}') ),
                                            DataCell(Text('${thongtin['HANGHOAMA'] ?? ''}') ),
                                            DataCell(Text('${thongtin['HANG_HOA_TEN'] ?? ''}') ),
                                            DataCell(Text('${thongtin['LOAI_TEN'] ?? ''}') ),
                                            DataCell(Text('${thongtin['CAN_TONG'] ?? ''}') ),
                                            DataCell(Text('${thongtin['TL_HOT'] ?? ''}') ),
                                            DataCell(Text('${thongtin['TL_vang'] ?? ''}') ),
                                            DataCell(Text('${thongtin['CONG_GOC'] ?? ''}') ),
                                            DataCell(Text('${thongtin['GIA_CONG'] ?? ''}') ),
                                            DataCell(Text('${thongtin['DonGiaBan'] ?? ''}') ),
                                            DataCell(Text('${thongtin['ThanhTien'] ?? ''}') ),
                                          ],

                                        );
                                      }
                                  ),
                                ),
                              );
                            }
                          }
                      ),

                      //Phần tìm kiếm với export
                    ],
                  )
                ],
              ),
            ),
          )
      ],),
    );
  }

  //Phương thức xây dựng giao diện
  // Future<Widget> ShowReport(List<dynamic> input) async{
  //   return FutureBuilder<List<dynamic>>(
  //     future: Future.value(input),
  //     builder: (context, snapshot){
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       }else{
  //         final data = snapshot.data!;
  //         // final thongtin = data[0];
  //         // final tinhtong = data[1];
  //         return DataTable(
  //             headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black87),
  //             columns: [
  //               DataColumn(label: Text('Loại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
  //               DataColumn(label: Text('Mã', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('Tên hàng hóa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('Nhóm vàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('TL_Thực', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('TL hột', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('TL vàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('Công gốc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('Giá công', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //               DataColumn(label: Text('Thành tiền', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
  //             ],
  //             rows: List.generate(
  //                 data.length,
  //                 (index){
  //                   final thongtin = data[index]['data'];
  //                   final tinhtong =  data[index]['sumary'];
  //
  //                   return DataRow(
  //                       color: MaterialStateColor.resolveWith((state){
  //                         return index %2 == 0 ? Colors.black12: Colors.white;
  //                       }),
  //                       cells:[
  //                         DataCell(Text('${thongtin['NHOM_TEN'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['HANGHOAMA'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['HANG_HOA_TEN'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['LOAI_TEN'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['CAN_TONG'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['TL_HOT'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['TL_vang'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['CONG_GOC'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['GIA_CONG'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['DonGiaBan'] ?? ''}') ),
  //                         DataCell(Text('${thongtin['ThanhTien'] ?? ''}') ),
  //                       ],
  //
  //                   );
  //                 }
  //             ),
  //
  //         );
  //       }
  //     },
  //   );
  //}
}