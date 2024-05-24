import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body:Table_BaoCaoTonKhoVang() ,
        ),
      ),
      theme: ThemeData(fontFamily: 'Arial'),
      debugShowCheckedModeBanner: false,
    )
  );
}

class Table_BaoCaoTonKhoVang extends StatefulWidget{
  const Table_BaoCaoTonKhoVang({super.key});

  State<Table_BaoCaoTonKhoVang> createState() => _Table_BaoCaoTonKhoVang();
}
class _Table_BaoCaoTonKhoVang extends State<Table_BaoCaoTonKhoVang>{
  List<dynamic> _filterBaoCaoTonKho_list = [];
  List<dynamic> _BaoCaoTonKho_list = [];
  final TextEditingController _searchController = TextEditingController();
  Map<String,dynamic> ThongTinTinhTong = {};

  double tong_TLThuc = 0.0, tong_CongGoc= 0.0,
      tong_TLvang= 0.0, tong_TL_hot=0.0,
      tong_GiaCong=0.0, thanhTien=0.0;

  @override
  void initState() {
    super.initState();
    Load_BaoCaoTonKhoVang();
    _searchController.addListener(_filterBaoCaoTonKhoVang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //Lấy danh sách báo cáo được phản hòi về
  Future<List<dynamic>> BaoCaoTonKhoVang_list() async{
    String path = url+'/api/admin/baocaotonkho';
    var res = await http.get( Uri.parse(path),headers: {"Content-Type": "application/json"} );
    //print(res.body);
    Map<String,dynamic> jsonData = jsonDecode(res.body);
    List<dynamic> resultList = jsonData['result'];
    Map<String,dynamic> tinhTongList = jsonData['tinhTong'];

    return [resultList,tinhTongList];
  }

  //Phuong thuc load dư liệu
  Future<void> Load_BaoCaoTonKhoVang() async{
    final result =  await BaoCaoTonKhoVang_list();
    _filterBaoCaoTonKho_list = result[0];
    _BaoCaoTonKho_list =result[0];
    ThongTinTinhTong = result[1];
  }

  //Phương thuc tim tên loại
  void _filterBaoCaoTonKhoVang() async{
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filterBaoCaoTonKho_list = _BaoCaoTonKho_list.where(
          (item){
            return item['NHOM_TEN']!=null && item['NHOM_TEN'].toString().toLowerCase().contains(query);
          }
      ).toList();
    });
  }

  //Tạo tiện ích thanh tìm kiếm
  Widget Search_Bar({required TextEditingController seachController}){
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: TextField(
        controller: seachController,
        decoration: InputDecoration(
            hintText: "Tìm kiếm",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            suffixIcon: Icon(Icons.search)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar:AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 28,
          ),
          title: Text('Báo cáo tồn kho', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Align', fontWeight: FontWeight.bold), ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [ Colors.blueAccent, Colors.lightBlue ]
                )
            ),
          ),
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              Column(
                children: [
                  Row(children: [
                    Expanded(
                      flex: 2,
                        child: Search_Bar(seachController: _searchController),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: (){
                          print('Xuất file PDF');
                        },
                        child: Text('Export'),
                      ),
                    ),
                  ],),

                  const SizedBox(height: 40,),

                  //Bảng hiên thi
                  FutureBuilder<List<dynamic>>(
                    future: BaoCaoTonKhoVang_list(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(snapshot.hasError){
                        return Center(child: Text('Error: ${snapshot.error}'),);
                      }else{
                        final data = snapshot.data!;
                        final ThongTinChung = data[0];
                        ThongTinTinhTong = data[1];
                        _filterBaoCaoTonKho_list = ThongTinChung;

                        return  SingleChildScrollView(
                          scrollDirection:  Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black87),
                            //Tiêu đề
                            columns: [
                              DataColumn(label: Text('Loại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
                              DataColumn(label: Text('Tên', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('Số lượng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('TL_Thực', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('TL hột', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('TL vàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('Công gốc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('Giá công', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                              DataColumn(label: Text('Thành tiền', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white))),
                            ],

                            //Nội dung hàng
                            rows: List.generate(
                                _filterBaoCaoTonKho_list.length,
                                    (index){
                                  final item = _filterBaoCaoTonKho_list[index];

                                  //Khởi tạo biến tính tổng
                                  tong_TLThuc = double.parse(ThongTinTinhTong['tong_TLThuc']?.toString() ?? '0.0');
                                  tong_TL_hot = double.parse(ThongTinTinhTong['tong_TL_hot']?.toString() ?? '0.0');
                                  tong_TLvang = double.parse(ThongTinTinhTong['tong_TLvang']?.toString() ?? '0.0');
                                  tong_CongGoc = double.parse(ThongTinTinhTong['tong_CongGoc']?.toString() ?? '0.0');
                                  tong_GiaCong = double.parse(ThongTinTinhTong['tong_GiaCong']?.toString() ?? '0.0');
                                  thanhTien = double.parse(ThongTinTinhTong['thanhTien']?.toString() ?? '0.0');

                                  return DataRow(
                                      color: MaterialStateColor.resolveWith((state){
                                        return index %2 == 0 ? Colors.black12: Colors.white;
                                      }),
                                      cells: [
                                        DataCell(Text('${item['NHOM_TEN'] ?? ''}')),
                                        DataCell(Text('${''}')),
                                        DataCell(Text('${item['SoLuong'] ?? ''}')),
                                        DataCell(Text('${item['TL_Thuc'] ?? ''}')),
                                        DataCell(Text('${item['TL_hot'] ?? ''}')),
                                        DataCell(Text('${item['TL_vang'] ?? ''}')),
                                        DataCell(Text('${item['CONG_GOC'] ?? ''}')),
                                        DataCell(Text('${item['GIA_CONG'] ?? ''}')),
                                        DataCell(Text('${''}')),
                                      ],
                                      onLongPress: () => ThongTinChiTiet(context, item),
                                  );
                                }
                            ),
                          ),
                        );
                      }
                    },
                  ),

                  //Hiên thị thông tin đã tính toán
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff4463fd), Color(0xff405be2)],
                        stops: [0.25, 0.75],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )

                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        Text('Tổng TL_Thực: ${tong_TLThuc.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Tổng TL_hột: ${tong_TL_hot.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Tổng TL vàng: ${tong_TLvang.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Tổng Công gốc: ${tong_CongGoc.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Tổng Giá công: ${tong_GiaCong.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Tổng Thành tiền: ${thanhTien.toStringAsFixed(3)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      );
  }

  //Show thông tin chi tiết
  Future<void> ThongTinChiTiet(BuildContext context, Map<String,dynamic> item) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông tin chi tiết'),
          content: FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Loại: ',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${item['NHOM_TEN']}')
                ],),
                Row(children: [
                  Text('Số lượng: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['SoLuong']}')
                ],),
                Row(children: [
                  Text('TL_Thực: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['TL_Thuc']}')
                ],),
                Row(children: [
                  Text('TL_Hột: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['TL_hot']}')
                ],),
                Row(children: [
                  Text('TL_vàng: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['TL_vang']}')
                ],),
                Row(children: [
                  Text('Công gốc: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['CONG_GOC']}')
                ],),
                Row(children: [
                  Text('Giá công: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['GIA_CONG']}')
                ],),
                Row(children: [
                  Text('Thành tiền: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['NHOM_TEN']}')
                ],),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed:() => Navigator.of(context).pop(),
              child: Text('Đóng', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
            )
          ],
        );
      },
    );
  }
}