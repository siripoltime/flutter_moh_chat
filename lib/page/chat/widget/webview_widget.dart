import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  final String urlString;

  const WebView({Key? key, required this.urlString}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = true;
  late InAppWebViewController _webViewController;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
  final GlobalKey webViewKey = GlobalKey();
  String dummyLoadUrlString = '';

  String appBarBgColorHex = '#000000';

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions initialOptions = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        mediaPlaybackRequiresUserGesture: false,
        // useOnDownloadStart: false,
        useOnDownloadStart: true,
        useOnLoadResource: true,
        // useShouldOverrideUrlLoading: true,
        useShouldOverrideUrlLoading: Platform.isIOS ? true : false,
        javaScriptCanOpenWindowsAutomatically: true,
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
        userAgent: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width > 600.0
            ? Platform.isIOS
                ? "Mozilla/5.0 (iPad; CPU OS 15_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1"
                : "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/1.0.9 Mobile Safari/604.1"
            : Platform.isIOS
                ? "Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Mobile/15E148 Safari/604.1"
                : "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/1.0.9 Mobile Safari/604.1",
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        supportMultipleWindows: false,
        geolocationEnabled: true,
        allowFileAccess: true,
        domStorageEnabled: true,
        safeBrowsingEnabled: true,
        databaseEnabled: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
        // allowsLinkPreview: true,
        // isFraudulentWebsiteWarningEnabled: true,
        // disableLongPressContextMenuOnLinks: true,
        // allowingReadAccessTo: Uri.parse('file://'),
      ));

  @override
  void dispose() {
    super.dispose();
    _webViewController.clearCache();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("webpage : ${widget.urlString}");
  }

  @override
  Widget build(BuildContext context) {
    // checkOrientation();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          title: const Text(''),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          shadowColor: Colors.transparent,
          elevation: 0,
          leading: Container(),
          actions: [
            IconButton(
              onPressed: () {
                Uri externalUrl = Uri.parse(Uri.encodeFull(widget.urlString));
                launchUrl(externalUrl, mode: LaunchMode.externalApplication);
              },
              icon: const Icon(Icons.open_in_browser),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Platform.isAndroid
              ? InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(widget.urlString),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                    ),
                  ),
                  gestureRecognizers: gestureRecognizers,
                  onWebViewCreated: (InAppWebViewController controller) {
                    setState(() {
                      _webViewController = controller;
                    });
                  },
                  androidOnPermissionRequest:
                      (InAppWebViewController controller, String origin, List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources, action: PermissionRequestResponseAction.GRANT);
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    if (progress == 100) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                )
              : InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(widget.urlString),
                  ),
                  initialOptions: initialOptions,
                  gestureRecognizers: gestureRecognizers,
                  onWebViewCreated: (webViewController) async {
                    // initialOptions.crossPlatform.transparentBackground = false;
                    // await webViewController.setOptions(options: initialOptions);
                    // cookieManager.deleteAllCookies();
                    setState(() {
                      _webViewController = webViewController;
                    });
                  },
                  onReceivedServerTrustAuthRequest: (controller, challenge) async {
                    debugPrint('challenge $challenge');
                    return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  onCreateWindow: (InAppWebViewController inAppWebViewController, createWindowRequest) async {
                    debugPrint('object onCreateWindow ${createWindowRequest.request.url}');
                    if (Platform.isIOS) {
                      await launchUrl(
                        createWindowRequest.request.url ?? Uri.parse(createWindowRequest.request.url.toString()),
                        mode: LaunchMode.platformDefault,
                      );
                      return true;
                    }
                    return null;
                  },
                  onDownloadStartRequest: (
                    controller,
                    request,
                  ) async {
                    debugPrint("onDownloadStart $request");
                    debugPrint("onDownloadStart ${request.url}");

                    if (Platform.isIOS) {
                      Uri loadUrlParse = Uri.parse(Uri.encodeFull(dummyLoadUrlString));
                      await launchUrl(
                        loadUrlParse,
                        mode: LaunchMode.platformDefault,
                      );
                    } else if (Platform.isAndroid) {
                      await launchUrl(
                        request.url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    if (progress == 100) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  androidOnPermissionRequest:
                      (InAppWebViewController controller, String origin, List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources, action: PermissionRequestResponseAction.GRANT);
                  },
                  androidOnGeolocationPermissionsShowPrompt: (InAppWebViewController controller, String origin) async {
                    return GeolocationPermissionShowPromptResponse(origin: origin, allow: true, retain: true);
                  },
                  onUpdateVisitedHistory: (InAppWebViewController controller, Uri? url, bool? androidIsReload) async {
                    var webUrl = url;
                    // print('webUrl $webUrl');
                    if (!["https", "file", "chrome", "data", "javascript", "blob", "about"].contains(webUrl?.scheme) &&
                        Platform.isAndroid) {
                      // if (await canLaunchUrl(webUrl!)) {
                      debugPrint('webUrl onUpdateVisitedHistory $webUrl');
                      // Launch the App
                      controller.goBack().then((value) async => {
                            await launchUrl(
                              webUrl!,
                              mode: LaunchMode.platformDefault,
                            )
                          });
                    }
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    var webUrl = navigationAction.request.url;
                    // print('webUrl $webUrl');
                    if (!["https", "file", "chrome", "data", "javascript", "blob", "about"].contains(webUrl?.scheme)) {
                      // if (await canLaunchUrl(webUrl!)) {
                      debugPrint('webUrl $webUrl');
                      // Launch the App
                      await launchUrl(
                        webUrl!,
                        mode: LaunchMode.platformDefault,
                      );
                      // await launchUrl(
                      //   webUrl,
                      // );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                      // }
                    } else if (webUrl!.path.contains('vcf')) {
                      await launchUrl(
                        webUrl,
                        mode: LaunchMode.externalApplication,
                      );
                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  // onCloseWindow: (InAppWebViewController webViewController){
                  // },
                  onLoadResource: (InAppWebViewController controller, LoadedResource resource) async {
                    var webUrl = resource.url;
                    debugPrint('onLoadResource $webUrl');
                    setState(() {
                      dummyLoadUrlString = webUrl.toString();
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {}),
          isLoading
              ? Center(
                  child: BenefitWidget.baseLoadingAnimation(),
                )
              : const Stack(),
        ],
      ),
    );
  }

  Future<void> reSetUpWebView() async {
    await _webViewController.setOptions(options: initialOptions);
    setState(() {});
  }

  checkOrientation() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      // ตรวจสอบว่าเป็นโหมด Tablet หรือไม่
      final screenSize = MediaQuery.of(context).size;
      final isTablet = screenSize.shortestSide > 600;

      // กำหนดให้แอปพลิเคชันสามารถหมุนจอได้เฉพาะในแพลตฟอร์ม Android และโหมด Tablet
      if (isTablet) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    }
  }

  Future<String> readFromLocalStorage(String key) async {
    final result = await _webViewController.evaluateJavascript(
      source: 'localStorage.getItem("$key");',
    );
    debugPrint('result : $result');
    return result;
  }
}
