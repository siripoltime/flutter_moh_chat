import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';

class FileMessageCell extends StatefulWidget {
  final bool isMe;
  final MessageModel messageData;

  const FileMessageCell({
    super.key,
    this.isMe = false,
    required this.messageData,
  });

  @override
  FileMessageCellState createState() => FileMessageCellState();
}

class FileMessageCellState extends State<FileMessageCell> {
  bool hasContainer = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fileType = ((widget.messageData.message ?? "").split(".")).last;
    return GestureDetector(
        onTap: () {
          // setState(() {
          //   if(!(widget.messageData.isLoading ?? false) && !(widget.messageData.isRetry ?? false)){
          //     Navigation.shared.toLoadingPage(
          //         context,
          //         widget.messageData.message ?? "",
          //         widget.messageData.messageJson?["file_name"] ?? "",
          //         "file");
          //   }
          // });
          // _showMaterialDialog();
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: _iConFileFromType(fileType),
                    // child: Icon(
                    //   Icons.insert_drive_file,
                    //   color: widget.isMe ? Colors.white : Colors.black,
                    //   size: 40.0,
                    // ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.messageData.message ?? "",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          "${"Size".tr} XXXXXX",
                          // "${"Size".tr} "+ formatBytes(int.parse(widget.messageData.messageJson?["file_size"]),2),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _iConFileFromType(String type) {
    switch (type) {
      case "txt":
        return _assetIcon("assets/icon/txt_icon.png");
      case "pdf":
        return _assetIcon("assets/icon/pdf_icon.png");
      case "ppt":
        return _assetIcon("assets/icon/ppt_icon.png");
      case "pptx":
        return _assetIcon("assets/icon/ppt_icon.png");
      case "xls":
        return _assetIcon("assets/icon/xls_icon.png");
      case "zip":
        return _assetIcon("assets/icon/zip_icon.png");
      case "doc":
        return _assetIcon("assets/icon/doc_icon.png");
      case "mov":
        return _assetIcon("assets/icon/video_icon.png");
      case "mp3":
        return _assetIcon("assets/icon/mp3_icon.png");
      case "zip":
        return _assetIcon("assets/icon/zip_icon.png");
      default:
        return _assetIcon("assets/icon/text_icon.png");
    }
  }

  Widget _assetIcon(String ad) {
    return Image.asset(
      ad,
      height: 40,
      width: 40,
    );
  }

  // Future<void> openFile(String filePath) async {
  //   Dio dio = Dio();
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   final dirPath = '${dir.path}/${widget.messageData.messageJson?["file_name"]}';
  //   await dio.download(filePath, dirPath);
  //   await OpenFilex.open(dirPath);
  // }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
