// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart';
// import '../../../model/danhmuc/BaoCaoPhieuMua.dart';
// import '../../../ui/components/FormatCurrency.dart';

// Future<pw.Font> loadFont(String fontPath) async{
//   final fontData = await rootBundle.load(fontPath);
//   final font = pw.Font.ttf(fontData);
//   return font;
// }

// buildPrintableData(List<BaoCaoPhieuMua> data,pw.Font font, Map<String, dynamic> thongTinTinhTong ) => pw.Container(
//   child: pw.Table(
//     border: pw.TableBorder.all(
//       color: PdfColors.black,
//     ),
//     children: [
//       //Tieu de
//       pw.TableRow(
//         decoration: const pw.BoxDecoration(
//           color: PdfColors.black
//         ),
//         children: [
//           pw.Text('\tMã', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tMã hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tTên hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tLoại vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tCân tổng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tTL hột', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tTL vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tNgày xuất', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tĐơn giá', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//           pw.Text('\tThành tiền', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//         ]
//       ),

//       //Thong tin
//       ...data.map((item) => pw.TableRow(
//         children: [
//           pw.Text('${item.phieu_ma}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${item.ma_hang_hoa}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${item.ten_hang_hoa}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${item.nhom_ten}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${formatCurrencyDouble(item.can_tong)}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${formatCurrencyDouble(item.tl_hot)}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${formatCurrencyDouble(item.tl_thuc)}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${item.ngay_phieu}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${formatCurrencyDouble(item.don_gia)}', style: pw.TextStyle(fontSize: 7, font: font)),
//           pw.Text('${formatCurrencyDouble(item.thanh_tien)}', style: pw.TextStyle(fontSize: 7, font: font)),
//         ]
//       )),

//       //Thông tin tính tông
//       pw.TableRow(
//           children: [
//             pw.Text(''),
//             pw.Text(''),
//             pw.Text(''),
//             pw.Text(''),
//             pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_CanTong'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//             pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_TlHot'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//             pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_TLThuc'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//             pw.Text(''),
//             pw.Text(''),
//             pw.Text('${formatCurrencyDouble(thongTinTinhTong['TongThanhTien'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
            
//           ]
//       ),
//     ]
//   )
// );