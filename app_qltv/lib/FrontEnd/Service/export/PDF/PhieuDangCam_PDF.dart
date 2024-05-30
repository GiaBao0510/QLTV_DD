import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

final int SoHang =0;

Future<pw.Font> loadFont(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

buildPrintableData(List<dynamic> data, pw.Font font) => pw.Container(
  child: pw.Table(
      border: pw.TableBorder.all(
        color: PdfColors.black,
      ),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.black,
          ),
          children: [
            pw.Column(children: [
              pw.Text(
                'Mã phiếu',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10,
                    font: font),
              )
            ]),
            pw.Column(children: [
              pw.Text('Tên khách hàng',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Ngày cầm',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Ngày quá hạn',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Cân tổng',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('TL hột',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('TL thực',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Định giá',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Tiền khách nhận',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Tiền nhận thêm',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Tiền cầm mới',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
            pw.Column(children: [
              pw.Text('Lãi suất',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 10,
                      font: font))
            ]),
          ],
        ),
        ...data.map((item) => pw.TableRow(children: [
          pw.Column(children: [
            pw.Text(' ${item['PHIEU_MA']} ',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${item['KH_TEN']}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${item['NGAY_CAM']}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${item['NGAY_QUA_HAN']}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${DinhDangDonViTien_VND(item['CAN_TONG'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${DinhDangDonViTien_VND(item['TL_HOT'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${DinhDangDonViTien_VND(item['TL_THUC'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${DinhDangDonViTien_VND(item['DINHGIA'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(
                ' ${DinhDangDonViTien_VND(item['TIEN_KHACH_NHAN'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(' ${DinhDangDonViTien_VND(item['TIEN_THEM'])}',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
          pw.Column(children: [
            pw.Text(
                ' ${DinhDangDonViTien_VND(item['TIEN_CAM_MOI'])}',
                style: pw.TextStyle(font: font ,fontSize: 8) )
          ]),
          pw.Column(children: [
            pw.Text(' ${item['LAI_XUAT']}%',
                style: pw.TextStyle(font: font,fontSize: 8))
          ]),
        ]))
            .toList(),

      ]),
);