import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/appManager/view_manager.dart';
import 'package:mohpromt_chat/page/chat/widget/textmessage_constants.dart';
import 'package:mohpromt_chat/page/chat/widget/textmessage_customwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class TextViewMessageCell extends StatefulWidget {
  final bool isMe;
  final MessageModel messageData;

  const TextViewMessageCell({
    super.key,
    this.isMe = false,
    required this.messageData,
  });

  @override
  TextViewMessageCellState createState() => TextViewMessageCellState();
}

class TextViewMessageCellState extends State<TextViewMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextMessageCustomWidget(
        source: widget.messageData.message ?? "",
        // maxLines: 20,
        // overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: widget.isMe ? Colors.white : Colors.black,
          fontSize: FontSizeManager().textMSize,
        ),
        linkStyle: TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.normal,
          color: widget.isMe ? Colors.white : Colors.blue,
          fontSize: FontSizeManager().textMSize,
        ),
        onTap: (url) {
          debugPrint('element is a ${url.value} and type of ${url.type}');
          if (url.type == StringContainsElementType.email || url.type == StringContainsElementType.url) {
            _launchURL(url.value);
          } else if (url.type == StringContainsElementType.phoneNumber) {
            String phoneNumber = url.value.replaceAll(' ', '');
            launch("tel://${phoneNumber}").catchError((e) {
              //
            });
          }
        },
        types: const [
          StringContainsElementType.email,
          StringContainsElementType.url,
          StringContainsElementType.phoneNumber,
        ],
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : _launchURLHTTP("https://" + _url);

  void _launchURLHTTP(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
