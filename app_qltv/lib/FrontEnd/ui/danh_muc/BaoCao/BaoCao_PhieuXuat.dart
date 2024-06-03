import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
import '../../../controller/danhmuc/BaoCaoPhieuXuat_manage.dart';
import '../../../ui/components/FormatCurrency.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import '../../../Service/export/PDF/BangBaoCaoPhieuXuat_PDF.dart';

class BaoCaoPhieuXuatScreen extends StatefulWidget{
  static const routeName = '/baocaophieuxuat';
  const BaoCaoPhieuXuatScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoPhieuXuat createState() => _BaoCaoPhieuXuat();
}

class _BaoCaoPhieuXuat extends State<BaoCaoPhieuXuatScreen> {
  late Future<List<BaoCaoPhieuXuat_model>> _phieuXuatFuture;
  var thongTinTinhTong;

  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoPhieuXuat_model> _filterPhieuXuatList = [];
  List<BaoCaoPhieuXuat_model> _PhieuXuatList = [];

  double tong_CanTong = 0.0,
      tong_TlHot = 0.0,
      tong_TLvang = 0.0,
      tongThanhTien = 0.0,
      tong_GiaGoc = 0.0,
      tongLaiLo = 0.0;

  @override
  void initState(){
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
        Provider.of<BaocaophieuxuatManage>(context, listen: false)
            .fetchBaoCaoPhieuXuat();
    _phieuXuatFuture.then((BaoCaos) {
      setState(() {
        _PhieuXuatList = BaoCaos;
        _filterPhieuXuatList = BaoCaos;
      });

      //Xu ly tinh toan
      for (int i = 0; i < _filterPhieuXuatList.length; i++) {
        final item = _filterPhieuXuatList[i];
        tong_CanTong += item.CAN_TONG ;
        tong_TLvang += item.TL_Vang;
        tong_TlHot += item.TL_HOT ;
        tong_GiaGoc += item.GiaGoc;
        tongThanhTien += item.THANH_TIEN;
        tongLaiLo += (item.THANH_TIEN - item.GiaGoc);
      }
    });
  }

  //Lọc dữ liệu
  void _filterBaoCaoPhieuXuat() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filterPhieuXuatList = _PhieuXuatList.where((phieuxuat) {
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
                child: Text("Báo cáo phiếu xuất", style: TextStyle(fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'Align',
                    fontWeight: FontWeight.bold),)
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  print('Chuyển sang phần chuyển đổi PDF');

                  //Lưu thông tin tinh tong
                  thongTinTinhTong = {
                    "Tong_CanTong": tong_CanTong,
                    "Tong_TLvang": tong_TLvang,
                    "Tong_TlHot": tong_TlHot,
                    "Tong_GiaGoc": tong_GiaGoc,
                    "TongThanhTien": tongThanhTien,
                    "TongLaiLo": tongLaiLo,
                  };

                  printDoc(_filterPhieuXuatList,thongTinTinhTong);
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

              child: Scrollbar(

                child: ListView(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),

                    child: Column(children: [
                      ShowList(),
                      const SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffbbd2c5), Color(0xff536976)],
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),

                            borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(children: [
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(text: "Tổng cân tổng: ",style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "${formatCurrencyDouble(tong_CanTong)}"),
                            ])
                          ),
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(text: "Tổng TL hột: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "${formatCurrencyDouble(tong_TlHot)}"),
                              ])
                          ),
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(text: "Tổng TL vàng: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "${formatCurrencyDouble(tong_TLvang)}"),
                              ])
                          ),
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(text: "Tổng Thành tiền: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "${formatCurrencyDouble(tongThanhTien)}"),
                              ])
                          ),
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(text: "Tổng giá gốc: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "${formatCurrencyDouble(tong_GiaGoc)}"),
                              ])
                          ),
                          Text.rich(
                              TextSpan(children: [
                                TextSpan(text: "Tổng lãi lỗ: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: "${formatCurrencyDouble(tongLaiLo)}"),
                              ])
                          ),
                        ],),
                      )
                    ],),
                  ),
                ],),
              ),
            ),
          ],),
        ),
      ),
    );
  }

  //Giao diện báo cáo
  FutureBuilder<List<BaoCaoPhieuXuat_model>> ShowList() {
    return FutureBuilder<List<BaoCaoPhieuXuat_model>>(
        future: _phieuXuatFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(
              'Error: ${snapshot.error}', style: TextStyle(fontSize: 10),));
          } else {
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filterPhieuXuatList.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  final baoCao = _filterPhieuXuatList[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffe65c00), Color(0xfff9d423)],
                        stops: [0, 1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                              flex: 2,
                              child: Column(children: [
                                Text('Mã: ${baoCao.PHIEU_XUAT_MA} ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,),
                                Text('Mã hàng hóa: ${baoCao.HANGHOAMA} ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,),
                                Text('Tên hàng hóa: ${baoCao.HANG_HOA_TEN}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,),
                              ],)
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  print('nút chi tiết');
                                  ThongTinChiTiet(context, baoCao);
                                },
                                icon: Icon(Icons.info_outline, size: 30,),
                              )
                          )
                        ],),

                        const SizedBox(height: 15,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith((
                                  states) => Colors.black87),
                              //dataRowColor: ,
                              columns: [
                                DataColumn(label: Text('Đơn giá',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),)),
                                DataColumn(label: Text('Thành tiền',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),)),
                                DataColumn(label: Text('Giá gốc',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),)),
                                DataColumn(label: Text('Lãi lỗi',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.white),)),
                              ],
                              rows: [
                                DataRow(
                                    cells: [
                                      DataCell(Text('${formatCurrencyDouble(
                                          baoCao.DON_GIA)}')),
                                      DataCell(Text('${formatCurrencyDouble(
                                          baoCao.THANH_TIEN)}')),
                                      DataCell(Text('${formatCurrencyDouble(
                                          baoCao.GiaGoc)}')),
                                      DataCell(Text('${formatCurrencyDouble(
                                          baoCao.LaiLo)}')),
                                    ],
                                    color: MaterialStateColor.resolveWith((
                                        states) => Colors.white)
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
        }
    );
  }

  //Hiển thị thông tin chi tiết
  Future<void> ThongTinChiTiet(BuildContext context, BaoCaoPhieuXuat_model item){
    return showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: Container(
              child: Text('Thông tin chi tiết',style: TextStyle(decoration: TextDecoration.underline),),
            ),
            content: FractionallySizedBox(
              heightFactor: 0.6,
              child: Scrollbar(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text:'Mã: ',style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text:' ${item.PHIEU_XUAT_MA}'),
                          ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Mã hàng hóa: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${item.HANGHOAMA}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Tên hàng hóa: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${item.HANG_HOA_TEN}'),
                            ])
                        ),

                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Loại vàng: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${item.LOAIVANG}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Cân tổng: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.CAN_TONG)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'TL hột: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.TL_HOT)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'TL vàng: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.TL_Vang)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Ngày xuất: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${item.NGAY_XUAT}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Đơn giá: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.DON_GIA)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Thành tiền: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.THANH_TIEN)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Giá gốc: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.GiaGoc)}'),
                            ])
                        ),
                        Text.rich(
                            TextSpan(children: [
                              TextSpan(text:'Lãi lỗ: ',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:' ${formatCurrencyDouble(item.LaiLo)}'),
                            ])
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(children: [
                Flexible(
                    child: ListTile(
                      leading: Icon(Icons.print),
                      title: Text('In'),
                      onTap: (){
                        print('in phiếu xuất');
                      },
                    )
                ),
                Flexible(
                    child: ListTile(
                      leading: Icon(Icons.close,color: Colors.red,),
                      title: Text('Đóng', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 12),),
                      onTap: () => Navigator.of(context).pop(),
                    )
                ),
              ],),
            ],
          );
        },
    );
  }

  //Chuyển sang phần xuất file PDF Dang bảng
  Future<void> printDoc(List<BaoCaoPhieuXuat_model> data, Map<String, dynamic> GetThongTinTinhTong) async{
    final font = await loadFont('assets/fonts/Roboto-Regular.ttf');
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context){
          return buildPrintableData(data,font ,GetThongTinTinhTong);
        }
      )
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}