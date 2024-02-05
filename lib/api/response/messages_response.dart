import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/api/response/base_response.dart';

class MessagesResponse extends BaseResponse {
  List<MessageModel> messageList = [];

  MessagesResponse({dynamic json}) : super(json);

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    MessagesResponse response = MessagesResponse(json: json);
    if (json['data'] != null) {
      var list = json['data'] as List;
      List<MessageModel> typeList = list.map((data) => MessageModel.fromJson(data)).toList();
      response.messageList = typeList.reversed.toList();
    }

    return response;
  }
}
