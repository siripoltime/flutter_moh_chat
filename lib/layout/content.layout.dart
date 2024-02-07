import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohpromt_chat/app.color.dart';
import 'package:mohpromt_chat/layout/layout.type.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';

class ContentLayout extends StatelessWidget {
  final String? title;
  final bool isTitle;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final LayoutType type;
  final List<Widget>? actions;
  final Color color;
  final Widget? leading;
  final Widget? flexibleSpace;
  const ContentLayout({
    Key? key,
    this.title,
    this.actions,
    this.isTitle = true,
    this.padding = const EdgeInsets.all(16),
    this.type = LayoutType.none,
    this.color = AppColor.background,
    required this.child,
    this.leading,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: isTitle
          ? AppBar(
              title: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 8), child: BenefitWidget.imageProfileMohpromt(context, 40)),
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
              flexibleSpace: flexibleSpace,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              titleSpacing: (canPop) ? 0 : 16,
              leading: leading,
              // leading: Padding(
              //   padding: const EdgeInsets.all(5),
              //   child: GestureDetector(
              //     onTap: () => Navigator.pop(context),
              //     child: Container(
              //       padding: const EdgeInsets.all(5),
              //       color: AppColor.transparent,
              //       child: SvgPicture.asset("assets/chevron_left_mint.svg"),
              //     ),
              //   ),
              // ),
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
    );
  }
}
