import 'package:flutter/material.dart';
import 'package:mohpromt_chat/app.color.dart';

class ColorManager {
  Color primaryColor = AppColor.primary;
  Color secondaryColor = Colors.white;
  Color backgroundColor = Colors.white;

  static Color messageColor(bool isMe) {
    return isMe ? Colors.white : Colors.black;
  }
}

class FontSizeManager {
  double headerSize = 24;
  double defaultSize = 18;
  double textLSize = 16;
  double textMSize = 14;
  double textSSize = 12;
}
