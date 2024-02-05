import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/appManager/view_manager.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';

class TemplateMessageCell extends StatefulWidget {
  final bool isMe;
  final MessageModel messageData;
  final List<TemplateModel> templateList;
  final Function(Choice) callBackFunc;

  const TemplateMessageCell({
    super.key,
    this.isMe = false,
    required this.messageData,
    required this.templateList,
    required this.callBackFunc,
  });

  @override
  TemplateMessageCellState createState() => TemplateMessageCellState();
}

class TemplateMessageCellState extends State<TemplateMessageCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width <= 380
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width > 430
            ? MediaQuery.of(context).size.width * 0.35
            : MediaQuery.of(context).size.width * 0.55;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < widget.templateList.length; i++)
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21.5),
                  border: Border.all(color: ColorManager().primaryColor, width: 1.5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BenefitWidget.showImage(widget.templateList[i].image ?? "", width, width * 0.8),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.templateList[i].title ?? "",
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSizeManager().textMSize,
                                  color: ColorManager().primaryColor)),
                          Text(widget.templateList[i].detail ?? "",
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: FontSizeManager().textMSize,
                                  color: Colors.black)),
                          Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: choiceView(widget.templateList[i].choice ?? []))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget choiceView(List<Choice> choice) {
    return Column(
      children: [
        for (int i = 0; i < choice.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              color: ColorManager().primaryColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  widget.callBackFunc(choice[i]);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(choice[i].label ?? "",
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: FontSizeManager().textMSize, color: Colors.white)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
