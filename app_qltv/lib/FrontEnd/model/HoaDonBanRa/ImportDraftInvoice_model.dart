import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Products_model{
  final String code;
  final String ProdName;
  final String ProdUnit;
  final double ProdQuantity;
  final double DiscountAmount;
  final double Discount;
  final double ProdPrice;
  final double VATRate;
  final double VATAmount;
  final double Total;
  final double Amount;
  final int ProdAttr;
  final String Remark;

  Products_model({
    required this.code,
    required this.ProdName,
    required this.ProdUnit,
    required this.ProdQuantity,
    required this.DiscountAmount,
    required this.Discount,
    required this.ProdPrice,
    required this.VATRate,
    required this.VATAmount,
    required this.Total,
    required this.Amount,
    required this.ProdAttr,
    required this.Remark,
  });

  //ham sao chep
  Products_model copyWith({
    String? code,
    String? ProdName,
    String? ProdUnit,
    double? ProdQuantity,
    double? DiscountAmount,
    double? Discount,
    double? ProdPrice,
    double? VATRate,
    double? VATAmount,
    double? Total,
    double? Amount,
    int? ProdAttr,
    String? Remark,
  }){
   return Products_model(
     code: code ?? this.code,
     ProdName: ProdName ?? this.ProdName,
     ProdUnit: ProdUnit ?? this.ProdUnit,
     ProdQuantity: ProdQuantity ?? this.ProdQuantity,
     DiscountAmount: DiscountAmount ?? this.DiscountAmount,
     Discount: Discount ?? this.Discount,
     ProdPrice: ProdPrice ?? this.ProdPrice,
     VATRate: VATRate ?? this.VATRate,
     VATAmount: VATAmount ?? this.VATAmount,
     Total: Total ?? this.Total,
     Amount: Amount ?? this.Amount,
     ProdAttr: ProdAttr ?? this.ProdAttr,
     Remark: Remark ?? this.Remark,
   );
  }

  //Chuyen doi Map sang Object
  factory Products_model.fromMap(Map<String, dynamic> json){
    return Products_model(
      code: json['code'] ?? '',
      ProdName: json['ProdName'] ?? '',
      ProdUnit: json['ProdUnit'] ?? '',
      ProdQuantity: (json['ProdQuantity'] is int) ? (json['ProdQuantity'] as int).toDouble():
        (json['ProdQuantity'] is double)? json['ProdQuantity'] : 0.0,
      DiscountAmount: (json['DiscountAmount'] is int) ? (json['DiscountAmount'] as int).toDouble():
        (json['DiscountAmount'] is double)? json['DiscountAmount'] : 0.0,
      Discount:  (json['Discount'] is int) ? (json['Discount'] as int).toDouble():
        (json['Discount'] is double)? json['Discount'] : 0.0,
      ProdPrice: (json['ProdPrice'] is int) ? (json['ProdPrice'] as int).toDouble():
        (json['ProdPrice'] is double)? json['ProdPrice'] : 0.0,
      VATRate: (json['VATRate'] is int) ? (json['VATRate'] as int).toDouble():
        (json['VATRate'] is double)? json['VATRate'] : 0.0,
      VATAmount: (json['VATAmount'] is int) ? (json['VATAmount'] as int).toDouble():
        (json['VATAmount'] is double)? json['VATAmount'] : 0.0,
      Total: (json['Total'] is int) ? (json['Total'] as int).toDouble():
        (json['Total'] is double)? json['Total'] : 0.0,
      Amount: (json['Amount'] is int) ? (json['Amount'] as int).toDouble():
        (json['Amount'] is double)? json['Amount'] : 0.0,
      ProdAttr: (json['ProdQuantity'] is int) ? json['ProdQuantity'] : 0,
      Remark: json['Remark'] ?? '',
    );
  }

  //CHuyen doi object sang map
  Map<String, dynamic> toMap(Map<String,dynamic> map){
    return {
      'code': code,
      'ProdName': ProdName,
      'ProdUnit': ProdUnit,
      'ProdQuantity': ProdQuantity,
      'DiscountAmount':DiscountAmount,
      'Discount': Discount,
      'ProdPrice': ProdPrice,
      'VATRate': VATRate,
      'VATAmount': VATAmount,
      'Total': Total,
      'Amount': Amount,
      'ProdAttr':ProdAttr,
      'Remark':Remark,
    };
  }
}

//Trinh giua cho gia tri nhan vao
class EditControllerProduct{
   TextEditingController MaSP = TextEditingController();
   TextEditingController TenSP= TextEditingController();
   TextEditingController DonViTinh= TextEditingController();
   TextEditingController DonGia= TextEditingController();
   TextEditingController SoLuong= TextEditingController();
   TextEditingController ThanhTienChuaTruCK= TextEditingController();
   TextEditingController ChietKhau= TextEditingController();
   TextEditingController TienChietKhau= TextEditingController();
   TextEditingController ThanhTienTruocThue= TextEditingController();
   TextEditingController ThueSuatGTGT= TextEditingController();
   TextEditingController ThueGTGT= TextEditingController();
   TextEditingController ThanhTienSauThue= TextEditingController();
   TextEditingController TinhChat= TextEditingController();

  //Ham huy luu tạm thời
  DiscardTheTemporarySave(){
    this.MaSP.dispose(); this.TenSP.dispose();
    this.DonViTinh.dispose(); this.DonGia.dispose();
    this.SoLuong.dispose(); this.ThanhTienChuaTruCK.dispose();
    this.ChietKhau.dispose(); this.TienChietKhau.dispose();
    this.ThanhTienTruocThue.dispose(); this.ThueSuatGTGT.dispose();
    this.ThueGTGT.dispose(); this.ThanhTienSauThue.dispose();
    this.TinhChat.dispose();
  }

  //Ham làm sạch thông tin lưu trữ tạm thơi
  CleanTemporaryInformation(){
    this.MaSP.clear(); this.TenSP.clear();
    this.DonViTinh.clear(); this.DonGia.clear();
    this.SoLuong.clear(); this.ThanhTienChuaTruCK.clear();
    this.ChietKhau.clear(); this.TienChietKhau.clear();
    this.ThanhTienTruocThue.clear(); this.ThueSuatGTGT.clear();
    this.ThueGTGT.clear(); this.ThanhTienSauThue.clear();
    this.TinhChat.clear();
  }
}

class ImportDraftInvoice_Model{
  final String ApiUserName;
  final String ApiPassword;
  final String ApiInvPattern;
  final String ApiInvSerial;
  final String Fkey;
  final String ArisingDate;
  final String SO;
  final String MaKH;
  final String CusName;
  final String Buyer;
  final String CusAddress;
  final String CusPhone;
  final String CusTaxCode;
  final String CusEmail;
  final String CusEmailCC;
  final String CusBankName;
  final String CusBankNo;
  final String PaymentMethod;
  final String Extra;
  final int DonViTienTe;
  final List<Products_model> Product;
  final double TyGia;
  final double Total;
  final double DiscountAmount;
  final double VATAmount;
  final double Amount;

  ImportDraftInvoice_Model({
    required this.ApiUserName,
    required this.ApiPassword,
    required this.ApiInvPattern,
    required this.ApiInvSerial,
    required this.Fkey,
    required this.ArisingDate,
    required this.SO,
    required this.MaKH,
    required this.CusName,
    required this.Buyer,
    required this.CusAddress,
    required this.CusPhone,
    required this.CusTaxCode,
    required this.CusEmail,
    required this.CusEmailCC,
    required this.CusBankName,
    required this.CusBankNo,
    required this.PaymentMethod,
    required this.Product,
    required this.Total,
    required this.DiscountAmount,
    required this.VATAmount,
    required this.Amount,
    required this.Extra,
    required this.DonViTienTe,
    required this.TyGia,
  });

  //Ham sao chep
  ImportDraftInvoice_Model copyWith({
    String? ApiUserName,
    String? ApiPassword,
    String? ApiInvPattern,
    String? ApiInvSerial,
    String? Fkey,
    String? ArisingDate,
    String? SO,
    String? MaKH,
    String? CusName,
    String? Buyer,
    String? CusAddress,
    String? CusPhone,
    String? CusTaxCode,
    String? CusEmail,
    String? CusEmailCC,
    String? CusBankName,
    String? CusBankNo,
    String? PaymentMethod,
    String? Extra,
    int? DonViTienTe,
    List<Products_model>? Product,
    double? TyGia,
    double? Total,
    double? DiscountAmount,
    double? VATAmount,
    double? Amount,
  }){
    return ImportDraftInvoice_Model(
      ApiUserName: ApiUserName ?? this.ApiUserName,
      ApiPassword: ApiPassword ?? this.ApiPassword,
      ApiInvPattern: ApiInvPattern ?? this.ApiInvPattern,
      ApiInvSerial: ApiInvSerial ?? this.ApiInvSerial,
      Fkey: Fkey ?? this.Fkey,
      ArisingDate: ArisingDate ?? this.ArisingDate,
      SO: SO ?? this.SO,
      MaKH: MaKH ?? this.MaKH,
      CusName: CusName ?? this.CusName,
      Buyer: Buyer ?? this.Buyer,
      CusAddress: CusAddress ?? this.CusAddress,
      CusPhone: CusPhone ?? this.CusPhone,
      CusTaxCode: CusTaxCode ?? this.CusTaxCode,
      CusEmail: CusEmail ?? this.CusEmail,
      CusEmailCC: CusEmailCC ?? this.CusEmailCC,
      CusBankName: CusBankName ?? this.CusBankName,
      CusBankNo: CusBankNo ?? this.CusBankNo,
      PaymentMethod: PaymentMethod ?? this.PaymentMethod,
      DonViTienTe: DonViTienTe ?? this.DonViTienTe,
      TyGia: TyGia ?? this.TyGia,
      Product: Product ?? this.Product,
      Extra: Extra ?? this.Extra,
      Total: Total ?? this.Total,
      DiscountAmount: DiscountAmount ?? this.DiscountAmount,
      VATAmount: VATAmount ?? this.VATAmount,
      Amount: Amount ?? this.Amount,
    );
  }

  //Chuyen Map sang object
  factory ImportDraftInvoice_Model.fromMap(Map<String, dynamic> json){
    var ListProduct = json['Products'] as List;
    List<Products_model> InfoProduct = ListProduct.map((i) => Products_model.fromMap(i)).toList();

    return ImportDraftInvoice_Model(
      ApiUserName : json['ApiUserName'] ?? '',
      ApiPassword : json['ApiPassword'] ?? '',
      ApiInvPattern : json['ApiInvPattern'] ?? '',
      ApiInvSerial : json['ApiInvSerial'] ?? '',
      Fkey : json['Fkey'] ?? '',
      ArisingDate : json['ArisingDate'] ?? '',
      SO : json['SO'] ?? '',
      MaKH: json['MaKH'] ?? '',
      CusName : json['CusName'] ?? '',
      Buyer : json['Buyer'] ?? '',
      CusAddress : json['CusAddress'] ?? '',
      CusPhone : json['CusPhone'] ?? '',
      CusTaxCode : json['CusTaxCode'] ?? '',
      CusEmail : json['CusEmail'] ?? '',
      CusEmailCC : json['CusEmailCC'] ?? '',
      CusBankName : json['CusBankName'] ?? '',
      CusBankNo : json['CusBankNo'] ?? '',
      PaymentMethod : json['PaymentMethod'] ?? '',
      Extra : json['Extra'] ?? '',
      DonViTienTe: (json['DonViTienTe'] is int)  ? json['DonViTienTe']:0,
      Product : InfoProduct,
      TyGia: (json['TyGia'] is int) ? (json['TyGia'] as int).toDouble():
        (json['TyGia'] is double)? json['TyGia'] : 0.0,
      Total: (json['Total'] is int) ? (json['Total'] as int).toDouble():
        (json['Total'] is double)? json['Total'] : 0.0,
      DiscountAmount: (json['DiscountAmount'] is int) ? (json['DiscountAmount'] as int).toDouble():
        (json['DiscountAmount'] is double)? json['DiscountAmount'] : 0.0,
      VATAmount: (json['VATAmount'] is int) ? (json['VATAmount'] as int).toDouble():
        (json['VATAmount'] is double)? json['VATAmount'] : 0.0,
      Amount: (json['Amount'] is int) ? (json['Amount'] as int).toDouble():
        (json['Amount'] is double)? json['Amount'] : 0.0,
    );
  }

  //Chuyen object sang map
  Map<String ,dynamic> toMap(Map<String,dynamic> map){
    return{
      'ApiUserName' : ApiUserName,
      'ApiPassword': ApiPassword,
      'ApiInvPattern': ApiInvPattern,
      'ApiInvSerial': ApiInvSerial,
      'Fkey': Fkey,
      'SO': SO,
      'MaKH': MaKH,
      'CusName': CusName,
      'Buyer': Buyer,
      'CusAddress': CusAddress,
      'CusPhone': CusPhone,
      'CusTaxCode': CusTaxCode,
      'CusEmail': CusEmail,
      'CusEmailCC': CusEmailCC,
      'CusBankName': CusBankName,
      'CusBankNo': CusBankNo,
      'PaymentMethod': PaymentMethod,
      'Extra': Extra,
      'DonViTienTe':DonViTienTe,
      'Product': Product,
      'TyGia':TyGia,
      'Total': Total,
      'DiscountAmount': DiscountAmount,
      'VATAmount': VATAmount,
      'Amount': Amount,
    };
  }
}