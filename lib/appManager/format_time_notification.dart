import 'dart:ui';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension TimeExtension on String {
  static String timeAgo(String date, Locale locale) {
    if (locale == const Locale('th', 'TH')) {
      initializeDateFormatting('th');
      var parsedDate = DateTime.parse(date).toLocal();
      String formattedDateMEd = DateFormat.MEd('th').format(parsedDate);
      String formattedDateyMd = DateFormat.yMd('th').format(parsedDate);
      Duration diff = DateTime.now().difference(parsedDate);
      // if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} ปีที่แล้ว";
      // if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} เดือนที่แล้ว";
      // if (diff.inDays > 0 && diff.inDays <=6) return "${diff.inDays} วันที่แล้ว";
      if (diff.inMinutes > 0 && diff.inMinutes < 60) return '${diff.inMinutes} นาทีที่แล้ว';
      if (diff.inHours > 0 && diff.inHours < 24) return '${diff.inHours} ชม.ที่แล้ว';
      if (diff.inHours >= 24 && diff.inHours < 48) return 'เมื่อวานนี้';
      if (diff.inDays >= 2 && diff.inDays < 7) return formattedDateMEd;
      if (diff.inDays >= 7) return formattedDateyMd;
      return "ตอนนี้";
    } else {
      initializeDateFormatting('en');
      var parsedDate = DateTime.parse(date).toLocal();
      String formattedDateMEd = DateFormat.MEd('en').format(parsedDate);
      String formattedDateyMd = DateFormat.yMd('en').format(parsedDate);
      Duration diff = DateTime.now().difference(parsedDate);
      // if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} ปีที่แล้ว";
      // if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} เดือนที่แล้ว";
      // if (diff.inDays > 0 && diff.inDays <=6) return "${diff.inDays} วันที่แล้ว";
      if (diff.inMinutes > 0 && diff.inMinutes < 60) return '${diff.inMinutes} Min. ago';
      if (diff.inHours > 0 && diff.inHours < 24) return '${diff.inHours} Hr. ago';
      if (diff.inHours >= 24 && diff.inHours < 48) return 'Yesterday';
      if (diff.inDays >= 2 && diff.inDays < 7) return formattedDateMEd;
      if (diff.inDays >= 7) return formattedDateyMd;
      return "Now";
    }
  }

  static bool isTimeToDay(String timeA, String timeB, Locale locale) {
    if (locale == const Locale('th', 'TH')) {
      initializeDateFormatting('th');
      var parsedDateA = DateTime.parse(timeA).toLocal();
      var parsedDateB = DateTime.parse(timeB).toLocal();
      final dateFormatterA = DateFormat.yMMMMd('th').format(parsedDateA);
      final dateFormatterB = DateFormat.yMMMMd('th').format(parsedDateB);

      return dateFormatterA == dateFormatterB;
    } else {
      initializeDateFormatting('en');
      var parsedDateA = DateTime.parse(timeA).toLocal();
      var parsedDateB = DateTime.parse(timeB).toLocal();
      final dateFormatterA = DateFormat.yMMMMd('en').format(parsedDateA);
      final dateFormatterB = DateFormat.yMMMMd('en').format(parsedDateB);

      return dateFormatterA == dateFormatterB;
    }
  }

  static String timeAgoChat(String date, Locale locale) {
    if (locale == const Locale('th', 'TH')) {
      initializeDateFormatting('th');
      var parsedDate = DateTime.parse(date).toLocal();
      String formattedDateMEd = DateFormat.MEd('th').format(parsedDate);
      String formattedDateyMd = DateFormat.yMd('th').format(parsedDate);
      final newDate = DateTime.now().toLocal();
      var newNowA = DateTime(newDate.year, newDate.month, newDate.day, 0, 0);
      var newNowB = DateTime(parsedDate.year, parsedDate.month, parsedDate.day, 0, 0);
      Duration diff = newNowA.difference(newNowB);
      if (diff.inDays == 0)
        return 'วันนี้';
      else if (diff.inDays == 1)
        return 'เมื่อวานนี้';
      else if (diff.inDays >= 2 && diff.inDays < 7)
        return formattedDateMEd;
      else if (diff.inDays >= 7) return formattedDateyMd;
      return 'วันนี้';
    } else {
      initializeDateFormatting('en');
      var parsedDate = DateTime.parse(date).toLocal();
      String formattedDateMEd = DateFormat.MEd('en').format(parsedDate);
      String formattedDateyMd = DateFormat.yMd('en').format(parsedDate);
      final newDate = DateTime.now().toLocal();
      var newNowA = DateTime(newDate.year, newDate.month, newDate.day, 0, 0);
      var newNowB = DateTime(parsedDate.year, parsedDate.month, parsedDate.day, 0, 0);
      Duration diff = newNowA.difference(newNowB);
      if (diff.inDays == 0)
        return 'ToDay';
      else if (diff.inDays == 1)
        return 'Yesterday';
      else if (diff.inDays >= 2 && diff.inDays < 7)
        return formattedDateMEd;
      else if (diff.inDays >= 7) return formattedDateyMd;
      return "ToDay";
    }
  }

  static bool isTimeToMinute(String timeA, String timeB, Locale locale) {
    if (locale == const Locale('th', 'TH')) {
      initializeDateFormatting('th');
      DateTime parsedDateA = DateTime.parse(timeA).toLocal();
      DateTime parsedDateB = DateTime.parse(timeB).toLocal();

      var diff_mn = parsedDateA.difference(parsedDateB).inSeconds;

      return diff_mn < 60;
    } else {
      initializeDateFormatting('en');
      var parsedDateA = DateTime.parse(timeA).toLocal();
      var parsedDateB = DateTime.parse(timeB).toLocal();

      final diff_mn = parsedDateA.difference(parsedDateB).inMinutes;
      print(diff_mn);
      return diff_mn < 60;
    }
  }

  static String setTimejm(String date, Locale locale) {
    if (locale == const Locale('th', 'TH')) {
      initializeDateFormatting('th');
      var parsedDate = DateTime.parse(date).toLocal();
      final dateFormatter0 = DateFormat.jm('th').format(parsedDate);
      return dateFormatter0;
    } else {
      initializeDateFormatting('en');
      var parsedDate = DateTime.parse(date).toLocal();
      final dateFormatter0 = DateFormat.jm('en').format(parsedDate);
      return dateFormatter0;
    }
  }
}
