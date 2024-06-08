import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
import '../../../ui/components/FormatCurrency.dart';

Future<pw.Font> loadFont(String fontPath) async{
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

//Danh sach hang hoa theo ma phieu xuat
List<pw.TableRow> BuildListItems(List<BangBaoCaoPhieuXuat_model> data, pw.Font font){
  List<pw.TableRow> rows = [];
  //Ma phieu
  for(var item in data){
    rows.add(
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey400),
        children: [
          pw.Text(' \t ${item.MaPhieuXuat}', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
          pw.Text(''),
        ]
      ),
    );

    //Thong tin hang hoa
    for(var hanghoas in item.PhieuXuat){
      rows.add(
        pw.TableRow(children: [
          pw.Text('${hanghoas.PHIEU_XUAT_MA}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${hanghoas.HANGHOAMA}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${hanghoas.HANG_HOA_TEN}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${hanghoas.LOAIVANG}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.CAN_TONG)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.TL_HOT)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.TL_Vang)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${hanghoas.NGAY_XUAT}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.DON_GIA)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.THANH_TIEN)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.GiaGoc)}', style: pw.TextStyle(fontSize: 7, font: font)),
          pw.Text('${formatCurrencyDouble(hanghoas.LaiLo)}', style: pw.TextStyle(fontSize: 7, font: font)),
        ]),
      );
    }
  }
  return rows;
}

//Phan hien thị chinh
buildPrintableData(List<BangBaoCaoPhieuXuat_model> data,pw.Font font, Map<String, dynamic> thongTinTinhTong ){
  List<pw.TableRow> rows = BuildListItems(data, font);
  return pw.Container(
      child: pw.Table(
          border: pw.TableBorder.all(
            color: PdfColors.black,
          ),
          children: [
            //Tieu de
            pw.TableRow(
                decoration: const pw.BoxDecoration(
                    color: PdfColors.black
                ),
                children: [
                  pw.Text('\tMã', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tMã hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tTên hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tLoại vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tCân tổng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tTL hột', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tTL vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tNgày xuất', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tĐơn giá', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tThành tiền', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tGiá gốc', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                  pw.Text('\tLãi lỗ', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
                ]
            ),

            //Phan in ma phieu
            ...rows,

            //Thông tin tính tông
            pw.TableRow(
                children: [
                  pw.Text(''),
                  pw.Text(''),
                  pw.Text(''),
                  pw.Text(''),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongCanTong'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongTLhot'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongTLVang'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                  pw.Text(''),
                  pw.Text(''),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongThanhTien'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongGiaGoc'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                  pw.Text('${formatCurrencyDouble(thongTinTinhTong['_tongLaiLo'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
                ]
            ),
          ]
      )
  );
}