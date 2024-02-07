import 'package:flutter/material.dart';
import 'package:mohpromt_chat/app.color.dart';
import 'package:mohpromt_chat/layout/layout.type.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';
import 'package:mohpromt_chat/util/util.dart';

class ContentLayout extends StatelessWidget {
  final String? title;
  final bool isTitle;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final LayoutType type;
  final List<Widget>? actions;
  final Color color;

  const ContentLayout({
    Key? key,
    this.title,
    this.actions,
    this.isTitle = true,
    this.padding = const EdgeInsets.all(16),
    this.type = LayoutType.none,
    this.color = AppColor.background,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return Material(
      color: color,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Util.maxWidthPadding(context)),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/head=content.png"),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: isTitle
              ? AppBar(
                  title: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: BenefitWidget.imageProfileMohpromt(context, 40)),
                      Text(
                        title ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColor.dark,
                        ),
                      ),
                    ],
                  ),
                  flexibleSpace: Container(color: AppColor.transparent),
                  automaticallyImplyLeading: false,
                  titleSpacing: (canPop) ? 0 : 16,
                  leading: const BtnBack(),
                  actions: actions,
                )
              : null,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: padding,
              height: double.infinity,
              alignment: Alignment.topCenter,
              decoration: LayoutWidget.bodyDecoration(context, type: type),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
