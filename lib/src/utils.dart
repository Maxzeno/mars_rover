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

String? dateFormaterForRequest(DateTime? date) {
  if (date == null) {
    return null;
  }
  return DateFormat('yyyy-MM-dd').format(date);
}

String listToString(List data) {
  String res = '';
  for (var element in data) {
    res += element + ", ";
  }

  return res.substring(0, res.length - 2);
}
