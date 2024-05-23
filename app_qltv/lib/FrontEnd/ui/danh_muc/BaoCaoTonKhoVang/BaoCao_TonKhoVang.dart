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
    print(res.body);
    List<dynamic> list = jsonDecode(res.body);
    return list;
  }

  //Phuong thuc load dư liệu
  Future<void> Load_BaoCaoTonKhoVang() async{
    _filterBaoCaoTonKho_list = await BaoCaoTonKhoVang_list();
    _BaoCaoTonKho_list = await BaoCaoTonKhoVang_list();
  }

  //Phương thuc tim tên loại
  void _filterBaoCaoTonKhoVang() async{
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filterBaoCaoTonKho_list = _BaoCaoTonKho_list.where(
          (baocaotonkho){
            return baocaotonkho.NHOM_TEN!.toString().toLowerCase().contains(query);
          }
      ).toList();
    });
  }

  //Tạo tiện ích thanh tìm kiếm
  Widget Search_Bar({required TextEditingController seachController}){
    return Padding(
      padding: EdgeInsets.all(0),
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
    return Scaffold(
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
          body: Column(
            children: [
              Search_Bar(seachController: _searchController),
              const SizedBox(height: 50,),

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
                    final danhsach = snapshot.data!;
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
                            danhsach.length,
                            (index){
                              return DataRow(
                                color: MaterialStateColor.resolveWith((state){
                                  return index %2 == 0 ? Colors.black12: Colors.white;
                                }),
                                cells: [
                                  DataCell(Text('${danhsach[index]['NHOM_TEN'] ?? ''}')),
                                  DataCell(Text('${''}')),
                                  DataCell(Text('${danhsach[index]['SoLuong'] ?? ''}')),
                                  DataCell(Text('${danhsach[index]['TL_Thuc'] ?? ''}')),
                                  DataCell(Text('${danhsach[index]['TL_hot'] ?? ''}')),
                                  DataCell(Text('${danhsach[index]['TL_vang'] ?? ''}')),
                                  DataCell(Text('${danhsach[index]['CONG_GOC'] ?? ''}')),
                                  DataCell(Text('${danhsach[index]['GIA_CONG'] ?? ''}')),
                                  DataCell(Text('${''}')),
                                ]
                              );
                            }
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );

  }
}