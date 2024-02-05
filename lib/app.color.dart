import 'package:flutter/material.dart';

class AppColor {
  //
  static const Color black = Color(0XFF000000);
  static const Color white = Color(0XFFFFFFFF);
  static const Color transparent = Color(0x00000000);
  static const Color background = Color(0XFFD7F9EB);
  static const Color background100 = Color(0XFF86D0B0);
  static const Color backgroundDark = Color(0XFF2D8159);
  static const Color backgroundDark100 = Color(0XFF1F3A35);

  static const Color backgroundWorning = Color(0XFFFFE1BE);
  static const Color backgroundEmpty = Color(0XFFF4F4F4);

  static const Color bgWarning = Color(0XFFFCE8D8);
  static const Color bgInfo = Color(0XFFDCF5F6);
  static const Color bgSuccess = Color(0XFFDBF4E2);

  static const Color gradientLightGreen = Color(0XFFEBFDF3);
  static const Color gradientLightGreenDark = Color(0XFFD5F1E6);

  static const Color gradientGreen = Color(0XFF2C9061);
  static const Color gradientGreenDark = Color(0XFF245543);

  static const Color gradientBlue = Color(0XFF2676CD);
  static const Color gradientBlue2 = Color(0XFF07519F);
  static const Color gradientBlueDark = Color(0XFF124175);

  static const Color cardLightGreen = Color(0XFFFDFFFE);
  static const Color cardLightGreenDark = Color(0XFFD6EDE6);

  static const Color cardVaccine = Color(0XFFEEF3F1);
  static const Color cardBlue = Color(0XFFD3E5F8);
  static const Color cardBlueDark = Color(0XFF1357A0);

  static const Color link = Color(0XFF1F9D69);
  static const Color linkLight = Color(0XFFBCF3DB);
  static const Color selected = Color(0XFFBCF3DB);
  static const Color disabled = Color(0XFFBDBDBD);
  static const Color mintGreen = Color(0XFF86D0B0);
  static const Color mintGreenDark = Color(0XFF4CB59B);
  static const Color skyBlue = Color(0XFF50CBD2);
  static const Color gold = Color(0XFFFFD309);
  static const Color copper = Color(0XFF997009);

  static const Color btnLightLabel = Color(0XFF1F9D69);
  static const Color btnLightBg = Color(0XFFFFFFFF);
  static const Color btnLightBgPress = Color(0XFFB0E0C5);

  static const Color tagGreen = Color(0XFF007D37);
  static const Color tagGreenBg = Color(0XFFB0E0C5);
  static const Color tagPurple = Color(0XFF3E16AC);
  static const Color tagPurpleBg = Color(0XFFD7C9FF);
  static const Color tagBlue = Color(0XFF1B6DA9);
  static const Color tagBlueBg = Color(0XFFC0E1FF);
  static const Color tagCyan = Color(0XFF39716A);
  static const Color tagCyanBg = Color(0XFFAFF3EC);
  static const Color tagOlive = Color(0XFF877400);
  static const Color tagOliveBg = Color(0XFFF2EABA);
  static const Color tagBrown = Color(0XFF5C5141);
  static const Color tagBrownBg = Color(0XFFD4CABD);

  static const MaterialColor primary = MaterialColor(0XFF0F955D, {
    10: Color(0XFFEBFDF6),
    50: Color(0XFFCBFAE6),
    100: Color(0XFF96F4CD),
    200: Color(0XFF62EFB4),
    300: Color(0XFF2DEA9B),
    400: Color(0XFF14C97E),
    500: Color(0XFF0F955D),
    600: Color(0XFF2D8159),
    700: Color(0XFF095938),
    800: Color(0XFF1F3A35),
    900: Color(0XFF031E13),
  });

  static const MaterialColor secondary = MaterialColor(0XFFFEE85F, {
    50: Color(0XFFFFF8D1),
    100: Color(0XFFFFF5BA),
    200: Color(0XFFFEF2A4),
    300: Color(0XFFFEEF8D),
    400: Color(0XFFFEEB76),
    500: Color(0XFFFEE85F),
    600: Color(0XFFFEE025),
    700: Color(0XFFE7C701),
    800: Color(0XFFAD9601),
    900: Color(0XFF746401),
  });

  static const MaterialColor sky = MaterialColor(0XFF1B6DA9, {
    50: Color(0XFF95C1E8),
    100: Color(0XFF7FB4E4),
    200: Color(0XFF6AA8DF),
    300: Color(0XFF559BDB),
    400: Color(0XFF2C82D0),
    500: Color(0XFF1B6DA9),
    600: Color(0xFF1668A2),
    700: Color(0xFF15659E),
    800: Color(0XFF164168),
    900: Color(0XFF123453),
  });

  static const MaterialColor success = MaterialColor(0XFF49C96D, {
    50: Color(0XFFE1F6E7),
    100: Color(0XFFC2EDCE),
    200: Color(0XFFA4E4B6),
    300: Color(0XFF86DB9E),
    400: Color(0XFF67D285),
    500: Color(0XFF49C96D),
    600: Color(0XFF32A954),
    700: Color(0XFF267F3F),
    800: Color(0XFF19552A),
    900: Color(0XFF0D2A15),
  });

  static const MaterialColor warning = MaterialColor(0XFFEE8D3E, {
    50: Color(0XFFFCECDF),
    100: Color(0XFFF9D9BF),
    200: Color(0XFFF6C69F),
    300: Color(0XFFF4B37E),
    400: Color(0XFFF1A05E),
    500: Color(0XFFEE8D3E),
    600: Color(0XFFDD6E13),
    700: Color(0XFFA5520F),
    800: Color(0XFF6E370A),
    900: Color(0XFF371B05),
  });

  static const MaterialColor info = MaterialColor(0XFF50CBD2, {
    50: Color(0XFFE2F6F8),
    100: Color(0XFFC5EEF0),
    200: Color(0XFFA8E5E8),
    300: Color(0XFF8ADCE1),
    400: Color(0XFF6DD4DA),
    500: Color(0XFF50CBD2),
    600: Color(0XFF2FB1B9),
    700: Color(0XFF24858A),
    800: Color(0XFF18595C),
    900: Color(0XFF0C2C2E),
  });

  static const MaterialColor danger = MaterialColor(0XFFE83131, {
    50: Color(0XFFF8C4C4),
    100: Color(0XFFF5A7A7),
    200: Color(0XFFF28989),
    300: Color(0XFFEF6C6C),
    400: Color(0XFFEB4E4E),
    500: Color(0XFFE83131),
    600: Color(0XFFD31818),
    700: Color(0XFFA91313),
    800: Color(0XFF7E0E0E),
    900: Color(0XFF540909),
  });

  static const MaterialColor light = MaterialColor(0XFFFFFFFF, {
    50: Color(0X1FFFFFFF),
    100: Color(0X3DFFFFFF),
    200: Color(0X62FFFFFF),
    300: Color(0X99FFFFFF),
    400: Color(0XB3FFFFFF),
    500: Color(0XFFFFFFFF),
    600: Color(0xFFDBDBDB),
    700: Color(0xFFB6B6B6),
    800: Color(0xFF929292),
    900: Color(0xFF6D6D6D),
  });

  static const MaterialColor dark = MaterialColor(0XFF2D2D2D, {
    50: Color(0xFF878787),
    100: Color(0xFF6F6F6F),
    200: Color(0xFF575757),
    300: Color(0xFF3F3F3F),
    400: Color(0xFF272727),
    500: Color(0XFF2D2D2D),
    600: Color(0xFF0D0D0D),
    700: Color(0xFF0B0B0B),
    800: Color(0xFF090909),
    900: Color(0xFF060606),
  });

  static const MaterialColor grey = MaterialColor(0xFF9E9E9E, {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    900: Color(0xFF212121),
  });

  static const MaterialColor cyan = MaterialColor(0xFF50CBD2, {
    50: Color(0xFFE0F7FA),
    100: Color(0xFFB2EBF2),
    200: Color(0xFF80DEEA),
    300: Color(0xFF4DD0E1),
    400: Color(0xFF26C6DA),
    500: Color(0xFF00BCD4),
    600: Color(0xFF00ACC1),
    700: Color(0xFF0097A7),
    800: Color(0xFF00838F),
    900: Color(0xFF006064),
  });

  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
