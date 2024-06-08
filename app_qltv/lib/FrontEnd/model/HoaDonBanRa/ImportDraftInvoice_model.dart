class Products_model{
  final String code;
  final String ProdName;
  final String ProdUnit;
  final double ProdQuantity;
  final double ProdPrice;
  final double VATRate;
  final double VATAmount;
  final double Total;
  final double Amount;

  Products_model({
    required this.code,
    required this.ProdName,
    required this.ProdUnit,
    required this.ProdQuantity,
    required this.ProdPrice,
    required this.VATRate,
    required this.VATAmount,
    required this.Total,
    required this.Amount,
  });

  //Chuyen doi Map sang Object
  factory Products_model.fromMap(Map<String, dynamic> json){
    return Products_model(
      code: json['code'] ?? '',
      ProdName: json['ProdName'] ?? '',
      ProdUnit: json['ProdUnit'] ?? '',
      ProdQuantity: (json['ProdQuantity'] is int) ? (json['ProdQuantity'] as int).toDouble():
        (json['ProdQuantity'] is double)? json['ProdQuantity'] : 0.0,
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
    );
  }

  //CHuyen doi object sang map
  Map<String, dynamic> toMap(Map<String,dynamic> map){
    return {
      'code': code,
      'ProdName': ProdName,
      'ProdUnit': ProdUnit,
      'ProdQuantity': ProdQuantity,
      'ProdPrice': ProdPrice,
      'VATRate': VATRate,
      'VATAmount': VATAmount,
      'Total': Total,
      'Amount': Amount,
    };
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
  final Products_model Product;
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
  });

  //Chuyen Map sang object
  factory ImportDraftInvoice_Model.fromMap(Map<String, dynamic> json){
    var product = json['Products'];
    Products_model InfoProduct = Products_model.fromMap(product);
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
      Product : InfoProduct,
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
      'Product': Product,
      'Total': Total,
      'DiscountAmount': DiscountAmount,
      'VATAmount': VATAmount,
      'Amount': Amount,
    };
  }
}