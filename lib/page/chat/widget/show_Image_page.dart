import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohpromt_chat/appManager/view_manager.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';
import 'package:photo_view/photo_view.dart';

class showImagePage extends StatefulWidget {
  final String imageLink;

  showImagePage({
    required this.imageLink,
  });

  @override
  showImagePageState createState() => showImagePageState();
}

class showImagePageState extends State<showImagePage> {
  Locale locale = Locale('en', 'US');
  double textScale = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(textScaleFactor: textScale),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: ColorManager().backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0.0,
          title: _cardProfile(),
          backgroundColor: ColorManager().primaryColor,
          leading: BackButton(
            color: ColorManager().secondaryColor,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: PhotoView(
              backgroundDecoration: BoxDecoration(
                color: ColorManager().backgroundColor,
              ),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              // enableRotation: true,
              imageProvider: CachedNetworkImageProvider(widget.imageLink)),
        ),
      ),
    );
  }

  Widget _cardProfile() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(padding: const EdgeInsets.only(right: 8), child: BenefitWidget.imageProfileMohpromt(context, 40)),
          Expanded(
            child: Text(
              "หมอพร้อม",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizeManager().defaultSize,
                  color: ColorManager().secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
