import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/model/CamVang/PhieuDangCam.dart';
import '../../../ui/components/FormatCurrency.dart';

Future<pw.Font> loadFont(String fontPath) async {
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

List<pw.Widget> buildPrintableData(List<PhieuDangCam_model> data, pw.Font font, TinhTongPhieuDangCam_model thongTinTinhTong) {
  return [pw.Table(
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
        ...data.map((item) =>
            pw.TableRow(children: [
              pw.Column(children: [
                pw.Text(' ${item.PHIEU_MA} ',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${item.KH_TEN}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${item.NGAY_CAM}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${item.DEN_NGAY}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(item.CAN_TONG ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(item.TL_HOT ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(item.TL_THUC ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(item.DINH_GIA ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(item.TIEN_KHACH_NHAN ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(item.TIEN_THEM ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(
                    ' ${formatCurrencyDouble(item.TIEN_MOI ?? 0.0)}',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
              pw.Column(children: [
                pw.Text(' ${item.LAI_XUAT}%',
                    style: pw.TextStyle(font: font, fontSize: 8))
              ]),
            ]))
            .toList(),

        //Hien thi tong thong tin
        pw.TableRow(
            children: [
              pw.Column(children: [
                pw.Text(' ${thongTinTinhTong.SoLuong}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [pw.Text(' ')]),
              pw.Column(children: [pw.Text('')]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.TongCanTong ?? 0.0)}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.Tong_TL_HOT ?? 0.0)}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.Tong_TLthuc ?? 0.0)}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.TongDinhGia ?? 0.0)}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.TongTienKhachNhan ?? 0.0)}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.TongTienThem ?? 0.0)}',
                    style: pw.TextStyle(
                        font: font, fontSize: 8, color: PdfColors.red))
              ]),
              pw.Column(children: [
                pw.Text(' ${formatCurrencyDouble(
                    thongTinTinhTong.TongTienMoi ?? 0.0)}', style: pw.TextStyle(
                    font: font, fontSize: 8, color: PdfColors.red))
              ]),
            ]
        ),

      ])
  ];
}