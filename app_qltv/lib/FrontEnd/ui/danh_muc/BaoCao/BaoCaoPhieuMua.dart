import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoPhieuMua_maneger.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:intl/intl.dart'; // Để định dạng ngày

class BaoCaoPhieuMuaScreen extends StatefulWidget {
  static const routeName = "/baocaophieumua";

  const BaoCaoPhieuMuaScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoPhieuMuaScreenState createState() => _BaoCaoPhieuMuaScreenState();
}

class _BaoCaoPhieuMuaScreenState extends State<BaoCaoPhieuMuaScreen> {
  late Future<List<BaoCaoPhieuMua>> _BaoCaoPhieuMuaFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoPhieuMua> _filteredBaoCaoPhieuMuaList = [];
  List<BaoCaoPhieuMua> _BaoCaoPhieuMuaList = [];

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuMua();
    _searchController.addListener(_filterBaoCaoPhieuMua);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoPhieuMua() async {
    _BaoCaoPhieuMuaFuture =
        Provider.of<BaocaophieumuaManeger>(context, listen: false)
            .fecthbaoCaoPhieuMua();
    _BaoCaoPhieuMuaFuture.then((baoCaoPhieuMua) {
      setState(() {
        _BaoCaoPhieuMuaList = baoCaoPhieuMua;
        _filteredBaoCaoPhieuMuaList = baoCaoPhieuMua;
      });
    });
  }

  void _filterBaoCaoPhieuMua() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBaoCaoPhieuMuaList = _BaoCaoPhieuMuaList.where((phieumua) {
        final inDateRange = (_startDate == null || _endDate == null) ||
            (phieumua.ngayPhieu != null &&
                DateTime.parse(phieumua.ngayPhieu!).isAfter(_startDate!.subtract(Duration(days: 1))) &&
                DateTime.parse(phieumua.ngayPhieu!).isBefore(_endDate!.add(Duration(days: 1))));
        final matchesQuery = phieumua.hangHoaTen!.toLowerCase().contains(query);

        return inDateRange && matchesQuery;
      }).toList();
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _filterBaoCaoPhieuMua();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 228, 200, 126),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Báo Cáo Phiếu Mua",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _startDate == null
                          ? 'Chọn ngày bắt đầu'
                          : DateFormat('dd/MM/yyyy').format(_startDate!),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _endDate == null
                          ? 'Chọn ngày kết thúc'
                          : DateFormat('dd/MM/yyyy').format(_endDate!),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _selectDateRange(context);
                    },
                  ),
                ],
              ),
              Search_Bar(searchController: _searchController),
              const SizedBox(height: 12.0),
              Expanded(
                child: ShowList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<BaoCaoPhieuMua>> ShowList() {
    return FutureBuilder<List<BaoCaoPhieuMua>>(
      future: _BaoCaoPhieuMuaFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredBaoCaoPhieuMuaList.length,
            itemBuilder: (context, index) {
              final phieumua = _filteredBaoCaoPhieuMuaList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        phieumua.hangHoaTen!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      tilePadding:
                          const EdgeInsets.only(left: 20, top: 5, bottom: 0),
                      backgroundColor: Colors.transparent,
                      childrenPadding: const EdgeInsets.only(
                          left: 20, top: 0, bottom: 10, right: 20),
                      children: [
                        const SizedBox(height: 10),
                        tableItem(phieumua),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Table tableItem(BaoCaoPhieuMua phieu) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Số Phiếu',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tên Hàng Hóa',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Nhóm Vàng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.phieuMa!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.hangHoaTen!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.nhomTen!),
              ),
            ),
          ],
        ),
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Cân Tổng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Hột',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Thực',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.canTong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.tlHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.tlThuc ?? 0)),
              ),
            ),
          ],
        ),
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Ngày',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Đơn Giá',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thành tiền',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.ngayPhieu!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.donGia ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.thanhTien ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// // // import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:intl/intl.dart';

// // // import '../../../model/danhmuc/BaoCaoPhieuMua.dart';
// // // import '../../../controller/danhmuc/BaoCaoPhieuMua_maneger.dart';
// // // import '../../../ui/components/FormatCurrency.dart';
// // // import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/pdf.dart';
// // import 'package:printing/printing.dart';

// // import '../../../model/danhmuc/BaoCaoPhieuMua.dart';
// // import '../../../controller/danhmuc/BaoCaoPhieuMua_maneger.dart';
// // import '../../../ui/components/FormatCurrency.dart';
// // import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
// // import '../../../Service/export/PDF/BangBaoCaoPhieuMua_PDF..dart';
// // import '../../../Service/export/PDF/PhieuMua_PDF.dart';

// // class BaoCaoPhieuMuaScreen extends StatefulWidget{
// //   static const routeName = '/baocaophieumua';
// //   const BaoCaoPhieuMuaScreen({Key? key}) : super(key: key);

// //   @override
// //   _BaoCaoPhieuMua createState() => _BaoCaoPhieuMua();
// // }

// // class _BaoCaoPhieuMua extends State<BaoCaoPhieuMuaScreen> {

// //   //Thuộc tính
// //   late Future<List<BangBaoCaoPhieuMua_model>> _bangBaoCaoPhieuMuaFuture;
// //   final TextEditingController _searchController = TextEditingController();
// //   List<BangBaoCaoPhieuMua_model> _filterPhieuMuaList = [];
// //   List<BangBaoCaoPhieuMua_model> _PhieuMuaList = [];


// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadBaoCaoPhieuMua();
// //     _searchController.addListener(_filterBaoCaoPhieuMua);
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   //--- Ghi phuương thức --------
// //     //1.Load dữ liệu
// //   Future<void> _loadBaoCaoPhieuMua() async {
// //     _bangBaoCaoPhieuMuaFuture =
// //         Provider.of<BaocaophieumuaManage>(context, listen: false)
// //             .LayDuLieuPhieuMua_test();
// //     _bangBaoCaoPhieuMuaFuture.then((BaoCaos) {
// //       setState(() {
// //         _PhieuMuaList = BaoCaos;
// //         _filterPhieuMuaList = BaoCaos;
// //       });
// //     });
// //   }

// //     //2.Lọc dữ liệu
// //   void _filterBaoCaoPhieuMua() {
// //     final query = _searchController.text.toLowerCase();
// //     setState(() {
// //       _filterPhieuMuaList = _PhieuMuaList.where((phieumua) {
// //         return phieumua.MaPhieuMua.toLowerCase().contains(query);
// //       }).toList();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: IconThemeData(
// //           color: Colors.white,
// //           size: 28,
// //         ),
// //         title: Text("Báo cáo phiếu xuất", style: TextStyle(fontSize: 17,
// //                     color: Colors.white,
// //                     fontFamily: 'Align',
// //                     fontWeight: FontWeight.bold),),
// //         flexibleSpace: Container(
// //           decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                   colors: [Colors.orange, Colors.amber])),
// //         ),
// //         actions: [
// //           PopupMenuButton<String>(
// //             icon: Icon(Icons.more_vert_sharp),
// //             itemBuilder: (BuildContext context){
// //               return<PopupMenuEntry<String>>[
// //                 PopupMenuItem<String>(
// //                     child:TextButton(
// //                       onPressed: () {
// //                         print('Chuyen sang PDF');
// //                       },
// //                       child: Text('Export PDF'),
// //                     ),
// //                 ),
// //               ];
// //             }
// //           ),
// //         ],
// //       ),
// //             body: SafeArea(
// //         child: Container(
// //           padding: EdgeInsets.fromLTRB(10, 15, 10, 0),

// //           child: Column(children: [

// //             Search_Bar(searchController: _searchController),
// //             const SizedBox(height: 12,),
// //             Expanded(
// //               child: Scrollbar(
// //                 child: ListView(children: [
// //                   Column(children: [
// //                     ShowList(),
// //                   ],)
// //                 ],),
// //               ),
// //             ),
// //           ],),
// //         ),
// //       ),
// //     );
// //   }

// //   //Thông tin từng phiếu báo cáo
// //   FutureBuilder<List<BangBaoCaoPhieuMua_model>> ShowList() {
// //     return FutureBuilder<List<BangBaoCaoPhieuMua_model>>(
// //         future: _bangBaoCaoPhieuMuaFuture,
// //         builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (snapshot.hasError) {
// //               return Center(child: Text(
// //                 'Error: ${snapshot.error}', style: TextStyle(fontSize: 10),));
// //             }else{
// //               return ListView.builder(
// //                 shrinkWrap: true,
// //                 physics: NeverScrollableScrollPhysics(),
// //                 reverse: true,
// //                 itemCount: _filterPhieuMuaList.length,
// //                 itemBuilder: (_, index){
// //                   final BaoCao = _filterPhieuMuaList[index];
// //                   return Container(
// //                     margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
// //                     padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
// //                     decoration: BoxDecoration(
// //                       gradient: LinearGradient(
// //                         colors: [Color(0xffe65c00), Color(0xfff9d423)],
// //                         stops: [0, 1],
// //                         begin: Alignment.topLeft,
// //                         end: Alignment.bottomRight,
// //                       ),
// //                       borderRadius: BorderRadius.circular(10),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.grey.withOpacity(0.5),
// //                           spreadRadius: 2,
// //                           blurRadius: 5,
// //                           offset: Offset(0, 3),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Column(children: [

// //                       //Tieu de
// //                       Align(
// //                         alignment: Alignment.centerLeft,
// //                         child: Row(children: [
// //                           FittedBox(
// //                             fit: BoxFit.fitWidth,
// //                             child: Text("Phiếu xuất mã: ${BaoCao.MaPhieuMua}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
// //                           ),
// //                           const SizedBox(width: 25,),
// //                           IconButton(
// //                               onPressed: (){
// //                                 print('${BaoCao.PhieuMua}');
// //                                 //ThongTinChiTiet(context, BaoCao.PhieuMua[index]);
// //                               },
// //                               icon: Icon(Icons.info_outline, size: 30,)
// //                           ),

// //                         ],)
// //                       ),

// //                       const SizedBox(height: 15,),

// //                       //Liêt kê hàng hóa trong từng phiếu xuất
// //                       SingleChildScrollView(
// //                           scrollDirection: Axis.horizontal,
// //                           child: DataTable(
// //                               headingRowColor: MaterialStateColor.resolveWith((
// //                                      states) => Colors.black87),
// //                               columns: [
// //                                 DataColumn(label: Text('Hàng hóa',
// //                                   style: TextStyle(fontWeight: FontWeight.bold,
// //                                       color: Colors.white),)),
// //                                   DataColumn(label: Text('Đơn giá',
// //                                     style: TextStyle(fontWeight: FontWeight.bold,
// //                                         color: Colors.white),)),
// //                                   DataColumn(label: Text('Thành tiền',
// //                                     style: TextStyle(fontWeight: FontWeight.bold,
// //                                         color: Colors.white),)),
                                 
// //                                 ],
// //                               rows: [
// //                                 ...BaoCao.PhieuMua.map((hanghoa) {
// //                                   return  DataRow(
// //                                       cells: [
// //                                         DataCell(Text('${hanghoa.ten_hang_hoa}')),
// //                                         DataCell(Text('${formatCurrencyDouble(
// //                                             hanghoa.don_gia)}')),
// //                                         DataCell(Text('${formatCurrencyDouble(
// //                                             hanghoa.thanh_tien)}')),
                                        
// //                                       ],
// //                                       color: MaterialStateColor.resolveWith((
// //                                           states) => Colors.white)
// //                                   );
// //                                 }),
// //                               ]
// //                           ),
// //                         )
// //                     ],),
// //                   );
// //                 },
// //               );
// //             }
// //         }
// //     );
// //   }

// // //   //Hiển thị thông tin chi tiết
// //   Future<void> ThongTinChiTiet(BuildContext context, BaoCaoPhieuMua item){
// //     return showDialog(
// //         context: context,
// //         builder: (BuildContext context){
// //           return AlertDialog(
// //             title: Container(
// //               child: Text('Thông tin chi tiết',style: TextStyle(decoration: TextDecoration.underline),),
// //             ),
// //             content: FractionallySizedBox(
// //               heightFactor: 0.6,
// //               child: Scrollbar(
// //                 child: ListView(
// //                   children: [
// //                     Column(
// //                       children: [
// //                         Text.rich(
// //                           TextSpan(children: [
// //                             TextSpan(text:'Mã: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                             TextSpan(text:' ${item.phieu_ma}'),
// //                           ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Mã hàng hóa: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${item.ma_hang_hoa}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Tên hàng hóa: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${item.ten_hang_hoa}'),
// //                             ])
// //                         ),

// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Loại vàng: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${item.nhom_ten}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Cân tổng: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${formatCurrencyDouble(item.can_tong)}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'TL hột: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${formatCurrencyDouble(item.tl_hot)}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'TL thực: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${formatCurrencyDouble(item.tl_thuc)}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Ngày: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${item.ngay_phieu}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Đơn giá: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${formatCurrencyDouble(item.don_gia)}'),
// //                             ])
// //                         ),
// //                         Text.rich(
// //                             TextSpan(children: [
// //                               TextSpan(text:'Thành tiền: ',style: TextStyle(fontWeight: FontWeight.bold)),
// //                               TextSpan(text:' ${formatCurrencyDouble(item.thanh_tien)}'),
// //                             ])
// //                         ),
                       
                        
                        
// //                       ],
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             actions: <Widget>[
// //               Row(children: [
// //                 Flexible(
// //                     child: ListTile(
// //                       leading: Icon(Icons.print),
// //                       title: Text('In'),
// //                       onTap: (){
// //                         print('in phiếu xuất');
// //                         //printInvoice(item);
// //                       },
// //                     )
// //                 ),
// //                 Flexible(
// //                     child: ListTile(
// //                       leading: Icon(Icons.close,color: Colors.red,),
// //                       title: Text('Đóng', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 12),),
// //                       onTap: () => Navigator.of(context).pop(),
// //                     )
// //                 ),
// //               ],),
// //             ],
// //           );
// //         },
// //     );
// //   }

// // }
// // // class BaoCaoPhieuMuaScreen extends StatefulWidget {
// // //   static const routeName = '/baocaophieumua';
// // //   const BaoCaoPhieuMuaScreen({Key? key}) : super(key: key);

// // //   @override
// // //   _BaoCaoPhieuMua createState() => _BaoCaoPhieuMua();
// // // }

// // // class _BaoCaoPhieuMua extends State<BaoCaoPhieuMuaScreen> {
// // //   // Thuộc tính
// // //   late Future<List<BangBaoCaoPhieuMua_model>> _bangBaoCaoPhieuMuaFuture;
// // //   final TextEditingController _searchController = TextEditingController();
// // //   List<BangBaoCaoPhieuMua_model> _filterPhieuMuaList = [];
// // //   List<BangBaoCaoPhieuMua_model> _PhieuMuaList = [];
// // //   DateTime? _selectedStartDate;
// // //   DateTime? _selectedEndDate;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadBaoCaoPhieuMua();
// // //     _searchController.addListener(_filterBaoCaoPhieuMua);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _searchController.dispose();
// // //     super.dispose();
// // //   }

// // //   // 1. Load dữ liệu
// // //   Future<void> _loadBaoCaoPhieuMua() async {
// // //     _bangBaoCaoPhieuMuaFuture =
// // //         Provider.of<BaocaophieumuaManage>(context, listen: false)
// // //             .LayDuLieuPhieuMua_test();
// // //     _bangBaoCaoPhieuMuaFuture.then((BaoCaos) {
// // //       setState(() {
// // //         _PhieuMuaList = BaoCaos;
// // //         _filterPhieuMuaList = BaoCaos;
// // //       });
// // //     });
// // //   }

// // //   // 2. Lọc dữ liệu
// // //   void _filterBaoCaoPhieuMua() {
// // //     final query = _searchController.text.toLowerCase();
// // //     setState(() {
// // //       _filterPhieuMuaList = _PhieuMuaList.where((phieumua) {
// // //         return phieumua.MaPhieuMua.toLowerCase().contains(query);
// // //       }).toList();
// // //     });
// // //   }

// // //   // 3. Tìm kiếm dựa trên ngày
// // //   void _searchByDate() {
// // //     if (_selectedStartDate == null || _selectedEndDate == null) {
// // //       return;
// // //     }

// // //     setState(() {
// // //       _filterPhieuMuaList = _PhieuMuaList.where((phieumua) {
// // //         return phieumua.PhieuMua.any((baoCao) {
// // //           final phieuDate = DateTime.parse(baoCao.ngay_phieu);
// // //           return phieuDate
// // //                   .isAfter(_selectedStartDate!.subtract(Duration(days: 1))) &&
// // //               phieuDate.isBefore(_selectedEndDate!.add(Duration(days: 1)));
// // //         });
// // //       }).toList();
// // //     });
// // //   }

// // //   Future<void> _selectStartDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedStartDate ?? DateTime.now(),
// // //       firstDate: DateTime(2015, 8),
// // //       lastDate: DateTime(2101),
// // //     );
// // //     if (picked != null && picked != _selectedStartDate) {
// // //       setState(() {
// // //         _selectedStartDate = picked;
// // //       });
// // //     }
// // //   }

// // //   Future<void> _selectEndDate(BuildContext context) async {
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedEndDate ?? DateTime.now(),
// // //       firstDate: DateTime(2015, 8),
// // //       lastDate: DateTime(2101),
// // //     );
// // //     if (picked != null && picked != _selectedEndDate) {
// // //       setState(() {
// // //         _selectedEndDate = picked;
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         iconTheme: IconThemeData(
// // //           color: Colors.white,
// // //           size: 28,
// // //         ),
// // //         title: Text(
// // //           "Báo cáo phiếu mua",
// // //           style: TextStyle(
// // //               fontSize: 17,
// // //               color: Colors.white,
// // //               fontFamily: 'Align',
// // //               fontWeight: FontWeight.bold),
// // //         ),
// // //         flexibleSpace: Container(
// // //           decoration: BoxDecoration(
// // //               gradient: LinearGradient(
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                   colors: [Colors.orange, Colors.amber])),
// // //         ),
// // //         actions: [
// // //           PopupMenuButton<String>(
// // //               icon: Icon(Icons.more_vert_sharp),
// // //               itemBuilder: (BuildContext context) {
// // //                 return <PopupMenuEntry<String>>[
// // //                   PopupMenuItem<String>(
// // //                     child: TextButton(
// // //                       onPressed: () {
// // //                         print('Chuyển sang PDF');
// // //                       },
// // //                       child: Text('Export PDF'),
// // //                     ),
// // //                   ),
// // //                 ];
// // //               }),
// // //         ],
// // //       ),
// // //       body: SafeArea(
// // //         child: Container(
// // //           padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
// // //           child: Column(
// // //             children: [
// // //               Row(
// // //                 children: [
// // //                   ElevatedButton(
// // //                     onPressed: () {
// // //                       _selectStartDate(context);
// // //                     },
// // //                     child: Text(_selectedStartDate != null
// // //                         ? 'Ngày bắt đầu: ${DateFormat('dd/MM/yyyy').format(_selectedStartDate!)}'
// // //                         : 'Chọn ngày bắt đầu'),
// // //                   ),
// // //                   SizedBox(width: 10),
                 
                 
// // //                 ],
// // //               ),
// // //               Row(children: [
// // //                 ElevatedButton(
// // //                     onPressed: () {
// // //                       _selectEndDate(context);
// // //                     },
// // //                     child: Text(_selectedEndDate != null
// // //                         ? 'Ngày kết thúc: ${DateFormat('dd/MM/yyyy').format(_selectedEndDate!)}'
// // //                         : 'Chọn ngày kết thúc'),
// // //                   ),
// // //                   SizedBox(width: 10),
// // //               ],),
// // //               Row(children:[
// // //                  ElevatedButton(
// // //                     onPressed: () {
// // //                       _searchByDate();
// // //                     },
// // //                     child: Text('Tìm kiếm'),
// // //                   ),
// // //               ],),
// // //               Search_Bar(searchController: _searchController),
// // //               SizedBox(height: 12),
// // //               Expanded(
// // //                 child: Scrollbar(
// // //                   child: ListView(
// // //                     children: [
// // //                       Column(
// // //                         children: [
// // //                           ShowList(),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // Thông tin từng phiếu báo cáo
// // //   FutureBuilder<List<BangBaoCaoPhieuMua_model>> ShowList() {
// // //     return FutureBuilder<List<BangBaoCaoPhieuMua_model>>(
// // //       future: _bangBaoCaoPhieuMuaFuture,
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         } else if (snapshot.hasError) {
// // //           return Center(
// // //               child: Text(
// // //             'Error: ${snapshot.error}',
// // //             style: TextStyle(fontSize: 10),
// // //           ));
// // //         } else {
// // //           return ListView.builder(
// // //             shrinkWrap: true,
// // //             physics: NeverScrollableScrollPhysics(),
// // //             reverse: true,
// // //             itemCount: _filterPhieuMuaList.length,
// // //             itemBuilder: (_, index) {
// // //               final BaoCao = _filterPhieuMuaList[index];
// // //               return Container(
// // //                 margin: EdgeInsets.only(bottom: 15),
// // //                 decoration: BoxDecoration(
// // //                   gradient: LinearGradient(
// // //                       begin: Alignment.centerLeft,
// // //                       end: Alignment.centerRight,
// // //                       colors: [Colors.lightBlue, Colors.blueAccent]),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Color(0x54000000),
// // //                       offset: Offset(0, 4),
// // //                       blurRadius: 4,
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Column(
// // //                   children: [
// // //                     Container(
// // //                       padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
// // //                       child: Row(
// // //                         mainAxisAlignment: MainAxisAlignment.start,
// // //                         children: [
// // //                           Text(
// // //                             BaoCao.MaPhieuMua,
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           ),
// // //                           SizedBox(
// // //                             width: 5,
// // //                           ),
// // //                           Icon(
// // //                             Icons.online_prediction_sharp,
// // //                             size: 17,
// // //                             color: Colors.greenAccent,
// // //                           ),
// // //                           Spacer(),
// // //                           Text(
// // //                             'Ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(BaoCao.PhieuMua.first.ngay_phieu))}',
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     Container(
// // //                       child: DataTable(
// // //                         columns: [
// // //                           DataColumn(
// // //                               label: Text(
// // //                             'Hàng hóa',
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           )),
// // //                           DataColumn(
// // //                               label: Text(
// // //                             'Nhóm hàng',
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           )),
// // //                           DataColumn(
// // //                               label: Text(
// // //                             'Đơn giá',
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           )),
// // //                           DataColumn(
// // //                               label: Text(
// // //                             'Thành tiền',
// // //                             style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white),
// // //                           )),
// // //                         ],
// // //                         rows: [
// // //                           ...BaoCao.PhieuMua.map((hanghoa) {
// // //                             return DataRow(
// // //                                 cells: [
// // //                                   DataCell(Text('${hanghoa.ten_hang_hoa}')),
// // //                                   DataCell(Text('${hanghoa.nhom_ten}')),
// // //                                   DataCell(Text(
// // //                                       '${formatCurrencyDouble(hanghoa.don_gia)}')),
// // //                                   DataCell(Text(
// // //                                       '${formatCurrencyDouble(hanghoa.thanh_tien)}')),
// // //                                 ],
// // //                                 color: MaterialStateColor.resolveWith(
// // //                                     (states) => Colors.white));
// // //                           }),
// // //                         ],
// // //                       ),
// // //                     )
// // //                   ],
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         }
// // //       },
// // //     );
// // //   }

// // //   // Hiển thị thông tin chi tiết
// // //   Future<void> ThongTinChiTiet(BuildContext context, BaoCaoPhieuMua item) {
// // //     return showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: Container(
// // //             child: Text(
// // //               'Thông tin chi tiết',
// // //               style: TextStyle(decoration: TextDecoration.underline),
// // //             ),
// // //           ),
// // //           content: FractionallySizedBox(
// // //             heightFactor: 0.6,
// // //             child: Scrollbar(
// // //               child: ListView(
// // //                 children: [
// // //                   Column(
// // //                     children: [
// // //                       Text.rich(TextSpan(children: [
// // //                         TextSpan(
// // //                             text: 'Mã: ',
// // //                             style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         TextSpan(text: ' ${item.phieu_ma}'),
// // //                       ])),
// // //                       Text.rich(TextSpan(children: [
// // //                         TextSpan(
// // //                             text: 'Nhóm hàng hóa: ',
// // //                             style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         TextSpan(text: ' ${item.nhom_ten}'),
// // //                       ])),
// // //                       // Các thông tin khác
// // //                     ],
// // //                   )
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //           actions: <Widget>[
// // //             Row(
// // //               children: [
// // //                 Flexible(
// // //                     child: ListTile(
// // //                   leading: Icon(Icons.print),
// // //                   title: Text('In'),
// // //                   onTap: () {
// // //                     print('in phiếu mua');
// // //                     //printInvoice(item);
// // //                   },
// // //                 )),
// // //                 Flexible(
// // //                     child: ListTile(
// // //                   leading: Icon(
// // //                     Icons.close,
// // //                     color: Colors.red,
// // //                   ),
// // //                   title: Text(
// // //                     'Đóng',
// // //                     style: TextStyle(
// // //                         color: Colors.red,
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 12),
// // //                   ),
// // //                   onTap: () => Navigator.of(context).pop(),
// // //                 )),
// // //               ],
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// import 'package:app_qltv/FrontEnd/Service/export/PDF/PhieuMua_PDF.dart';
// import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoPhieuMua_maneger.dart';
// import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
// import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/BaoCao/BaoCaoPhieuMua.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';
// import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
// import 'package:pdf/widgets.dart' as pw;

// class BaoCaoPhieuMuaScreen extends StatefulWidget {
//   static const routeName = "/baocaophieumua";

//   const BaoCaoPhieuMuaScreen({Key? key}) : super(key: key);

//   @override
//   _BaoCaoPhieuMuaScreenState createState() =>
//       _BaoCaoPhieuMuaScreenState();
// }

// class _BaoCaoPhieuMuaScreenState
//     extends State<BaoCaoPhieuMuaScreen> {
//   late Future<List<BaoCaoPhieuMua>> _baoCaoTonKhoLoaiVangFuture;
//   final TextEditingController _searchController = TextEditingController();
//   List<BaoCaoPhieuMua> _filteredBaoCaoPhieuMuaList = [];
//   List<BaoCaoPhieuMua> _baoCaoPhieuMuaList = [];
//   late Map<String, double> _summary;
//   late Map<String, double> _percentage;
//   // ignore: unused_field
//   String _selectedItem = '';

//   @override
//   void initState() {
//     super.initState();
//     _summary = {
//       'tongTLThuc': 0.0,
//       'tongTLHot': 0.0,
//       'tongTLVang': 0.0,
//       'tongThanhTien': 0.0
//     };
//     _loadBaoCaoPhieuMua();
//     // _searchController.addListener(_filterBaoCaoPhieuMua);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadBaoCaoPhieuMua() async {
//     _baoCaoTonKhoLoaiVangFuture =
//         Provider.of<BaocaophieumuaManeger>(context, listen: false)
//             .fecthbaoCaoPhieuMua();
//     _baoCaoTonKhoLoaiVangFuture.then((baoCao) {
//       setState(() {
//         _baoCaoPhieuMuaList = baoCao;
//         _filteredBaoCaoPhieuMuaList = baoCao;
//         _calculateSummary();
//       });
//     });
//   }

//   // void _filterBaoCaoPhieuMua() {
//   //   final query = _searchController.text.toLowerCase();
//   //   setState(() {
//   //     _filteredBaoCaoPhieuMuaList =
//   //         _baoCaoPhieuMuaList.where((baoCao) {
//   //       return baoCao.data.any((loaiVangTonKho) =>
//   //           loaiVangTonKho.hangHoaTen?.toLowerCase().contains(query) ?? false);
//   //     }).toList();
//   //   });
//   // }

//   void _calculateSummary() {
//     double tongTLThuc = 0.0;
//     double tongTLHot = 0.0;
//     double tongTLVang = 0.0;
//     double tongThanhTien = 0.0;

//     for (BaoCaoPhieuMua baoCao in _baoCaoPhieuMuaList) {
//       tongTLThuc += baoCao.tLThuc!;
//       tongTLHot += baoCao.tLHot!;
//       tongTLVang += baoCao.canTong!;
//       tongThanhTien += baoCao.thanhTien!;
//     }

//     _summary = {
//       'tongTLThuc': tongTLThuc,
//       'tongTLHot': tongTLHot,
//       'tongTLVang': tongTLVang,
//       'tongThanhTien': tongThanhTien,
//     };
//   }

//   void _onOptionSelected(String option) {
//     setState(() {
//       _selectedItem = option;
//     });
//     // Gọi hàm tùy chọn khi chọn một tùy chọn
//     // switch (option) {
//     //   case 'Export':
//     //     _handleExport(_baoCaoPhieuMuaList);
//     //     break;
//     //   case 'QuyDoi':
//     //     _handleQuyDoi();
//     //     break;
//     //   case 'ThongKe':
//     //     _handleThongKe();
//     //     break;
//     // }
//   }

//   void _calculatePercentage() {
//     // Khởi tạo một map để lưu trữ tổng trọng lượng của mỗi nhóm
//     Map<String, double> totalWeightByGroup = {};
//     double totalWeightAllGroups = 0;
//     // Tính tổng trọng lượng của mỗi nhóm
//     for (BaoCaoPhieuMua baoCao in _baoCaoPhieuMuaList) {
//       String nhomTen = baoCao.tenNhomHang!;
//       double trongLuong = baoCao.thanhTien ?? 0.0;
//       // Thêm trọng lượng vào tổng của nhóm
//       totalWeightByGroup[nhomTen] =
//           (totalWeightByGroup[nhomTen] ?? 0.0) + trongLuong;
//       totalWeightAllGroups += baoCao.thanhTien!;
//       // In ra giá trị để kiểm tra
//       print('Nhóm: $nhomTen, Trọng lượng: $trongLuong');
//     }
//     // In ra tổng trọng lượng của tất cả các nhóm
//     print('Tổng trọng lượng tất cả các nhóm: $totalWeightAllGroups');
//     // Tính phần trăm cho mỗi nhóm
//     Map<String, double> percentageByGroup = {};
//     totalWeightByGroup.forEach((nhomTen, totalWeight) {
//       double percentage = totalWeight / totalWeightAllGroups * 100;
//       percentageByGroup[nhomTen] = percentage;
//       print(
//           'Nhóm: $nhomTen, Tổng trọng lượng: $totalWeight, Phần trăm: $percentage');
//     });

//     // Gán kết quả vào _percentage
//     setState(() {
//       _percentage = percentageByGroup;
//     });
//   }

//   // Future<void> _handleExport(
//   //     List<BaoCaoPhieuMua> baoCaoTonKhoLoaiVangList async {
//   //   final doc = pw.Document();
//   //   final font = await loadFontPhieuMua("assets/fonts/Roboto-Regular.ttf");
//   //   doc.addPage(pw.Page(
//   //       pageFormat: PdfPageFormat.a4,
//   //       build: (pw.Context context) {
//   //         return buildPrintablePhieuMua(
//   //             _baoCaoPhieuMuaList, font, _summary);
//   //       }));
//   //   await Printing.layoutPdf(
//   //       onLayout: (PdfPageFormat format) async => doc.save());
//   // }

//   // void _handleQuyDoi() {
//   //   print('Option 2 selected');
//   //   // Thực hiện các hành động khác cho Option 2 ở đây
//   // }

//   // void _handleThongKe() {
//   //   print('Option 3 selected');
//   //   _calculatePercentage();
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return PieChartDialog(_percentage);
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 228, 200, 126),
//         leading: IconButton(
//           icon: const Icon(
//             CupertinoIcons.left_chevron,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title:  const FittedBox(
//           fit: BoxFit.fitWidth,
//           child: Text("Báo Cáo Phiếu Mua",
//               style: TextStyle(
//                   color: Colors.black, fontWeight: FontWeight.w900)),
//         ),
//         actions: [
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert),
//             onSelected: _onOptionSelected,
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuEntry<String>>[
//                 const PopupMenuItem<String>(
//                   value: 'Export',
//                   child: Center(child: Text('Export')),
//                 ),
//                 const PopupMenuItem<String>(
//                   value: 'QuyDoi',
//                   child: Center(child: Text('Quy Đổi')),
//                 ),
//                 const PopupMenuItem<String>(
//                   value: 'ThongKe',
//                   child: Center(child: Text('Thống Kê')),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Search_Bar(searchController: _searchController),
//               const SizedBox(height: 12.0),
//               Expanded(
//                 child: ShowList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15.0),
//                     topRight: Radius.circular(15.0),
//                   ),
//                   color: Color.fromARGB(255, 228, 200, 126),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       const Text('Tổng Quan',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w800, fontSize: 20)),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: tableTotal(_summary),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         backgroundColor: Colors.white,
//         tooltip: 'Show Bottom Sheet',
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset('assets/images/list.png'),
//         ),
//       ),
//     );
//   }

//   // ignore: non_constant_identifier_names
//   FutureBuilder<List<BaoCaoPhieuMua>> ShowList() {
//     return FutureBuilder<List<BaoCaoPhieuMua>>(
//       future: _baoCaoTonKhoLoaiVangFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return ListView.builder(
//             itemCount: _filteredBaoCaoPhieuMuaList.length,
//             itemBuilder: (context, index) {
//               final baoCao = _filteredBaoCaoPhieuMuaList[index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 15),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 228, 200, 126),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   children: [
//                     ExpansionTile(
//                       title: Text(
//                         baoCao.tenNhomHang!,
//                         style: const TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                       tilePadding:
//                           const EdgeInsets.only(left: 20, top: 5, bottom: 0),
//                       backgroundColor: Colors.transparent,
//                       childrenPadding:
//                           const EdgeInsets.only(left: 10, top: 0, bottom: 10),
//                     //   children: baoCao.map((loaiVangTonKho) {
//                     //     return Container(
//                     //       margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     //       decoration: BoxDecoration(
//                     //         color: const Color.fromARGB(50, 169, 169, 169),
//                     //         borderRadius: BorderRadius.circular(15.0),
//                     //       ),
//                     //       child: Padding(
//                     //         padding: const EdgeInsets.all(8.0),
//                     //         child: Column(
//                     //           children: [
//                     //             ListTile(
//                     //               title: Text(
//                     //                 loaiVangTonKho.hangHoaTen!,
//                     //                 style: const TextStyle(
//                     //                     fontWeight: FontWeight.bold),
//                     //               ),
//                     //             ),
//                     //             tableItem(loaiVangTonKho),
//                     //             const SizedBox(height: 10),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     );
//                     //   }).toList(),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(
//                           left: 10.0, right: 10.0, bottom: 15.0, top: 10.0),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 201, 201, 201),
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             const ListTile(
//                               title: Text(
//                                 'Tổng:',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             tableSummary(baoCao),
//                             const SizedBox(height: 10),
//                             tableSummaryCurrency(baoCao),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Table tableItem(BaoCaoPhieuMua phieu) {
//     return Table(
//       border: TableBorder.all(color: Colors.grey),
//       children: [
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Thực',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Hột',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Vàng',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(phieu.canTong ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(phieu.tLHot ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(phieu.canTong ?? 0)),
//               ),
//             ),
//           ],
//         ),
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
            
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Thành Tiền',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(phieu.thanhTien ?? 0)),
//               ),
//             ),
           
//           ],
//         ),
//       ],
//     );
//   }

//   Table tableSummary(BaoCaoPhieuMua baoCao) {
//     return Table(
//       border: TableBorder.all(color: Colors.grey),
//       children: [
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Tổng TL Thực',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Tổng TL Hột',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Tổng TL Vàng',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(baoCao.tLThuc ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(baoCao.tLHot ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(baoCao.canTong ?? 0)),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Table tableSummaryCurrency(BaoCaoPhieuMua baoCao) {
//     return Table(
//       border: TableBorder.all(color: Colors.grey),
//       children: [
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
            
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Thành Tiền',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
            
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(baoCao.thanhTien ?? 0)),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Table tableTotal(Map<String, double> total) {
//     return Table(
//       border: TableBorder.all(color: Colors.grey),
//       children: [
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Thực',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Hột',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('TL Vàng',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(total['tongTLThuc'] ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(total['tongTLHot '] ?? 0)),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(total['tongTLVang'] ?? 0)),
//               ),
//             ),
//           ],
//         ),
//         const TableRow(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(150, 218, 218, 218),
//           ),
//           children: [
            
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Thành Tiền',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
           
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(formatCurrencyDouble(total['tongThanhTien'] ?? 0)),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
