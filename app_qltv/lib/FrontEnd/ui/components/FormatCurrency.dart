String formatCurrencyDouble(double value) {
  // Ensure the number has two decimal places
  String formattedString = value.toStringAsFixed(2);

  // Split the number into integer and decimal parts
  List<String> parts = formattedString.split('.');

  // Add commas to the integer part
  String integerPart = parts[0];
  String decimalPart = parts[1];

  // Use a regular expression to add commas
  RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
  String formattedIntegerPart =
      integerPart.replaceAllMapped(regExp, (Match match) => ',');

  // Combine the integer part and decimal part
  return '$formattedIntegerPart.$decimalPart';
}

String formatCurrencyInteger(int value) {
  String formattedString = value.toString();
  ;
  RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
  String formattedIntegerPart =
      formattedString.replaceAllMapped(regExp, (Match match) => ',');
  return formattedIntegerPart;
}
