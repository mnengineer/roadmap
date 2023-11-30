import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatToJapaneseDate(DateTime date) {
  initializeDateFormatting('ja');
  return DateFormat('yyyy/MM/dd HH:mm', 'ja').format(date);
}

String formatDeadline(DateTime deadline) {
  return DateFormat('yyyy-MM-dd').format(deadline);
}
