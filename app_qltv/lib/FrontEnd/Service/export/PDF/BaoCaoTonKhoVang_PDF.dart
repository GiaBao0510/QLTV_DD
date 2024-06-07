import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import '../../../model/danhmuc/BaoCaoTonKhoVang.dart';
import '../../../ui/components/FormatCurrency.dart';

Future<pw.Font> loadFont(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

buildPrintableData(List<BaoCaoTonKhoVang_Model> data, pw.Font font,
        Map<String, dynamic> thongTinTinhTong) =>
    pw.Container(
        child: pw.Table(
      border: pw.TableBorder.all(
        color: PdfColors.black,
      ),
      children: [
        //Tiêu đè
        pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.black),
            children: [
              pw.Text('\tLoại',
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
              pw.Text('\tSố lượng',
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
              pw.Text('\tTL hột',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tTL vàng',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tCông gốc',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      font: font)),
              pw.Text('\tGiá công',
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

        //Lấy thông tin
        ...data.map((item) => pw.TableRow(children: [
              pw.Text('${item.NHOM_TEN}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${item.SoLuong}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.TL_Thuc)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.TL_hot)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.TL_vang)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.CONG_GOC)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.GIA_CONG)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
              pw.Text('${formatCurrencyDouble(item.ThanhTien)}',
                  style: pw.TextStyle(fontSize: 7, font: font)),
            ])),

        //Hiển thị thông tin tổng
        pw.TableRow(children: [
          pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_TLthuc'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_TLhot'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_TLvang'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_CongGoc'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_GiaCong'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
          pw.Text('${formatCurrencyDouble(thongTinTinhTong['tong_ThanhTien'])}',
              style:
                  pw.TextStyle(fontSize: 7, font: font, color: PdfColors.red)),
        ])
      ],
    ));
