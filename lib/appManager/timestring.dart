import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension TimeString on String {
  static String setTimejm(String dateString) {
    initializeDateFormatting('th', null);
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateString).toLocal();
    final dateFormatter = DateFormat.jmz("th").format(tempDate);
    return dateFormatter;
  }
}
