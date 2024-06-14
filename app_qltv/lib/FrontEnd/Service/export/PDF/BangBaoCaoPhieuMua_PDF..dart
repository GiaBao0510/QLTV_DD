import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import '../../../model/danhmuc/BaoCaoPhieuMua.dart';
import '../../../ui/components/FormatCurrency.dart';

Future<pw.Font> loadFont(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

buildPrintableData(List<BaoCaoPhieuMua> data, pw.Font font,
        Map<String, dynamic> thongTinTinhTong) =>
    pw.Container(
        child: pw.Table(
      border: pw.TableBorder.all(
        color: PdfColors.black,
      ),
      children: [
        // Tiêu đề
        pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.black),
            children: [
              pw.Text('\tCount',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tMã',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tTên',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tNhóm vàng',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tCân tổng',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tTL hột',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tTL thực',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tThành tiền',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
            ]),

        // Lấy thông tin
        ...data.asMap().entries.map((entry) {
          int index = entry.key + 1;
          BaoCaoPhieuMua item = entry.value;
          return pw.TableRow(children: [
            pw.Text('$index', style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${item.phieuMa}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${item.hangHoaTen}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${item.nhomTen}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${formatCurrencyDouble(item.canTong ?? 0)}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${formatCurrencyDouble(item.tlHot ?? 0)}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${formatCurrencyDouble(item.tlThuc ?? 0)}',
                style: pw.TextStyle(fontSize: 7, font: font)),
            pw.Text('${formatCurrencyDouble(item.thanhTien ?? 0)}',
                style: pw.TextStyle(fontSize: 7, font: font)),
          ]);
        }),

        // Hiển thị thông tin tổng
        pw.TableRow(children: [
          pw.Text('Total Count: ${data.length}',
              style: pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_Cantong'])}',
              style: pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_TLhot'])}',
              style: pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_TLthuc'])}',
              style: pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_ThanhTien'])}',
              style: pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
        ])
      ],
    ));
