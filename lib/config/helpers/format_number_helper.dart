import 'package:intl/intl.dart';

class FormatNumber {
  static String number(double number) {
    final formattedNumber =
        NumberFormat.compactCurrency(symbol: '', decimalDigits: 0, locale: 'en')
            .format(number);

    return formattedNumber;
  }
}
