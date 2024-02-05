import 'package:flutter/material.dart';
import 'package:mohpromt_chat/appManager/format_time_notification.dart';

class TimeToDayMessageCell extends StatefulWidget {
  final String timeA;
  final String timeB;
  final Locale locale;

  const TimeToDayMessageCell({super.key, required this.timeA, required this.timeB, required this.locale});

  @override
  TimeToDayMessageCellState createState() => TimeToDayMessageCellState();
}

class TimeToDayMessageCellState extends State<TimeToDayMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TimeExtension.isTimeToDay(widget.timeA, widget.timeB, widget.locale)
        ? Container()
        : Container(
            margin: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                TimeExtension.timeAgoChat(widget.timeA, widget.locale),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
              ),
            ),
          );
  }
}
