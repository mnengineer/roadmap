import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatToJapaneseDate(DateTime date) {
  initializeDateFormatting('ja');
  return DateFormat('yyyy/MM/dd HH:mm', 'ja').format(date);
}
