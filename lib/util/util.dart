import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static bool isEmpty(dynamic val) {
    if (val == null) return true;
    if (val.isEmpty) return true;
    return false;
  }

  static rmPicType(String text) {
    if (text.contains(",")) {
      return text.split(",").elementAt(1);
    } else {
      return text;
    }
  }

  static str(String text) {
    return text.replaceAll("-", "");
  }

  static number(String val) {
    return NumberFormat("#,###").format(int.parse(val));
  }

  static numberInt(int val) {
    return NumberFormat.decimalPattern().format(val);
  }

  static double maxWidth(BuildContext context) {
    if (MediaQuery.of(context).size.width > 640) return 640.0;
    return MediaQuery.of(context).size.width;
  }

  static double maxWidthPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 640) return (width - 640.0) / 2 < 0 ? 0 : (width - 640.0) / 2;
    return 0;
  }

  static bool isTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 640) return true;
    return false;
  }

  static hideText(String text, {int size = 4}) {
    if (text.isEmpty) return "";
    if (text.length < size) size = (text.length / 2).ceil();
    int start = ((text.length - size) / 2).ceil();
    for (var i = start + 1; i <= start + size; i++) {
      text = text.replaceRange(i - 1, i, "X");
    }
    return text;
  }

  static hideTextStart(String text, {int size = 4}) {
    if (text.isEmpty) return "";
    if (text.length < size) size = (text.length / 2).ceil();
    int start = 0;
    for (var i = start + 1; i <= start + size; i++) {
      text = text.replaceRange(i - 1, i, "X");
    }
    return text;
  }

  static idcard(String text) {
    if (text.isEmpty) return "";
    if (text.length != 13) return text;
    String txt = "";
    txt += "${text.substring(0, 1)}-";
    txt += "${text.substring(1, 5)}-";
    txt += "${text.substring(5, 10)}-";
    txt += "${text.substring(10, 12)}-";
    txt += text.substring(12);
    return txt;
  }

  static mobile(String text) {
    if (text.isEmpty) return "";
    if (text.length != 10) return text;
    String txt = "";
    txt += "${text.substring(0, 3)}-";
    txt += "${text.substring(3, 6)}-";
    txt += text.substring(6);
    return txt;
  }

  static imageBase64(String? text) {
    if (text == null || text.isEmpty) return "";
    List<String> arr = text.split(",");
    if (arr.length != 2) return "";
    return base64.decode(arr[1]);
  }

  static String toStr(dynamic val) {
    if (val == null) return "";
    if (val is int) return "$val";
    if (val is double) return "$val";
    if (val.toLowerCase() == "") return "";
    if (val.toLowerCase() == "nan") return "";
    if (val.toLowerCase() == "null") return "";
    return "$val";
  }

  static int toInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    if (val is String) {
      if (val.toLowerCase() == "") return 0;
      if (val.toLowerCase() == "nan") return 0;
      if (val.toLowerCase() == "null") return 0;
      return int.parse(val);
    }
    return 0;
  }

  static double toDouble(dynamic val) {
    if (val == null) return 0;
    if (val is double) return val;
    if (val is int) return val.toDouble();
    if (val is String) {
      if (val.toLowerCase() == "") return 0.0;
      if (val.toLowerCase() == "nan") return 0.0;
      if (val.toLowerCase() == "null") return 0.0;
      return double.parse(val);
    }
    return 0.0;
  }
}
