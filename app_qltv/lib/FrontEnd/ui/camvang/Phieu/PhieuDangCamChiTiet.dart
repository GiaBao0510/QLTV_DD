// import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import './PhieuDangCam.dart';
import './ThongTinChiTietPhieuCam.dart';
import '../../../Service/export/PDF/PhieuDangCamChiTiet_PDF.dart';

class PhieuDangCamChiTiet extends StatefulWidget {
  static const routeName = '/phieudangcamchitiet';
  const PhieuDangCamChiTiet({super.key});
  State<PhieuDangCamChiTiet> createState() => _PhieuDangCamChiTiet();
}

class _PhieuDangCamChiTiet extends State<PhieuDangCamChiTiet> {
  late List<dynamic> thongtin, data;
  late String loaivang;
  PhieuDangCam phieudangcam = PhieuDangCam();
  var thongTinTinhTong;

  @override
  void initState() {
    PhieuDangCamChiTiet_List();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //1. Lấy thông tin
  Future<List<dynamic>> PhieuDangCamChiTiet_List() async {
    String path = url + '/api/cam/chitietphieucam';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.get(
      Uri.parse(path),
      headers: {
        "Content-Type": "application/json",
        "accesstoken": "${prefs.getString('accesstoken')}",
      },
    );
    List<dynamic> result = jsonDecode(res.body);
    int soHang = 0;
    double tong_CanTong = 0.0,
        tong_TLhot = 0.0,
        tong_TLthuc = 0.0,
        tong_DinhGia = 0.0,
        tong_TienKhachNhan = 0.0,
        tong_TienNhanThem = 0.0,
        tong_TienCamMoi = 0.0;

    // //Xử lý tính tổng
    for (var i = 0; i < result.length; i++) {
      final item = result[i]['data'];

      for (var j = 0; j < item.length; j++) {
        final child_item = item[j];
        print(' ------- ${soHang} -----------');
        print('Cân tổng: ${child_item['CAN_TONG']}');
        print('TL hột: ${child_item['TL_HOT']}');

        tong_CanTong += child_item['CAN_TONG'];
        tong_TLhot += child_item['TL_HOT'];
        tong_TLthuc += child_item['TL_THUC'];
        tong_DinhGia += child_item['DINHGIA'];
        tong_TienKhachNhan += child_item['TIEN_KHACH_NHAN'];
        tong_TienNhanThem += child_item['TIEN_THEM'];
        tong_TienCamMoi += child_item['TIEN_CAM_MOI'];
        soHang++;
      }
    }
    thongTinTinhTong = {
      "Tong_CANTONG": tong_CanTong,
      "Tong_TLhot": tong_TLhot,
      "Tong_TLthuc": tong_TLthuc,
      "Tong_DinhGia": tong_DinhGia,
      "tong_TienKhachNhan": tong_TienKhachNhan,
      "tong_TienNhanThem": tong_TienNhanThem,
      "tong_TienCamMoi": tong_TienCamMoi,
      "soHang": soHang,
    };

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 28,
              ),
              title: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Phiếu đang cầm chi tiết',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Align',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: () {
                          print('Chuyển sang phần chuyển đổi PDF');
                          //print(thongtin);
                          printDoc(thongtin);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
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
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          )),
                        )),
                  ),
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
            body: RefreshIndicator(
              onRefresh: PhieuDangCamChiTiet_List,
              child: FutureBuilder<List<dynamic>>(
                future: PhieuDangCamChiTiet_List(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    thongtin = snapshot.data ?? [];
                    return Scrollbar(
                      interactive: true,
                      thumbVisibility: true,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xfffcfcfc), Color(0xffdedede)],
                            stops: [0.25, 0.75],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: thongtin.length,
                          itemBuilder: (context, index) {
                            var item = thongtin[index];
                            var loaivang = item['LOAI_VANG'];
                            var data = item['data'] ?? [];

                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffebac00),
                                        Color(0xffc27b00)
                                      ],
                                      stops: [0.25, 0.75],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 8,
                                        offset: Offset(-2, 5),
                                      ),
                                    ],
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: ' \t Loại vàng: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text: ' ${loaivang ?? 'null'}'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  child: Container(
                                    height: 300,
                                    child: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        var subItem = data[index];

                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 15),
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 10, 0, 10),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xffededed),
                                                Color(0xffa9a7a2)
                                              ],
                                              stops: [0.25, 0.75],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            Text.rich(
                                                              TextSpan(
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        ' \t Mã phiếu: ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        ' ${subItem['PHIEU_MA'] ?? 'null'}',
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text.rich(
                                                              TextSpan(
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        ' \t Tên khách: ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        ' ${subItem['KH_TEN'] ?? 'null'}',
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            ThongTinChiTiet(
                                                                context,
                                                                subItem);
                                                          },
                                                          icon: const Icon(Icons
                                                              .info_outline),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            'Ngày cầm: \n\t${subItem['NGAY_CAM'] ?? 'null'} '),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            'Tên hàng hóa: \n\t${subItem['TEN_HANG_HOA'] ?? 'null'} '),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            'Ngày quá hạn:\n\t ${subItem['NGAY_QUA_HAN'] ?? 'null'} '),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            'Cân tổng: \n\t${subItem['CAN_TONG'] ?? 'null'} '),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            'TL hột: \n\t${subItem['TL_HOT'] ?? 'null'} '),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            'TL thực: \n\t${subItem['TL_THUC'] ?? 'null'} '),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            )));
  }

  //Chuyển sang PDF
  Future<void> printDoc(List<dynamic> data) async {
    final doc = pw.Document();
    final font = await loadFont("assets/fonts/Roboto-Regular.ttf");
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(data, font, thongTinTinhTong);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
