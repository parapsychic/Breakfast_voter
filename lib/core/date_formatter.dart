import 'package:intl/intl.dart';

class DateFormatter {
  static String getDateNow() {
    DateFormat dateFormat = DateFormat("yyyyMMdd");
    return dateFormat.format(DateTime.now());
  }

  static Duration timeTillEnd() {
    DateTime dt1 = DateTime.now();
    String month = dt1.month < 10 ? "0${dt1.month}" : "${dt1.month}";
    String day = dt1.day < 10 ? "0${dt1.day}" : "${dt1.day}";
    //DateTime dt2 = DateTime.parse("${dt1.year}-$month-$day 10:30:00");
    DateTime dt2 = DateTime.parse("${dt1.year}-$month-$day 10:30:00");

    Duration diff = dt2.difference(dt1);
    return diff;
  }
}
