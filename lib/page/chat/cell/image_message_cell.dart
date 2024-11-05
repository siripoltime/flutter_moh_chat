import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/navigation.dart';
import 'package:shimmer/shimmer.dart';

class ImageMessageCell extends StatefulWidget {
  final bool isMe;
  final MessageModel messageData;

  const ImageMessageCell({
    super.key,
    this.isMe = false,
    required this.messageData,
  });

  @override
  ImageMessageCellState createState() => ImageMessageCellState();
}

class ImageMessageCellState extends State<ImageMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.shared.toShowImagePage(context, widget.messageData.url ?? "");
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 100,
          minHeight: 100,
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.messageData.url ?? "",
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                      color: Colors.grey.shade200,
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.5),
                ),
              ),
              // (widget.messageData.pathFile == "")
              //     ? CachedNetworkImage(
              //         // fadeOutDuration: Duration(milliseconds: 0),
              //         // fadeInDuration: Duration(milliseconds: 0),
              //         imageUrl: widget.messageData.message.toString(),
              //         fit: BoxFit.cover,
              //         progressIndicatorBuilder:
              //             (context, url, downloadProgress) =>
              //                 Shimmer.fromColors(
              //           baseColor: Colors.grey.shade200,
              //           highlightColor: Colors.grey.shade100,
              //           child: Container(
              //               color: Colors.grey.shade200,
              //               height: MediaQuery.of(context).size.width * 0.6,
              //               width: MediaQuery.of(context).size.width * 0.5),
              //         ),
              //         errorWidget: (context, error, stackTrace) {
              //           print(error);
              //           return Container(
              //             color: Colors.grey.shade200,
              //             width: MediaQuery.of(context).size.width * 0.5,
              //             height: MediaQuery.of(context).size.width * 0.6,
              //             child: Center(
              //               child:
              //                   Icon(Icons.error, color: Colors.grey.shade500),
              //             ),
              //           ); //do something
              //         },
              //       )
              //     : Image.file(File(widget.messageData.pathFile ?? ""),
              //         fit: BoxFit.cover, frameBuilder:
              //             (context, child, frame, bool wasSynchronouslyLoaded) {
              //         if (wasSynchronouslyLoaded) return child;
              //         return AnimatedOpacity(
              //           opacity: frame == null ? 0 : 1,
              //           duration: Duration(seconds: 1),
              //           curve: Curves.easeOut,
              //           child: child,
              //         );
              //       }, errorBuilder: (context, error, stackTrace) {
              //         return Container(
              //           color: Colors.grey.shade300,
              //           width: MediaQuery.of(context).size.width * 0.5,
              //           height: MediaQuery.of(context).size.width * 0.6,
              //           child: Center(
              //             child: Icon(Icons.error, color: Colors.grey.shade500),
              //           ),
              //         ); //do something
              //       }),
            ],
          ),
        ),
      ),
    );
  }
}
