import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/api/response/base_response.dart';

class MessageResponse extends BaseResponse {
  MessageModel? messageData;

  MessageResponse({dynamic json}) : super(json);

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    MessageResponse response = MessageResponse(json: json);
    if (json["data"] != null) {
      response.messageData = MessageModel.fromJson(json["data"]);
    }
    return response;
  }
}
