import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mohpromt_chat/app.color.dart';

class LoadWidget extends StatefulWidget {
  final String message;
  final double width;
  final double padding;
  final List<Color> colors;
  const LoadWidget({
    Key? key,
    this.message = "",
    this.width = 70,
    this.padding = 10,
    this.colors = const [AppColor.primary],
  }) : super(key: key);

  @override
  State<LoadWidget> createState() => LoadWidgetState();
}

class LoadWidgetState extends State<LoadWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.message.isNotEmpty) {
      return Center(child: Padding(padding: EdgeInsets.all(widget.padding), child: Text(widget.message)));
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: SizedBox(
            width: widget.width,
            height: widget.width,
            child: LoadingIndicator(
              indicatorType: Indicator.lineSpinFadeLoader,
              colors: widget.colors,
            ),
          ),
        ),
      );
    }
  }
}
