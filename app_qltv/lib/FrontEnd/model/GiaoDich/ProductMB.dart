class Product {
  final String code;
  final String prodName;
  final String prodUnit;
  final int prodQuantity;
  final double prodPrice;
  final int vatRate;
  final double vatAmount;
  final double total;
  final double amount;
  final int prodAttr;

  Product({
    required this.code,
    required this.prodName,
    required this.prodUnit,
    required this.prodQuantity,
    required this.prodPrice,
    required this.vatRate,
    required this.vatAmount,
    required this.total,
    required this.amount,
    required this.prodAttr,
  });

  Product copyWith({
    String? code,
    String? prodName,
    String? prodUnit,
    int? prodQuantity,
    double? prodPrice,
    int? vatRate,
    double? vatAmount,
    double? total,
    double? amount,
    int? prodAttr,
  }) {
    return Product(
      code: code ?? this.code,
      prodName: prodName ?? this.prodName,
      prodUnit: prodUnit ?? this.prodUnit,
      prodQuantity: prodQuantity ?? this.prodQuantity,
      prodPrice: prodPrice ?? this.prodPrice,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      total: total ?? this.total,
      amount: amount ?? this.amount,
      prodAttr: prodAttr ?? this.prodAttr,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      code: map['code'] ?? '',
      prodName: map['ProdName'] ?? '',
      prodUnit: map['ProdUnit'] ?? '',
      prodQuantity: map['ProdQuantity']?.toDouble() ?? 0.0,
      prodPrice: map['ProdPrice']?.toDouble() ?? 0.0,
      vatRate: map['VATRate'] ?? 0,
      vatAmount: map['VATAmount']?.toDouble() ?? 0.0,
      total: map['Total']?.toDouble() ?? 0.0,
      amount: map['Amount']?.toDouble() ?? 0.0,
      prodAttr: map['ProdAttr'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'ProdName': prodName,
      'ProdUnit': prodUnit,
      'ProdQuantity': prodQuantity,
      'ProdPrice': prodPrice,
      'VATRate': vatRate,
      'VATAmount': vatAmount,
      'Total': total,
      'Amount': amount,
      'ProdAttr': prodAttr,
    };
  }
}
