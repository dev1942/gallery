import 'package:intl/intl.dart';

import '../constants.dart';

class DateModel {
  String year;
  String month;
  String date;
  String daysOfTheWeek;
  bool isSelected;

  DateModel(
      {required this.year,
      required this.month,
      required this.date,
      required this.daysOfTheWeek,
      required this.isSelected});

  getDateString() {
    return "$year-$month-$date";
  }

  getDateTime() {
    DateTime selectedDate =
        DateFormat(Constants.STRING_YYYY_MM_DD).parse(getDateString());
    return selectedDate;
  }
}
