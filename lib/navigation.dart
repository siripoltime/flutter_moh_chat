import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/chatdata_model.dart';
import 'package:mohpromt_chat/page/chat/chat_message_page.dart';
import 'package:mohpromt_chat/page/chat/widget/show_Image_page.dart';

class Navigation {
  static Navigation shared = Navigation();

  void toChatMessagePage(context, ChatDataModel chatData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatMessagePage(
          chatData: chatData,
        ),
      ),
    );
  }

  void toShowImagePage(context, String imageLink) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => showImagePage(
          imageLink: imageLink,
        ),
      ),
    );
  }
}
