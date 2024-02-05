import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class Alert {
  static showAlertDialogError(BuildContext context, String title, String content) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
        title: Text(title.tr),
        content: Text(content.tr),
      ),
    );
  }
}
