import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohpromt_chat/app.color.dart';

class AppTheme {
  //

  static theme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
