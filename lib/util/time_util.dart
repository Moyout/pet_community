import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String formatDateTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(date);
  }

  static String compareTime(int previousTime, int currTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(previousTime);
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(currTime);
    debugPrint("date--------->${date}");
    debugPrint("date2--------->${date}");
    if (date2.year == date.year && date2.month == date.month && date2.day == date.day) {
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
      return formatter.format(date);
    }
    return "";
  }
}
