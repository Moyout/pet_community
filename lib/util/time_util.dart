import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String formatDateTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(date);
  }

  static String? timeDifference(int previousTime, int currTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(previousTime);
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(currTime);
    Duration duration = date.difference(date2);
    if (duration.inMinutes >= 5 && duration.inDays < 1) {
      DateFormat formatter = DateFormat('HH:mm');
      return formatter.format(date);
    }
  }

  static String? timeDifferenceCurrTime(int sendTime) {
    DateTime currTime = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(sendTime);
    Duration duration = currTime.difference(date);
    DateFormat formatter;
    if (duration.inDays < 1) {
      formatter = DateFormat.Hm();
    } else if (duration.inDays < 2) {
      formatter = DateFormat('昨天 HH:mm');
    } else if (duration.inDays < 7) {
      formatter = DateFormat.E().add_Hm();
    } else if (duration.inDays < 365) {
      formatter = DateFormat.MMMEd().add_Hm();
      return formatter.format(date);
    } else {
      formatter = DateFormat.yMMMd().add_E().add_Hm();
    }
    return formatter.format(date);
  }
}
