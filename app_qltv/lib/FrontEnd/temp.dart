// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:app_qltv/FrontEnd/constants/config.dart';
// import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
// import './ThongTinChiTietPhieuCam.dart';
// import 'package:app_qltv/FrontEnd/Service/export/PDF/PhieuDangCam_PDF.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PhieuDangCam extends StatefulWidget {
//   static const routeName = '/phieudangcam';
//
//   const PhieuDangCam({super.key});
//   State<PhieuDangCam> createState() => _PhieuDangCam();
// }
//
// class _PhieuDangCam extends State<PhieuDangCam> {
//   late List<dynamic> data;
//   var thongTinTinhTong;
//   double tong_CanTong =0.0, tong_TLhot =0.0, tong_TLthuc =0.0,
//       tong_DinhGia =0.0, tong_TienKhachNhan =0.0, tong_TienNhanThem =0.0,
//       tong_TienCamMoi =0.0;
//   int soHang = 0;
//
//   @override
//   void initState() {
//     PhieuDangCam_list();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   // ------------ Phương thức ----------------
//   Future<List<dynamic>> PhieuDangCam_list() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String path = url + '/api/cam/dangcam';
//     var res = await http.get(
//         Uri.parse(path),
//         headers: {
//           "Content-Type": "application/json",
//           "accesstoken": "${prefs.getString('accesstoken')}",
//         }
//     );
//     List<dynamic> list = jsonDecode(res.body);
//
//     //Xử lý tính tổng
//     for(var i =0; i< list.length; i++){
//       final item = list[i];
//       tong_CanTong += item['CAN_TONG'];
//       tong_TLhot += item['TL_HOT'];
//       tong_TLthuc += item['TL_THUC'];
//       tong_DinhGia += item['DINHGIA'];
//       tong_TienKhachNhan += item['TIEN_KHACH_NHAN'];
//       tong_TienNhanThem += item['TIEN_THEM'];
//       tong_TienCamMoi += item['TIEN_CAM_MOI'];
//       soHang++;
//     }
//
//     thongTinTinhTong = {
//       "Tong_CANTONG": tong_CanTong,
//       "Tong_TLhot": tong_TLhot,
//       "Tong_TLthuc": tong_TLthuc,
//       "Tong_DinhGia": tong_DinhGia,
//       "tong_TienKhachNhan": tong_TienKhachNhan,
//       "tong_TienNhanThem": tong_TienNhanThem,
//       "tong_TienCamMoi": tong_TienCamMoi,
//       "soHang": soHang,
//     };
//
//     return list;
//   }
//
//   //Giao diện
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.white,
//             size: 28,
//           ),
//           title: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   'Phiếu đang cầm',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontFamily: 'Align',
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: TextButton(
//                     onPressed: () {
//                       print('Chuyển sang phần chuyển đổi PDF');
//                       printDoc(data);
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Color(0xffededed), Color(0xffdee8e8)],
//                           stops: [0.25, 0.75],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 8,
//                               offset: Offset(4, 8))
//                         ],
//                       ),
//                       child: Center(
//                           child: Text(
//                             'Export PDF',
//                             style: TextStyle(fontSize: 12),
//                             textAlign: TextAlign.center,
//                           )),
//                     )),
//               ),
//             ],
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [Colors.orange, Colors.amber])),
//           ),
//         ),
//         body: RefreshIndicator(
//           onRefresh: PhieuDangCam_list,
//           child: FutureBuilder<List<dynamic>>(
//             future: PhieuDangCam_list(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 );
//               } else {
//                 data = snapshot.data!;
//                 return Scrollbar(
//                     child: Container(
//                       padding: EdgeInsets.fromLTRB(0, 0,0, 0),
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Color(0xffededed), Color(0xffdee8e8)],
//                             stops: [0.25, 0.75],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           )),
//                       child: Column(
//                         children: [
//                           Flexible(
//                             flex: 6,
//                             child: ListView.builder(
//                               itemCount: data.length,
//                               itemBuilder: (context, index) {
//                                 final item = data[index];
//
//                                 return Container(
//                                   padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: Colors.black54,
//                                               blurRadius: 8,
//                                               offset: Offset(-2, 5))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [Color(0xffebebeb), Color(0xffbec0cb)],
//                                           stops: [0.25, 0.75],
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                         )),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                                 flex: 2,
//                                                 child: Row(
//                                                   children: [
//                                                     Text(
//                                                       'Mã phiếu: ',
//                                                       style: TextStyle(
//                                                           fontWeight: FontWeight.bold),
//                                                     ),
//                                                     Text('${item['PHIEU_MA']}'),
//                                                   ],
//                                                 )),
//                                             Expanded(
//                                               flex: 1,
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   ThongTinChiTiet(context, item);
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.info_outline,
//                                                   size: 35,
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               'Tên khách hàng: ',
//                                               style: TextStyle(fontWeight: FontWeight.bold),
//                                             ),
//                                             Text('${item['KH_TEN']}'),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child:
//                                               Text('Ngày cầm: \n${item['NGAY_CAM']}'),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                   'Ngày quá hạn: \n${item['NGAY_QUA_HAN']}'),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                   'Cân tổng: \n${DinhDangDonViTien_VND(item['CAN_TONG'])}'),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                   'TL hột: \n${DinhDangDonViTien_VND(item['TL_HOT'])}'),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                   'TL thực: \n${DinhDangDonViTien_VND(item['TL_THUC'])}'),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                   'Định giá: \n${DinhDangDonViTien_VND(item['DINHGIA'])}'),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                   'Tiền khách nhận: \n${DinhDangDonViTien_VND(item['TIEN_KHACH_NHAN'])}'),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                   'Tiền khách nhận thêm: \n${DinhDangDonViTien_VND(item['TIEN_THEM'])}'),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                   'Tiền cầm mới: \n${DinhDangDonViTien_VND(item['TIEN_CAM_MOI'])}'),
//                                             ),
//                                             Expanded(
//                                                 child: Text('Lãi: \n${item['LAI_XUAT']}%')),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//
//                           Flexible(
//                               flex: 2,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [Color(0xffeb9500), Color(0xfff89c1b)],
//                                       stops: [0.25, 0.75],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     )
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Column(children: [
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng cân tổng: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_CanTong)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng TL hột: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_TLhot)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng TL thực: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_TLthuc)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tông Định giá: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_DinhGia)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng Tiền khách nhận: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_TienKhachNhan)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng tiền nhận thêm: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_TienNhanThem)}')
//                                       ]),
//                                     ),
//                                     Text.rich(
//                                       textAlign: TextAlign.left,
//                                       TextSpan(children: [
//                                         TextSpan(text: 'Tổng tền cầm mới: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                                         TextSpan(text: '${DinhDangDonViTien_VND(tong_TienCamMoi)}')
//                                       ]),
//                                     ),
//                                   ],),
//                                 ),
//                               )
//                           )
//                         ],
//                       ),
//                     ));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   //Nút in tài liệu
//   Future<void> printDoc(List<dynamic> data) async {
//     final font = await loadFont("assets/fonts/Roboto-Regular.ttf");
//     final doc = pw.Document();
//     doc.addPage(pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return buildPrintableData(data, font,thongTinTinhTong);
//         }));
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => doc.save());
//   }
// }