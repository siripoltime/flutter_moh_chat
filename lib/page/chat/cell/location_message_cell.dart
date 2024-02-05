import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';

class LocationMessageCell extends StatefulWidget {
  final bool isMe;
  final MessageModel messageData;

  const LocationMessageCell({
    super.key,
    this.isMe = false,
    required this.messageData,
  });

  @override
  LocationMessageCellState createState() => LocationMessageCellState();
}

class LocationMessageCellState extends State<LocationMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(_openLocation());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.location_on,
                color: widget.isMe ? Colors.white : Colors.black,
                size: 40,
              ),
            ),
            Expanded(
              child: Text(
                (widget.messageData.message ?? "") == "" ? "Location".tr : widget.messageData.message ?? "",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: widget.isMe ? Colors.white : Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Route _openLocation() {
  //   AddressModel data = AddressModel();
  //   data.address = widget.messageData.message ?? "";
  //   data.lat = widget.messageData.messageJson?["lat"] ?? 0.0;
  //   data.long = widget.messageData.messageJson?["long"] ?? 0.0;
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         openLocationPage(addressData: data,),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;
  //
  //       var tween =
  //       Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
