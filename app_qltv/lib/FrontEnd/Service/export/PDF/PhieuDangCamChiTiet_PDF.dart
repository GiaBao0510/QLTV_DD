import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;
import 'package:google_fonts/google_fonts.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

buildPrintableData(List<dynamic> data) => pw.Container(
  child: pw.Table(
    border: pw.TableBorder.all(
      color: PdfColors.black,
    ),
    children: [
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.black
        ),
        children: [
          pw.Expanded(
            flex: 1, child: pw.Text('Mã phiếu', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('Tên khách hàng', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('Ngày cầm', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('Ngày quá hạn', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('Tên hàng hóa', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('Cân tổng', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('TL hột', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
          pw.Expanded(
              flex: 1, child: pw.Text('TL thực', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ))
          ),
        ]
      ),

      ...data.map((P_item) =>pw.TableRow(
        children: [
          pw.Expanded(
               child: pw.Text('${P_item['LOAI_VANG']}')
          ),
        ]
      )).toList()

    ]
  )
);