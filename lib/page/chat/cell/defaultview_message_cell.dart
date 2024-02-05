import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/appManager/format_time_notification.dart';
import 'package:mohpromt_chat/appManager/view_manager.dart';
import 'package:get/get.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';

class DefaulViewMessageCell extends StatefulWidget {
  final bool isMe;
  final Locale locale;
  final MessageModel messageData;
  final Widget dataView;
  final double maxWidth;
  final bool isHideColor;
  final bool isStackMessage;
  final bool isTemplate;
  final bool isManyTemplate;
  final Function() callBackFuncRetry;

  const DefaulViewMessageCell(
      {super.key,
      this.isMe = false,
      required this.locale,
      required this.messageData,
      required this.dataView,
      required this.maxWidth,
      this.isHideColor = false,
      required this.isStackMessage,
      this.isTemplate = false,
      this.isManyTemplate = false,
      required this.callBackFuncRetry});

  @override
  DefaulViewMessageCellState createState() => DefaulViewMessageCellState();
}

class DefaulViewMessageCellState extends State<DefaulViewMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: widget.isMe
          ? widget.isTemplate && widget.isManyTemplate
              ? outGoingTemplateWidget()
              : outGoingWidget()
          : widget.isTemplate && widget.isManyTemplate
              ? inComingTemplateWidget()
              : inComingWidget(),
    );
  }

  Widget outGoingWidget() {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (widget.messageData.isRetry)
              ? AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    padding: const EdgeInsets.only(right: 4, bottom: 4),
                    height: (widget.messageData.isRetry) ? null : 0,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.callBackFuncRetry();
                            });
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ))
              : (widget.messageData.isLoading)
                  ? Container(
                      height: 18,
                      width: 18,
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      child: BenefitWidget.baseLoadingAnimation())
                  : Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 4),
                            child: dateTimeSet(),
                          ),
                        ],
                      ),
                    ),
          Container(
            decoration: BoxDecoration(
              color: widget.isHideColor ? null : ColorManager().primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: BoxConstraints(
              minHeight: 30,
              minWidth: 10,
              maxWidth: MediaQuery.of(context).size.width * widget.maxWidth,
            ),
            child: widget.dataView,
          ),
        ],
      ),
    );
  }

  Widget inComingWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(right: 4),
              child: widget.isStackMessage
                  ? Container(
                      width: 45,
                    )
                  : BenefitWidget.imageProfileMohpromt(context, 45)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !widget.isStackMessage,
                child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      "Mohpromt".tr,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeManager().textLSize,
                          color: ColorManager().primaryColor),
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.isHideColor ? null : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: BoxConstraints(
                      minHeight: 30,
                      minWidth: 10,
                      maxWidth: MediaQuery.of(context).size.width * widget.maxWidth,
                    ),
                    child: widget.dataView,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 4),
                    child: dateTimeSet(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget outGoingTemplateWidget() {
    return Container();
  }

  Widget inComingTemplateWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.only(right: 4), child: BenefitWidget.imageProfileMohpromt(context, 45)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      "Mohpromt".tr,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeManager().textLSize,
                          color: ColorManager().primaryColor),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: widget.isHideColor ? null : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.dataView,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16, top: 4),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(left: 4),
                  child: dateTimeSet(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dateTimeSet() {
    return Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        TimeExtension.setTimejm(widget.messageData.createdAt ?? "", widget.locale),
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: FontSizeManager().textSSize, color: Colors.grey.withOpacity(0.8)));
  }
}
