import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import '../../../model/danhmuc/BaoCaoPhieuXuat.dart';
import '../../../ui/components/FormatCurrency.dart';
import '../../ThuVien.dart';

//Lấy nagyf giờ hiện tia
var curentDay = DateTime.now();

Future<pw.Font> LoadFont(String fontPath) async{
  final fontData = await rootBundle.load(fontPath);
  final font = pw.Font.ttf(fontData);
  return font;
}

CreateInvoice(BaoCaoPhieuXuat_model item, pw.Font font) => pw.Container(
  padding: pw.EdgeInsets.all(15),
  width: double.infinity,
  child: pw.Column(
      children:[
        // ---- Dòng 1 ----
        pw.Flexible(
          flex: 1,
          child: pw.Row(children: [
            pw.Expanded(
              flex:1,
                child: pw.Text('hd1', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 15), textAlign: pw.TextAlign.center),
            ),

            pw.SizedBox( width: 10),

            pw.Expanded(
              flex:3,
              child: pw.Column(children: [
                pw.Text('hd1', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
                pw.Text('ct', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font, fontSize: 15)),
                pw.Text('ct', style: pw.TextStyle( font: font, fontSize: 15)),
              ])
            ),
          ])
        ),

        // ---- Dòng 2 ----
        pw.Flexible(
          flex: 1,
            child: pw.Row(children: [
              pw.Expanded(
                  flex:1,
                  child: pw.Column(children: [
                    pw.Align (
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Ngày: ${CurrentDateAndTime()}', textAlign: pw.TextAlign.left),
                    ),
                    pw.Align (
                      alignment: pw.Alignment.centerLeft,
                      child:  pw.Text('KH: ${ item.KH_TEN}', style: pw.TextStyle(font: font), textAlign: pw.TextAlign.left),
                    ),
                  ])
              ),

              pw.SizedBox( width: 10),

              pw.Expanded(
                flex: 3,
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Row(children: [
                    pw.SizedBox(width: 100),

                    pw.Flexible(
                        flex: 2,
                        child: pw.Column(children: [
                          pw.Text('BIÊN NHẬN GIAO DỊCH', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 25, font: font)),
                          pw.Text('undefine')
                        ])
                    ),

                    pw.SizedBox(width: 30),

                    pw.Flexible(
                      flex: 1,
                      child: pw.Column(children: [
                        pw.BarcodeWidget(
                            data: "${item.PHIEU_XUAT_MA}",
                            barcode: pw.Barcode.qrCode(),
                            width: 50,
                            height: 50
                        ),
                        pw.SizedBox(height: 100)
                      ]),
                    ),
                  ]),
                )
              ),
            ]),
        ),

        // ---- Dòng 3 ----
        pw.Flexible(
            flex: 2,
          child: pw.Row(children: [
            pw.Expanded(
              flex:1,
                child: pw.Column(children: [
                  pw.SizedBox(height: 23),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text('Vàng bán: ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 18),textAlign: pw.TextAlign.left),
                  ),
                  pw.Table(
                    border: pw.TableBorder.all(
                      color: PdfColors.black,
                    ),
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text('Tên hàng', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold,font: font), textAlign:pw.TextAlign.center ),
                          )
                        ]
                      ),
                      pw.TableRow(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('${item.HANG_HOA_TEN}', style: pw.TextStyle(fontSize: 15, font: font), textAlign:pw.TextAlign.center ),
                            )
                          ]
                      ),
                    ]
                  )
                ])
            ),

            pw.SizedBox( width: 10),

            pw.Expanded(
                flex:2,
                child: pw.Column(children: [
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text('KH: ${item.KH_TEN}', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 20),textAlign: pw.TextAlign.left),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text('Vàng bán: ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 18),textAlign: pw.TextAlign.left),
                  ),
                  pw.Table(
                    border: pw.TableBorder.all(
                      color: PdfColors.black,
                    ),
                    children: [

                      //Tiêu đề
                      pw.TableRow(
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' TT ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' Mã số ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' Tên hàng ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' Loại ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' KLT ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' KLH ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' KLV ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' SL ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' Đơn giá ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' T.Công ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(' Thành tiền ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                          ),
                        ]
                      ),

                      //Thông tin
                      pw.TableRow(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' 1 ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${item.HANGHOAMA} ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${item.HANG_HOA_TEN} ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${item.LOAIVANG} ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.CAN_TONG) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.TL_HOT) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.TL_Vang) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ item.SO_LUONG } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.DON_GIA) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.GIA_CONG) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.THANH_TIEN) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 8),textAlign: pw.TextAlign.center),
                            ),
                          ]
                      ),

                      //Tính tổng
                      pw.TableRow(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' Tổng cộng: ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.TL_Vang) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ item.SO_LUONG } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('',),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(' ${ formatCurrencyDouble(item.THANH_TIEN) } ', style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold, fontSize: 10),textAlign: pw.TextAlign.center),
                            ),
                          ]
                      ),

                    ]
                  ),
                ])
            ),
          ])
        ),

        // ---- Dong 4 ----
        pw.SizedBox(height: 30),
        
        pw.Flexible(
          flex: 3,
          child: pw.Row(children: [
           pw.Expanded(
              flex:1,
                child: pw.Column(children:[
                  pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.BarcodeWidget(
                      data: '${item.PHIEU_XUAT_MA}',
                      barcode: pw.Barcode.qrCode(),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                   pw.Align(
                       alignment: pw.Alignment.bottomLeft,
                       child: pw.Text('${item.PHIEU_XUAT_MA}', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 18)),
                   ),
                ])
            ),
            pw.Expanded(
                flex:1,
                child: pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(children: [
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Loại GD: Bán', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.left),
                    ),
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Lưu ý:', style: pw.TextStyle(font: font, fontSize: 15, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(' \t + Hàng giao rồi xin vui lòng không trả lại.', style: pw.TextStyle(font: font, fontSize: 12)),
                    pw.Text(' \t + Chúng tôi không chịu trách nhiệm về sự sai thiếu và đeo mòn về sau.', style: pw.TextStyle(font: font, fontSize: 12)),
                  ]),
                ),
            ),

            pw.SizedBox(width: 30),

            pw.Expanded(
                flex:1,
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(children: [
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text('Thành tiền(VND)', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.left),
                    ),

                    pw.SizedBox(height: 5),

                    pw.Row(children:[
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Tiền vàng mới: ', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('${ formatCurrencyDouble(item.TONG_TIEN) }', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                    ]),
                    pw.Row(children:[
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Tiền vàng khách: ', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('0', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                    ]),
                    pw.Row(children:[
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Tiền bớt: ', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('${ formatCurrencyDouble(item.TIEN_BOT) }', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                    ]),
                    pw.Row(children:[
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Thanh toán: ', style: pw.TextStyle(font: font, fontSize: 12, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('${ formatCurrencyDouble(item.THANH_TOAN) ?? 0.0 }', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                        ),
                      ),
                    ]),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Ngày: ${CurrentDateAndTime()} ', style: pw.TextStyle(font: font, fontSize: 12), textAlign: pw.TextAlign.left),
                    ),
                    
                    pw.SizedBox(height: 15),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('THU: ${(item.THANH_TOAN.toInt()).toVietnameseWords()} đồng.', style: pw.TextStyle(font: font, fontSize: 12, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic), textAlign: pw.TextAlign.left),
                    ),
                  ]),
                )
            ),
          ])
        )

      ]
  ),
);