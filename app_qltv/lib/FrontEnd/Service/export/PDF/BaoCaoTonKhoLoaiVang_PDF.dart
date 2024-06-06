import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoLoaiVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

Future<pw.Font> loadFontLoaiVang(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

//Bố trí tiêu đề bảng
pw.TableRow _buildTableHeader(pw.Font font) {
  return pw.TableRow(
      decoration: pw.BoxDecoration(color: PdfColors.black),
      children: [
        pw.Expanded(
            flex: 1,
            child: pw.Text('Loại',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Mã',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Tên',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Nhóm Vàng',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('TL Thực',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('TL Hột',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('TL Vàng',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Công Gốc',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Giá Công',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('Thành Tiền',
                style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 10))),
      ]);
}

//Bo trí các hàng con
pw.TableRow _buildTableRow(LoaiVangTonKho P_item, pw.Font font) {
  return pw.TableRow(children: [
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${P_item.nhomTen}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${P_item.hangHoaMa}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${P_item.hangHoaTen}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${P_item.nhomTen}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.canTong ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.tlHot ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.tlVang ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.congGoc ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.giaCong ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
    pw.Expanded(
        flex: 1,
        child: pw.Text(' ${formatCurrencyDouble(P_item.thanhTien ?? 0)}',
            style: pw.TextStyle(
                font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
  ]);
}

pw.TableRow _buildRowSummaryTtem(
    BaoCaoTonKhoLoaiVang P_item, pw.Font font, int itemCount) {
  return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey400),
      children: [
        pw.Expanded(
            flex: 1,
            child: pw.Text('',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text('$itemCount',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ${formatCurrencyDouble(P_item.tongTlThuc ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ${formatCurrencyDouble(P_item.tongTlHot ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ${formatCurrencyDouble(P_item.tongTlVang ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ${formatCurrencyDouble(P_item.tongCongGoc ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(' ${formatCurrencyDouble(P_item.tongGiaCong ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
        pw.Expanded(
            flex: 1,
            child: pw.Text(
                ' ${formatCurrencyDouble(P_item.tongThanhTien ?? 0)}',
                style: pw.TextStyle(
                    font: font, fontWeight: pw.FontWeight.bold, fontSize: 8))),
      ]);
}

buildPrintableLoaiVang(List<BaoCaoTonKhoLoaiVang> data, pw.Font font,
        Map<String, dynamic> thongTinTinhTong) =>
    pw.Container(
      child: pw.Table(
          border: pw.TableBorder.all(
            color: PdfColors.black,
          ),
          children: [
            _buildTableHeader(font),
            ...data.expand((p_item) {
              final itemCount = p_item.data.length;
              return [
                pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey),
                    children: [
                      pw.Expanded(
                          child: pw.Text(' ${p_item.nhomTen}',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, font: font))),
                    ]),
                ...p_item.data
                    .map((c_item) => _buildTableRow(c_item, font))
                    .toList(),
                _buildRowSummaryTtem(p_item, font, itemCount),
              ];
            }).toList(),

            //Hien thi tong thong tin
            pw.TableRow(children: [
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongTLThuc'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongTLHot'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongTLVang'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongCongGoc'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongGiaCong'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(thongTinTinhTong['tongThanhTien'])}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
            ]),
          ]),
    );
