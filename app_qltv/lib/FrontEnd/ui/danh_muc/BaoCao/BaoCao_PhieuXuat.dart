import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
import '../../../controller/danhmuc/BaoCaoPhieuXuat_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';

class BaoCaoPhieuXuatScreen extends StatefulWidget{
  static const routeName = '/baocaophieuxuat';
  const BaoCaoPhieuXuatScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoPhieuXuat createState() => _BaoCaoPhieuXuat();
}

class _BaoCaoPhieuXuat extends State<BaoCaoPhieuXuatScreen>{
  late Future<List<BaoCaoPhieuXuat_model>> _phieuXuatFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoPhieuXuat_model> _filterPhieuXuatList = [];
  List<BaoCaoPhieuXuat_model> _PhieuXuatList = [];

  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuXuat();
    _searchController.addListener(_filterBaoCaoPhieuXuat);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // --- Phương thức
    //Load dữ liệu
  Future<void> _loadBaoCaoPhieuXuat() async {
    _phieuXuatFuture =
        Provider.of<BaocaophieuxuatManage>(context, listen: false).fetchBaoCaoPhieuXuat();
    _phieuXuatFuture.then((BaoCaos) {
      setState(() {
        _PhieuXuatList = BaoCaos;
        _filterPhieuXuatList = BaoCaos;
      });
    });
  }

    //Lọc dữ liệu
  void _filterBaoCaoPhieuXuat(){
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filterPhieuXuatList = _PhieuXuatList.where((phieuxuat){
        return phieuxuat.HANGHOAMA.toLowerCase().contains(query);
      }).toList();
    });
  }

  //Giao diện
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        title: Row(
          children: [
            Expanded(
              flex: 2,
                child: Text("Báo cáo phiếu xuất", style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Align',fontWeight: FontWeight.bold),)
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                    onPressed: () {
                      print('Chuyển sang phần chuyển đổi PDF');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(1, 3, 1, 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffededed), Color(0xffdee8e8)],
                          stops: [0.25, 0.75],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(4, 8))
                        ],
                      ),
                      child: Center(
                        child: Text(
                            'Export PDF',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ),
            )
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange, Colors.amber])),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Column(children: [
            Search_Bar(searchController: _searchController),
            const SizedBox(height: 12,),
            Expanded(
                child: ShowList(),
            ),
          ],),
        ),
      ),
    );
  }

  FutureBuilder<List<BaoCaoPhieuXuat_model>> ShowList(){
    return FutureBuilder<List<BaoCaoPhieuXuat_model>>(
        future: _phieuXuatFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(fontSize: 10),));
          }else{
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filterPhieuXuatList.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index){
                final baoCao = _filterPhieuXuatList[index];
                return Text("Mã hàng hóa: ${baoCao.HANGHOAMA}");
              }
            );
          }
        }
    );
  }
}