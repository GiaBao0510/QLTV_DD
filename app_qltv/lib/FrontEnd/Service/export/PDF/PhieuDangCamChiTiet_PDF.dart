import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

Future<pw.Font> loadFont(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

//Bố trí tiêu đề bảng
pw.TableRow _buildTableHeader(pw.Font font){
  return pw.TableRow(
    decoration: pw.BoxDecoration(
        color: PdfColors.black
    ),
    children: [
      pw.Expanded(
        flex: 1, child: pw.Text('Mã phiếu', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('Tên khách hàng', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('Ngày cầm', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('Ngày quá hạn', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('Tên hàng hóa', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('Cân tổng', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('TL hột', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
      pw.Expanded(
          flex: 1, child: pw.Text('TL thực', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
      ),
    ]
  );
}

//Bo trí các hàng con
pw.TableRow _buildTableRow(Map<String, dynamic> P_item, pw.Font font){
  return pw.TableRow(
    children: [
      pw.Expanded(flex: 1, child: pw.Text(' ${P_item['PHIEU_MA']}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${P_item['TEN_HANG_HOA']}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${P_item['NGAY_CAM']}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${P_item['TEN_HANG_HOA']}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${P_item['NGAY_QUA_HAN']}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${ DinhDangDonViTien_VND(P_item['CAN_TONG'])}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${DinhDangDonViTien_VND(P_item['TL_HOT'])}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      pw.Expanded(flex: 1, child: pw.Text(' ${DinhDangDonViTien_VND(P_item['TL_THUC'])}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    ]
  );
}

buildPrintableData(List<dynamic> data, pw.Font font, Map<String, dynamic> thongTinTinhTong) => pw.Container(
  child: pw.Table(
    border: pw.TableBorder.all(
      color: PdfColors.black,
    ),
    children: [
      _buildTableHeader(font),
      ...data.expand((p_item)=> [
        pw.TableRow(
          children: [
            pw.Expanded(child: pw.Text(' ${p_item['LOAI_VANG']}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold ))) ,
          ]
        ),
        ...p_item['data'].map((c_item) => _buildTableRow(c_item, font)).toList(),
      ]).toList(),

      //Hien thi tong thong tin
      pw.TableRow(
          children: [
            pw.Column(children: [pw.Text(' ${thongTinTinhTong['soHang']}', style: pw.TextStyle(font: font,fontSize: 8, color: PdfColors.red))]),
            pw.Column(children: [pw.Text(' ')]),
            pw.Column(children: [pw.Text(' ')]),
            pw.Column(children: [pw.Text('')]),
            pw.Column(children: [pw.Text('')]),
            pw.Column(children: [pw.Text(' ${DinhDangDonViTien_VND(thongTinTinhTong['Tong_CANTONG'])}', style: pw.TextStyle(font: font,fontSize: 8, color: PdfColors.red))]),
            pw.Column(children: [pw.Text(' ${DinhDangDonViTien_VND(thongTinTinhTong['Tong_TLhot'])}', style: pw.TextStyle(font: font,fontSize: 8, color: PdfColors.red))]),
            pw.Column(children: [pw.Text(' ${DinhDangDonViTien_VND(thongTinTinhTong['Tong_TLthuc'])}', style: pw.TextStyle(font: font,fontSize: 8, color: PdfColors.red))]),

          ]
      ),
    ]
  ),
);