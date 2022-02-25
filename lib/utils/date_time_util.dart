import 'package:intl/intl.dart';

class DateTimeUtil {
  static String toReadableDateTime(int timestamp) {
    var format = DateFormat('dd MMM yyyy');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return format.format(date);
  }

  static String readTimestamp(int timestamp, String display) {
    if (display == 'Simple') {
      return simple(timestamp);
    } else if (display == 'Date/Time') {
      return dateOrTime(timestamp);
    } else if (display == 'Date & Time') {
      return dateAndTime(timestamp);
    } else if (display == 'Date Only') {
      return dateOnly(timestamp);
    } else {
      return simple(timestamp);
    }
  }

  static String simple(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var format = DateFormat('hh:mm a');
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' day ago';
      } else {
        time = diff.inDays.toString() + ' days ago';
      }
    } else if (diff.inDays > 6 && diff.inDays < 30) {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' week ago';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' weeks ago';
      }
    } else if (diff.inDays > 29 && diff.inDays < 265) {
      if (diff.inDays == 30) {
        time = (diff.inDays / 30).floor().toString() + ' month ago';
      } else {
        time = (diff.inDays / 30).floor().toString() + ' months ago';
      }
    } else {
      if (diff.inDays == 265) {
        time = (diff.inDays / 265).floor().toString() + ' year ago';
      } else {
        time = (diff.inDays / 265).floor().toString() + ' years ago';
      }
    }

    return time;
  }

  static String dateOrTime(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var format = DateFormat('hh:mm a');
    var dateFormat = DateFormat('MMM dd');
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      time = dateFormat.format(date);
    }

    return time;
  }

  static String dateAndTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var format = DateFormat('dd/MM/yyyy hh:mm a');

    return format.format(date);
  }

  static String dateOnly(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var format = DateFormat('MMM dd');

    return format.format(date);
  }
}
