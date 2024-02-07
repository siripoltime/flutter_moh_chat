import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohpromt_chat/api/api_manager.dart';
import 'package:mohpromt_chat/api/model/chatdata_model.dart';
import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/api/model/quickreply_model.dart';
import 'package:mohpromt_chat/api/request/message_request.dart';
import 'package:mohpromt_chat/api/request/selectquickreply_request.dart';
import 'package:mohpromt_chat/api/response/message_response.dart';
import 'package:mohpromt_chat/api/service/chat_service.dart';
import 'package:mohpromt_chat/app.color.dart';
import 'package:mohpromt_chat/appManager/format_time_notification.dart';
import 'package:mohpromt_chat/appManager/local_storage_manager.dart';
import 'package:mohpromt_chat/appManager/locale_string.dart';
import 'package:mohpromt_chat/layout/content.layout.dart';
import 'package:mohpromt_chat/layout/layout.type.dart';
import 'package:mohpromt_chat/page/chat/cell/defaultview_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/file_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/image_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/location_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/template_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/textview_message_cell.dart';
import 'package:mohpromt_chat/page/chat/cell/timetoday_message_cell.dart';
import 'package:mohpromt_chat/page/chat/menu_action.dart';
import 'package:mohpromt_chat/page/chat/widget/alert_widget.dart';
import 'package:mohpromt_chat/page/chat/widget/benefit_widget.dart';
import 'package:get/get.dart';
import 'package:mohpromt_chat/style/app.theme.dart';
import 'package:mohpromt_chat/util/util.dart';
import 'package:shimmer/shimmer.dart';
import '../../appManager/view_manager.dart';
import 'package:centrifuge/centrifuge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessagePage extends StatefulWidget {
  final ChatDataModel chatData;

  const ChatMessagePage({super.key, required this.chatData});

  @override
  ChatMessagePageState createState() => ChatMessagePageState();
}

class ChatMessagePageState extends State<ChatMessagePage> {
  double limitWidthMessage = 0.6;
  Locale locale = const Locale('th', 'TH');

  bool showMenuBar = false;
  bool showMediaIcon = true;
  bool showSendButton = false;
  bool isScrollDown = false;
  bool isScrollTime = false;

  bool isLoadData = true;
  bool loadmore = false;

  ScrollController scrollController = ScrollController();
  final msgTextField = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<MessageModel> messageList = [];
  List<Choice> quickreplyList = [];
  QuickReplyModel quickreplyData = QuickReplyModel();
  int indexTopWidget = 0;

  Client? client;

  ChatDataModel chatData = ChatDataModel();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    getChatData().then((value) {
      getChatMessages();
      getQuickReply();
      connectServer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    client?.disconnect();
  }

  Future<void> getChatData() async {
    await LocalStorageManager.getChatData().then((value) {
      chatData = value;
    });
  }

  Future<void> initCentrifuge() async {
    final prefs = await SharedPreferences.getInstance();
    String centrifugeClient = prefs.getString("centrifugeChat") ?? "";
    client = createClient(centrifugeClient)..setToken(ApiManager().centrifugeToken);
  }

  Future<void> connectServer() async {
    initCentrifuge().then((value) async {
      client?.connectStream.listen((event) {
        debugPrint("Connected to server ");
        subscribeMessage(ApiManager.eventMessage(chatData.roomId ?? ""));
        subscribeWebView(ApiManager.eventCloseWebView(chatData.roomId ?? ""));
        subscribeQuickReply(ApiManager.eventQuickReply(chatData.roomId ?? ""));
      });
      client?.disconnectStream.listen((event) {
        debugPrint("Disconnected from server ");
      });
      client?.errorStream.listen((event) {
        debugPrint(event.error);
      });
      await client?.connect();
    });
  }

  Future<void> subscribeMessage(String channel) async {
    debugPrint("Subscribing $channel");
    final subscriptionMessage = client?.getSubscription(channel);
    subscriptionMessage?.subscribeErrorStream.listen((event) => debugPrint);
    subscriptionMessage?.subscribeSuccessStream.listen((event) => debugPrint);
    subscriptionMessage?.unsubscribeStream.listen((event) => debugPrint);
    subscriptionMessage?.joinStream.listen((event) => debugPrint);
    subscriptionMessage?.leaveStream.listen((event) => debugPrint);
    subscriptionMessage?.publishStream.map<String>((e) => utf8.decode(e.data)).listen((data) {
      var valueMap = json.decode(data);
      MessageModel eventData = MessageModel.fromJson(valueMap);
      eventMessage(eventData);
    });
    await subscriptionMessage?.subscribe();
  }

  Future<void> subscribeWebView(String channel) async {
    debugPrint("Subscribing $channel");
    final subscriptionWebview = client?.getSubscription(channel);
    subscriptionWebview?.subscribeErrorStream.listen((event) => debugPrint);
    subscriptionWebview?.subscribeSuccessStream.listen((event) => debugPrint);
    subscriptionWebview?.unsubscribeStream.listen((event) => debugPrint);
    subscriptionWebview?.joinStream.listen((event) => debugPrint);
    subscriptionWebview?.leaveStream.listen((event) => debugPrint);
    subscriptionWebview?.publishStream.map<String>((e) => utf8.decode(e.data)).listen((data) {
      eventCloseWebView();
    });
    await subscriptionWebview?.subscribe();
  }

  Future<void> subscribeQuickReply(String channel) async {
    debugPrint("Subscribing $channel");
    final subscriptionWebview = client?.getSubscription(channel);
    subscriptionWebview?.subscribeErrorStream.listen((event) => debugPrint);
    subscriptionWebview?.subscribeSuccessStream.listen((event) => debugPrint);
    subscriptionWebview?.unsubscribeStream.listen((event) => debugPrint);
    subscriptionWebview?.joinStream.listen((event) => debugPrint);
    subscriptionWebview?.leaveStream.listen((event) => debugPrint);
    subscriptionWebview?.publishStream.map<String>((e) => utf8.decode(e.data)).listen((data) {
      var valueMap = json.decode(data);
      setState(() {
        debugPrint("QuickReply");
        quickreplyData = QuickReplyModel.fromJson(valueMap);
        if (valueMap['data'] != null) {
          var list = valueMap["data"] as List;
          List<Choice> typeList = list.map((data) => Choice.fromJson(data)).toList();
          quickreplyList = typeList;
        }
      });
    });
    await subscriptionWebview?.subscribe();
  }

  eventMessage(MessageModel data) {
    debugPrint('eventMessage');
    setState(() {
      addNewMessage(data);
    });
  }

  eventCloseWebView() {
    debugPrint('eventCloseWebView');
    setState(() {
      Navigator.of(context).pop();
    });
  }

  addNewMessage(MessageModel data) async {
    if (data.messageUid == "") {
      int index = messageList.indexWhere((element) => (element.uid == data.uid));
      if (index >= 0) {
        messageList[index] = data;
      } else {
        messageList.insert(0, data);
      }
    } else {
      int index = messageList.indexWhere((element) => element.uid == data.uid || element.messageUid == data.messageUid);
      if (index >= 0) {
        messageList[index] = data;
      } else {
        messageList.insert(0, data);
      }
    }
  }

  _scrollListener() {
    if (scrollController.position.activity?.runtimeType == DragScrollActivity ||
        (scrollController.position.activity?.velocity ?? 0) != 0)
      setState(() {
        isScrollTime = true;
      });
    else {
      setState(() {
        isScrollTime = false;
      });
    }

    if (scrollController.offset > 500) {
      setState(() {
        isScrollDown = true;
      });
    } else {
      setState(() {
        isScrollDown = false;
      });
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent && !loadmore && messageList.isNotEmpty) {
      setState(() {
        getAddChatMessages();
      });
    }
  }

  getChatMessages() async {
    await ChatService.getChatMessage("0").then((value) => {
          setState(() {
            if (value.message == "success") {
              messageList = value.messageList;
              isLoadData = false;
            } else {
              Alert.showAlertDialogError(context, "Error", value.message ?? "");
              isLoadData = false;
            }
          })
        });
  }

  getAddChatMessages() async {
    String timestamp = messageList.last.createdAt ?? "";
    setState(() {
      loadmore = true;
    });
    await ChatService.getChatMessage(timestamp).then((value) => {
          setState(() {
            if (value.message == "success") {
              messageList.addAll(value.messageList);
              loadmore = false;
            } else {
              Alert.showAlertDialogError(context, "Error", value.message ?? "");
              loadmore = false;
            }
          })
        });
  }

  getQuickReply() async {
    await ChatService.getQuickReply().then((value) => {
          setState(() {
            quickreplyData = value.quickreplyData ?? QuickReplyModel();
            quickreplyList = value.quickreplyList;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: const Locale('th', 'TH'),
      theme: AppTheme.theme(context),
      debugShowCheckedModeBanner: false,
      home: ContentLayout(
        title: 'หมอพร้อม',
        type: LayoutType.light,
        padding: EdgeInsets.zero,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: Util.maxWidthPadding(context)),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/headcontent.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(5),
              color: AppColor.transparent,
              child: SvgPicture.asset("assets/chevron_left_mint.svg"),
            ),
          ),
        ),
        child: SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: isLoadData
                          ? _shimmer(double.infinity)
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  showMediaIcon = true;
                                  _focusNode.unfocus();
                                });
                              },
                              child: Container(
                                child: buildListMessage(),
                              ),
                            ),
                    ),
                    Container(alignment: Alignment.topCenter, child: _timeMessageChat()),
                    Container(alignment: Alignment.bottomCenter, child: _bottomScrollDown()),
                  ],
                ),
              ),
              _quickReplyBar(),
              _tapbar(),
              // _menuBar(),
            ],
          ),
        ),
        // child: Scaffold(
        //   backgroundColor: ColorManager().backgroundColor,
        //   appBar: AppBar(
        //     centerTitle: false,
        //     titleSpacing: 0.0,
        //     title: _cardProfile(),
        //     backgroundColor: ColorManager().primaryColor,
        //     leading: BackButton(
        //       color: ColorManager().secondaryColor,
        //       onPressed: () {
        //         setState(() {
        //           Navigator.pop(context);
        //         });
        //       },
        //     ),
        //   ),
        //   body:
        // ),
      ),
    );
  }

  _tapbar() {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: null,
        color: ColorManager().secondaryColor,
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextField(),
                  Visibility(
                    // visible: showSendButton && !showMediaIcon,
                    visible: true,
                    child: SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (msgTextField.text.trim().isNotEmpty) {
                              sendMessage();
                            }
                          });
                        },
                        icon: const Icon(Icons.send),
                        iconSize: 27,
                        color: ColorManager().primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeMessageChat() {
    return AnimatedOpacity(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      opacity: isScrollTime ? 1 : 0,
      child: messageList.isNotEmpty && (messageList.length > indexTopWidget)
          ? Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              margin: const EdgeInsets.only(
                top: 8,
              ),
              decoration: BoxDecoration(
                color: ColorManager().primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(TimeExtension.timeAgoChat(messageList[indexTopWidget].createdAt ?? "", locale),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: FontSizeManager().textMSize, color: Colors.white)),
            )
          : Container(),
    );
  }

  Widget _bottomScrollDown() {
    return AnimatedOpacity(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      opacity: isScrollDown ? 1 : 0,
      child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager().primaryColor, width: 1.0),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(500.0),
                onTap: () {
                  _scrollDown();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_downward,
                    size: 30.0,
                    color: ColorManager().primaryColor,
                  ),
                ),
              ),
            ),
          )),
    );
  }

  _quickReplyBar() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: Container(
        color: Colors.transparent,
        height: quickreplyList.isNotEmpty ? 70 : 0,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: quickreplyList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 12, bottom: 12, right: 4, left: index == 0 ? 8 : 4),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager().secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ColorManager().primaryColor, width: 1.5)),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      highlightColor: ColorManager().primaryColor.withOpacity(0.8),
                      onTap: () {
                        setState(() {
                          selectedQuickReply(quickreplyList[index]);
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          alignment: Alignment.center,
                          child: Text(quickreplyList[index].label ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeManager().textMSize,
                                color: ColorManager().primaryColor,
                              ))),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _buildTextField() {
    return Flexible(
        child: Container(
      padding: const EdgeInsets.only(left: 15, right: 8, top: 4, bottom: 4),
      margin: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          color: ColorManager().secondaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.3))),
      child: Stack(
        children: [
          Positioned(
            child: TextField(
              style: const TextStyle(
                fontSize: 16,
              ),
              controller: msgTextField,
              focusNode: _focusNode,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              cursorColor: ColorManager().primaryColor,
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "typeText".tr,
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),
                isDense: true,
                // Added this
                contentPadding: const EdgeInsets.all(8),
              ),
              // onSubmitted: (_) => sendMessage(),
              onChanged: (text) {
                setState(() {
                  showSendButton = (text != "");
                  showMediaIcon = false;
                });
              },
              onTap: () {
                setState(() {
                  showMenuBar = false;
                  showMediaIcon = false;
                });
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildListMessage() {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: messageList.length,
        shrinkWrap: true,
        reverse: true,
        controller: scrollController,
        itemBuilder: (context, index) {
          indexTopWidget = index;
          bool isStackMessage = false;
          bool isMe = widget.chatData.userId == messageList[index].sender;
          if (!isMe) {
            if (index < messageList.length - 1) {
              if ((messageList[index].sender == messageList[index + 1].sender) &&
                  messageList[index + 1].messageType != "unsend" &&
                  messageList[index + 1].messageType != "info") {
                if (TimeExtension.isTimeToMinute(
                    messageList[index].createdAt ?? "", messageList[index + 1].createdAt ?? "", locale)) {
                  isStackMessage = true;
                }
              }
            }
          }

          return Column(
            children: [
              Visibility(
                  visible: messageList.length == index + 1,
                  child: loadmore
                      ? Container(
                          height: 70,
                          alignment: Alignment.center,
                          child:
                              Container(padding: const EdgeInsets.all(16), child: BenefitWidget.baseLoadingAnimation()),
                        )
                      : Container(height: 40)),
              timeToDayCell(index, messageList),
              Row(
                children: [
                  Expanded(child: viewMessageCell(messageList, messageList[index], isStackMessage, index)),
                ],
              )
            ],
          );
        });
  }

  Widget timeToDayCell(int index, List<MessageModel> messageListData) {
    if (messageListData.isEmpty) {
      return Container();
    } else if (messageListData.length == index + 1) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            TimeExtension.timeAgoChat(messageListData[index].createdAt ?? "", locale),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
      );
    } else {
      return TimeToDayMessageCell(
          timeA: messageListData[index].createdAt ?? "",
          timeB: messageListData[index + 1].createdAt ?? "",
          locale: locale);
    }
  }

  Widget viewMessageCell(List<MessageModel> messageListData, MessageModel messageData, bool isStackMessage, int index) {
    bool isMe = widget.chatData.userId == messageData.sender;

    switch (messageData.messageType) {
      case "text":
        return DefaulViewMessageCell(
          isStackMessage: isStackMessage,
          isMe: isMe,
          locale: locale,
          messageData: messageData,
          maxWidth: limitWidthMessage,
          isHideColor: false,
          dataView: TextViewMessageCell(
            isMe: isMe,
            messageData: messageData,
          ),
          callBackFuncRetry: () {
            setState(() {
              sendRetryData(messageData);
            });
          },
        );
      case "image":
        return DefaulViewMessageCell(
          isStackMessage: isStackMessage,
          isMe: isMe,
          locale: locale,
          messageData: messageData,
          maxWidth: limitWidthMessage,
          isHideColor: false,
          dataView: ImageMessageCell(
            isMe: isMe,
            messageData: messageData,
          ),
          callBackFuncRetry: () {},
        );
      case "file":
        return DefaulViewMessageCell(
          isStackMessage: isStackMessage,
          isMe: isMe,
          locale: locale,
          messageData: messageData,
          maxWidth: limitWidthMessage,
          isHideColor: false,
          dataView: FileMessageCell(
            isMe: isMe,
            messageData: messageData,
          ),
          callBackFuncRetry: () {},
        );
      case "location":
        return DefaulViewMessageCell(
          isStackMessage: isStackMessage,
          isMe: isMe,
          locale: locale,
          messageData: messageData,
          maxWidth: limitWidthMessage,
          isHideColor: false,
          dataView: LocationMessageCell(
            isMe: isMe,
            messageData: messageData,
          ),
          callBackFuncRetry: () {},
        );
      case "template":
        List<TemplateModel> templateData = [];
        if (messageData.templateData != null) {
          templateData = messageData.templateData ?? [];
        }
        return DefaulViewMessageCell(
          isStackMessage: false,
          isMe: isMe,
          locale: locale,
          messageData: messageData,
          maxWidth: limitWidthMessage,
          isHideColor: true,
          isTemplate: true,
          isManyTemplate: templateData.length > 1 ? true : false,
          dataView: TemplateMessageCell(
            isMe: isMe,
            messageData: messageData,
            templateList: templateData,
            callBackFunc: (choice) {
              selectedQuickReply(choice);
            },
          ),
          callBackFuncRetry: () {},
        );
      default:
        return Container();
    }
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

  Future<void> sendMessage() async {
    _scrollDown();
    sendMessageRequest request = sendMessageRequest();
    request.message = msgTextField.text.trim();
    MessageModel data = MessageModel();
    data.isLoading = true;
    data.message = request.message;
    data.messageType = "text";
    data.roomId = chatData.roomId;
    data.sender = chatData.userId;
    data.senderType = "user";
    data.messageUid = request.messageUid;
    data.createdAt = DateTime.now().toIso8601String();
    data.updatedAt = DateTime.now().toIso8601String();
    data.sendType = "message";

    messageList.insert(0, data);

    ChatService.postChatMessage(
      request,
    ).then((value) {
      setState(() {
        setSendSuccess(value, request.messageUid);
      });
    });

    msgTextField.clear();
    showSendButton = false;
  }

  Future<void> selectedQuickReply(Choice choice) async {
    if (choice.type == "text") {
      SelectQuickReplyRequest request = SelectQuickReplyRequest();

      request.type = choice.type;
      request.label = choice.label;
      request.message = choice.label;
      request.payload = choice.payload;

      MessageModel data = MessageModel();
      data.isLoading = true;
      data.message = request.message;
      data.messageType = "text";
      data.roomId = chatData.roomId;
      data.sender = chatData.userId;
      data.senderType = "user";
      data.messageUid = request.messageUid;
      data.createdAt = DateTime.now().toIso8601String();
      data.updatedAt = DateTime.now().toIso8601String();
      data.sendType = "quickreply";
      data.quickreplyRequest = request;

      messageList.insert(0, data);

      ChatService.selectedQuickReply(
        request,
      ).then((value) {
        setState(() {
          quickreplyList = [];
          quickreplyData = QuickReplyModel();
          setSendSuccess(value, request.messageUid);
        });
      });
    } else if (choice.type == "link") {
      _focusNode.unfocus();
      MenuAction.openLinkView(context, choice.url ?? "");
    } else if (choice.type == "webview") {
      _focusNode.unfocus();
      MenuAction.openWebView(context, choice.url ?? "");
    }
  }

  setSendSuccess(
    MessageResponse value,
    String messageUid,
  ) {
    setState(() {
      int index = messageList.indexWhere((element) => element.messageUid == messageUid);
      if (value.message == "success") {
        if (index >= 0) {
          setState(() {
            messageList[index].isLoading = false;
            messageList[index] = value.messageData ?? MessageModel();
          });
        }
      } else {
        if (index >= 0) {
          setState(() {
            messageList[index].isLoading = false;
            messageList[index].isRetry = true;
          });
        }
      }
    });
  }

  sendRetryData(MessageModel messageData) {
    _scrollDown();
    MessageModel data = MessageModel();
    data = messageData;
    data.isRetry = false;
    data.isLoading = true;
    messageList.remove(messageData);
    messageList.insert(0, data);

    if (messageData.sendType == "message") {
      sendMessageRequest request = sendMessageRequest();
      request.message = messageData.message ?? "";
      request.messageUid = messageData.messageUid ?? "";

      ChatService.postChatMessage(
        request,
      ).then((value) {
        setState(() {
          setSendSuccess(value, request.messageUid);
        });
      });
    } else if (messageData.sendType == "quickreply") {
      SelectQuickReplyRequest request = SelectQuickReplyRequest();
      request = messageData.quickreplyRequest;

      ChatService.selectedQuickReply(
        request,
      ).then((value) {
        setState(() {
          setSendSuccess(value, request.messageUid);
        });
      });
    } else {}
  }

  Widget _shimmer(double height) {
    return Shimmer.fromColors(
        baseColor: ColorManager().secondaryColor,
        highlightColor: Colors.grey.shade200,
        child: Container(
          color: Colors.white,
          height: height,
        ));
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
