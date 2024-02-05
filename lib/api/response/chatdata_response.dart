import 'package:mohpromt_chat/api/model/chatdata_model.dart';
import 'package:mohpromt_chat/api/response/base_response.dart';
import 'package:mohpromt_chat/appManager/local_storage_manager.dart';

class ChatDataResponse extends BaseResponse {
  ChatDataModel? chatData;

  ChatDataResponse({dynamic json}) : super(json);

  factory ChatDataResponse.fromJson(Map<String, dynamic> json) {
    ChatDataResponse response = ChatDataResponse(json: json);
    if (json['data'] != null) {
      response.chatData = ChatDataModel.fromJson(json["data"]);
    }
    if (response.message == "success") {
      LocalStorageManager.saveChatData(ChatDataModel.fromJson(json["data"]));
    }

    return response;
  }
}
