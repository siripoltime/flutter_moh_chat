import 'package:mohpromt_chat/api/api_manager.dart';
import 'package:mohpromt_chat/api/request/chat_token_request.dart';
import 'package:mohpromt_chat/api/request/message_request.dart';
import 'package:mohpromt_chat/api/request/selectquickreply_request.dart';
import 'package:mohpromt_chat/api/response/chatdata_response.dart';
import 'package:mohpromt_chat/api/response/message_response.dart';
import 'package:mohpromt_chat/api/response/messages_response.dart';
import 'package:mohpromt_chat/api/response/quickreply_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static Future<ChatDataResponse> postChatToken(ChatTokenRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await ApiManager()
        .requestPostChatToken(prefs.getString("urlApiChat") ?? "", ApiManager.postChatToken, request.toJson());
    return ChatDataResponse.fromJson(response);
  }

  static Future<MessagesResponse> getChatMessage(String timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await ApiManager().requestGetChat(
      prefs.getString("urlApiChat") ?? "",
      "${ApiManager.getChatMessage}?timestamp=$timestamp",
    );
    return MessagesResponse.fromJson(response);
  }

  static Future<MessageResponse> postChatMessage(sendMessageRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await ApiManager()
        .requestPostChat(prefs.getString("urlApiChat") ?? "", ApiManager.postChatMessage, request.toJson());
    return MessageResponse.fromJson(response);
  }

  static Future<MessageResponse> selectedQuickReply(SelectQuickReplyRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await ApiManager()
        .requestPostChat(prefs.getString("urlApiChat") ?? "", ApiManager.selectedQuickReply, request.toJson());
    return MessageResponse.fromJson(response);
  }

  static Future<QuickReplyResponse> getQuickReply() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await ApiManager().requestGetChat(
      prefs.getString("urlApiChat") ?? "",
      ApiManager.getQuickReply,
    );
    return QuickReplyResponse.fromJson(response);
  }
}
