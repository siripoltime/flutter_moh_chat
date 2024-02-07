import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohpromt_chat/app.color.dart';
import 'package:mohpromt_chat/page/chat/widget/loadwidget.dart';
import 'package:mohpromt_chat/util/util.dart';
import 'package:shimmer/shimmer.dart';

//BenefitWidget.imageProfile
//Image.network
extension BenefitWidget on Widget {
  static Widget baseLoadingAnimation() {
    return const LoadWidget(
      width: 20,
    );
  }

  static Widget imageProfileMohpromt(context, double size) {
    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        radius: size * 0.60,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.asset('assets/logo_light.png', width: size, height: size),
        ),
      ),
    );
  }

  static Widget imageFlexibleSpace(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Util.maxWidthPadding(context)),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/headcontent.png"),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  static Widget imageLeading(context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: AppColor.transparent,
          // child: SvgPicture.asset("assets/chevron_left_mint.svg"),
          child: Image.asset('assets/logo_light.png'),
        ),
      ),
    );
  }

  static Widget imageProfile(context, double size, String url) {
    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        radius: size * 0.60,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
              imageUrl: url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade100,
                    child: Container(),
                  ),
              errorWidget: (context, error, stackTrace) {
                return CircleAvatar(
                  radius: size * 0.60,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: size * 0.77,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }),
        ),
      ),
    );
  }

  static Widget showImage(String filePath, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: filePath,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Container(
            color: Colors.grey.shade200,
          ),
        ),
        errorWidget: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade200,
            child: Center(
              child: Icon(
                Icons.error,
                color: Colors.grey.shade500,
              ),
            ),
          ); //do something
        },
      ),
    );
  }
}
