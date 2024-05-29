import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoLoaiVang.dart';
// import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoLoaiVang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoTonKhoLoaiVang_manager.dart';

class Table_BaoCaoTonKhoLoaiVang extends StatefulWidget{
  static const routeName = '/baocaotonkholoaivang';
  const Table_BaoCaoTonKhoLoaiVang({super.key});
  State<Table_BaoCaoTonKhoLoaiVang> createState() => _Table_BaoCaoTonKhoLoaiVang();
}

class _Table_BaoCaoTonKhoLoaiVang extends State<Table_BaoCaoTonKhoLoaiVang>{
  //Thuộc tính
  late List<dynamic> JsonData = [];

  //-------------------
  @override
  void initState() {
    super.initState();
    _LoadBaoCaoTonKhoLoaiVang().then((_){
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //    >>>   Các phương thức   <<<
    //1. Load dữ liệu
  Future<List<dynamic>> _LoadBaoCaoTonKhoLoaiVang() async{
    JsonData = await Provider.of<BaocaotonkholoaivangManager>(context, listen: false).fetchBaoCaoTonKhoTheoLoaiVang();
    return JsonData;
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
      body: FutureBuilder<List<dynamic>>(
        future: _LoadBaoCaoTonKhoLoaiVang(),
        builder: (context ,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }else{
            final jsonData = snapshot.data!;
            return SafeArea(
                child: SingleChildScrollView(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: jsonData.length,
                            itemBuilder: (context, index){
                              final item = JsonData[index];
                              final data = item['data'];
                              final sumary = item['sumary'];
                              return ExpansionTile(
                                title: Text('List'),
                                children: [
                                  ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, dataIndex){
                                        final DataIndex = data[dataIndex];
                                        return Container(
                                          child: Text('${DataIndex['NHOM_TEN']}'),
                                        );
                                      }
                                  ),

                                  Divider(),
                                  ListView.builder(
                                      itemCount: sumary.length,
                                      itemBuilder: (context, sumaryIndex){
                                        final SumaryIndex = sumary[sumaryIndex];
                                        return Container(
                                          child: Text('${SumaryIndex['SoLuong']}'),
                                        );
                                      }
                                  )
                                ],
                              );
                            }
                          ),
                        ],
                      )
                    ],
                  ),
                )
            );
          }
        },
      ),
    );
  }
}