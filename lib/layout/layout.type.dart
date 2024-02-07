import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohpromt_chat/app.color.dart';

enum LayoutType {
  none,
  light,
  green,
  blue,
}

class ColorType {
  ColorType();
  static List<Color> radius(LayoutType type) {
    switch (type) {
      case LayoutType.light:
        return [AppColor.light, AppColor.light];
      case LayoutType.blue:
        return [AppColor.gradientBlue, AppColor.gradientBlueDark];
      case LayoutType.green:
        return [AppColor.gradientGreen, AppColor.gradientGreenDark];
      default:
        return [AppColor.transparent, AppColor.transparent];
    }
  }
}

class LayoutWidget {
  static Decoration bodyDecoration(BuildContext context, {required LayoutType type}) {
    if (type == LayoutType.none) {
      return const BoxDecoration(color: AppColor.transparent);
    } else {
      return BoxDecoration(
        color: ColorType.radius(type).elementAt(1),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ColorType.radius(type),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );
    }
  }
}

class WidgetSwitcher extends StatelessWidget {
  final int duration;
  final Widget child;
  const WidgetSwitcher({
    Key? key,
    this.duration = 200,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration),
      child: child,
    );
  }
}

class BtnBack extends StatelessWidget {
  const BtnBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: AppColor.transparent,
          child: SvgPicture.asset("assets/chevron_left_mint.svg"),
        ),
      ),
    );
  }
}
