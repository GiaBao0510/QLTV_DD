import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';

buildPrintableData(List<dynamic> data) => pw.Container(
  child: pw.Table(
    border: pw.TableBorder.all(
        color: PdfColors.black,
        //width: double.infinity,
    ),

    children: [
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.black,
          //border: pw.TableBorder.all(width: 60)
        ),

        children: [
          pw.Column(children: [pw.Text('Mã phiếu', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10 ), )]),
          pw.Column(children: [pw.Text('Tên khách hàng', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Ngày cầm', style: pw.TextStyle(fontWeight: pw.FontWeight.bold,  color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Ngày quá hạn', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Cân tổng', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('TL hột', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('TL thực', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Định giá', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Tiền khách nhận', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Tiền nhận thêm', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Tiền cầm mới', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
          pw.Column(children: [pw.Text('Lãi suất', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10))]),
        ],
      ),

      ...data.map((item)=> pw.TableRow(
        children: [
          pw.Column(children: [pw.Text('${item['PHIEU_MA']}')]),
          pw.Column(children: [pw.Text('${item['KH_TEN']}')]),
          pw.Column(children: [pw.Text('${item['NGAY_CAM']}')]),
          pw.Column(children: [pw.Text('${item['NGAY_QUA_HAN']}')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['CAN_TONG']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['TL_HOT']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['TL_THUC']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['DINHGIA']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['TIEN_KHACH_NHAN']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['TIEN_THEM']) }')]),
          pw.Column(children: [pw.Text('${ DinhDangDonViTien_VND(item['TIEN_CAM_MOI']) }')]),
          pw.Column(children: [pw.Text('${item['LAI_XUAT']}%')]),
        ]
      )).toList(),

    ]
  ),
);

