import 'package:flutter/material.dart';
import 'package:mohpromt_chat/page/chat/widget/webview_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuAction {
  static openLinkView(BuildContext context, String url) {
    Uri mainUrl = Uri.parse(url);
    openLaunchUrl(mainUrl);
  }

  static openLaunchUrl(Uri mainUrl) async {
    await launchUrl(
      mainUrl,
      mode: LaunchMode.externalApplication,
    );
  }

  static openWebView(BuildContext context, String url) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (builder) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: WebView(
                urlString: url,
              ),
            ));
      },
    );
  }
}
