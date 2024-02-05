import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mohpromt_chat/appManager/local_storage_manager.dart';

class ApiManager {
  // String get domainManageV1 {
  //   return "https://onechat-moph.inet.co.th/backend/api/v1/";
  // }

  // String get centrifugeClient {
  //   return "wss://onechat-moph.inet.co.th/connection/websocket?format=protobuf";
  // }

  String get centrifugeToken {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbmRyb2lkIn0.yanfKA-HRl2a5NaVql4ngpTBCV5Pz8uD0E-PGatEaKc";
  }

  ///chat
  static String postChatToken = '/v1/service/token';
  static String getChatMessage = '/v1/onechat/message';
  static String postChatMessage = '/v1/onechat/push-message';
  static String selectedQuickReply = '/v1/onechat/selected-quick-reply';
  static String getQuickReply = '/v1/onechat/quick-reply';

  ///event-chat
  static String eventMessage(String roomId) {
    return "message-$roomId";
  }

  static String eventCloseWebView(String roomId) {
    return "close-webview-$roomId";
  }

  static String eventQuickReply(String roomId) {
    return "quickreply-$roomId";
  }

  // static String masterToken =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbnYiOiJwcm8iLCJzZXJ2aWNlIjoiTW9waCJ9.jq1ha3f2PrB6nSSczHpul7yYpMLKpXsW3ln-PB8nSCQ';

  Future<dynamic> requestPostChatToken(String domain, String apiName, Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    Uri domainUri = Uri.parse(domain + apiName);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString("masterTokenChat") ?? ""}'
    };
    // debugPrint(body);
    try {
      http.Response response = await http.post(domainUri, headers: headers, body: jsonEncode(body));
      var responseBody = response.body;
      if (response.statusCode == 200) {
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      } else {
        debugPrint("Error : Status ${response.statusCode} ");
        debugPrint("body : ${body}");
        debugPrint("responseBody : ${responseBody}");
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      }
    } catch (err) {
      Map<String, dynamic> data = {"status": 404, "message": "not found", "data": null};
      return data;
    }
  }

  Future<dynamic> requestPostChat(String domain, String apiName, Map<String, dynamic> body) async {
    String accessToken = "";
    Uri domainUri = Uri.parse(domain + apiName);
    await LocalStorageManager.getChatData().then((value) => {
          accessToken = value.token ?? "",
        });
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(domainUri, headers: headers, body: jsonEncode(body));
      var responseBody = response.body;
      debugPrint('domainUri $domainUri');
      debugPrint('accessToken $accessToken');
      debugPrint('response.body ${response.body}');
      debugPrint('response.statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      } else {
        debugPrint("Error : Status ${response.statusCode} ");
        debugPrint("responseBody : $responseBody");
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      }
    } catch (err) {
      Map<String, dynamic> data = {"status": 404, "message": "not found", "data": null};
      return data;
    }
  }

  Future<dynamic> requestGetChat(String domain, String apiName) async {
    String accessToken = "";

    await LocalStorageManager.getChatData().then((value) => {
          accessToken = value.token ?? "",
        });
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken'
    };
    try {
      Uri domainUri = Uri.parse(domain + apiName);
      http.Response response = await http.get(domainUri, headers: header);
      debugPrint('domainUri $domainUri');
      debugPrint('accessToken $accessToken');
      debugPrint('response.body ${response.body}');
      debugPrint('response.statusCode ${response.statusCode}');
      var responseBody = response.body;
      if (response.statusCode == 200) {
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      } else {
        debugPrint("Error : Status ${response.statusCode} ");
        debugPrint("responseBody : $responseBody");
        var jsonBody = json.decode(utf8.decode(response.bodyBytes));
        return jsonBody;
      }
    } catch (err) {
      Map<String, dynamic> data = {"status": 404, "message": "not found", "data": null};
      return data;
    }
  }
}
