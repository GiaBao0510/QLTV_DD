// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart';
// import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
// import '../../../ui/components/FormatCurrency.dart';
//
// Future<pw.Font> loadFont(String fontPath) async{
//   final fontData = await rootBundle.load(fontPath);
//   final font = pw.Font.ttf(fontData);
//   return font;
// }
//
// buildPrintableData(List<BangBaoCaoPhieuXuat_model> data,pw.Font font, Map<String, dynamic> thongTinTinhTong ){
//
//   return pw.Container(
//       child: pw.Table(
//           border: pw.TableBorder.all(
//             color: PdfColors.black,
//           ),
//           children: [
//             //Tieu de
//             pw.TableRow(
//                 decoration: const pw.BoxDecoration(
//                     color: PdfColors.black
//                 ),
//                 children: [
//                   pw.Text('\tMã', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tMã hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tTên hàng hóa', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tLoại vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tCân tổng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tTL hột', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tTL vàng', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tNgày xuất', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tĐơn giá', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tThành tiền', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tGiá gốc', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                   pw.Text('\tLãi lỗ', style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold, font: font)),
//                 ]
//             ),
//
//             //Thong tin
//             ...data.map((item) {
//                 final hanghoa = item.PhieuXuat;
//                 return pw.TableRow(
//                     children: [
//                       pw.Text('${hanghoa.}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${item.HANGHOAMA}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${item.HANG_HOA_TEN}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${item.LOAIVANG}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.CAN_TONG)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.TL_HOT)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.TL_Vang)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${item.NGAY_XUAT}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.DON_GIA)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.THANH_TIEN)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.GiaGoc)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                       pw.Text('${formatCurrencyDouble(item.LaiLo)}', style: pw.TextStyle(fontSize: 7, font: font)),
//                     ]
//                 );
//               }
//             ),
//
//             //Thông tin tính tông
//             pw.TableRow(
//                 children: [
//                   pw.Text(''),
//                   pw.Text(''),
//                   pw.Text(''),
//                   pw.Text(''),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_CanTong'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_TlHot'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_TLvang'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                   pw.Text(''),
//                   pw.Text(''),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['TongThanhTien'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['Tong_GiaGoc'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                   pw.Text('${formatCurrencyDouble(thongTinTinhTong['TongLaiLo'])}', style: pw.TextStyle(color: PdfColors.red, fontSize: 7)),
//                 ]
//             ),
//           ]
//       )
//   );
// }