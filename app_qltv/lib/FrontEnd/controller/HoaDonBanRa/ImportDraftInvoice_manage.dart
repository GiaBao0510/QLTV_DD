import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';

class ImportDraftInvoiceManage with ChangeNotifier {
  List<ImportDraftInvoice_Model> _importDraftInvoice = [];
  List<ImportDraftInvoice_Model> get importDaftInvoices => _importDraftInvoice;
  int get importDaftInvoice_length => _importDraftInvoice.length;

  //Them hoa don nhap
  Future<void> addDraftInvoice(ImportDraftInvoice_Model DraftInvoice) async {
    print('Đầu vào: ${DraftInvoice}');

    final reponse = await http.post(
      Uri.parse('${urlMatBao + ImportHoaDonNhap}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'ApiUserName': ApiUserName,
        'ApiPassword': ApiPassword,
        'ApiInvPattern': DraftInvoice.ApiInvPattern,
        'ApiInvSerial': DraftInvoice.ApiInvSerial,
        'Fkey': DraftInvoice.Fkey,
        'ArisingDate': DraftInvoice.ArisingDate,
        'SO': DraftInvoice.SO,
        'MaKH': DraftInvoice.MaKH,
        'CusName': DraftInvoice.CusName,
        'Buyer': DraftInvoice.Buyer,
        'CusAddress': DraftInvoice.CusAddress,
        'CusPhone': DraftInvoice.CusPhone,
        'CusTaxCode': DraftInvoice.CusTaxCode,
        'CusEmail': DraftInvoice.CusEmail,
        'CusEmailCC': DraftInvoice.CusEmailCC,
        'CusBankName': DraftInvoice.CusBankName,
        'CusBankNo': DraftInvoice.CusBankNo,
        'PaymentMethod': DraftInvoice.PaymentMethod,
        'Product': DraftInvoice.Product,
        'Total': DraftInvoice.Total,
        'DiscountAmount': DraftInvoice.DiscountAmount,
        'VATAmount': DraftInvoice.VATAmount,
        'Amount': DraftInvoice.Amount,
      }),
    );

    print(reponse.body);

    if (reponse.statusCode == 200) {
      _importDraftInvoice.add(DraftInvoice);
      notifyListeners();
    } else {
      throw Exception('Failed to add Draft Invoice');
    }
  }
}
