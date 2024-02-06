import 'package:flutter/material.dart';
import 'package:mohpromt_chat/api/model/chatdata_model.dart';
import 'package:mohpromt_chat/api/request/chat_token_request.dart';
import 'package:mohpromt_chat/api/service/chat_service.dart';
import 'package:mohpromt_chat/navigation.dart';
import 'package:mohpromt_chat/page/chat/widget/alert_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //

  ChatTokenRequest request = ChatTokenRequest(
      //
      );

  //เข้าหน้าแชท
  Future<void> openChat(context) async {
    await setAPiChat(request.masterToken ?? "", request.urlApi ?? "");
    await ChatService.postChatToken(request).then((value) => {
          setState(() {
            if (value.message == "success") {
              Navigation.shared.toChatMessagePage(context, value.chatData ?? ChatDataModel());
            } else {
              Alert.showAlertDialogError(context, "Error", value.message ?? "");
            }
          })
        });
  }

  Future<void> setAPiChat(String masterToken, String urlApi) async {
    final prefs = await SharedPreferences.getInstance();
    String substr = "https://";
    String replace = "wss://";
    String centrifugeClient = urlApi.replaceFirst(substr, replace);
    prefs.setString('masterTokenChat', masterToken);
    prefs.setString('urlApiChat', "$urlApi/backend/api");
    prefs.setString('centrifugeChat', "$centrifugeClient/connection/websocket?format=protobuf");

    debugPrint("masterTokenChat : ${prefs.getString("masterTokenChat") ?? ""}");
    debugPrint("urlApiChat : ${prefs.getString("urlApiChat") ?? ""}");
    debugPrint("centrifugeChat : ${prefs.getString("centrifugeChat") ?? ""}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Example"),
      ),
      body: const Center(
        child: Text("Example"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openChat(context),
        tooltip: 'Chat',
        child: const Icon(Icons.messenger_outline_outlined),
      ),
    );
  }
}
