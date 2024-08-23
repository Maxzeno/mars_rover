import 'package:intl/intl.dart';

String dateFormater(DateTime? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('d MMM, yyyy').format(date);
}

String dataParseFormater(String? dateString) {
  if (dateString == null) {
    return '';
  }
  return dateFormater(DateFormat('yyyy-MM-dd').parse(dateString));
}

String dateFormaterForRequest(DateTime? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('yyyy-MM-dd').format(date);
}
