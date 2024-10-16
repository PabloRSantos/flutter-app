import 'package:intl/intl.dart';

class Formatter {
  static String currency(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }
}
