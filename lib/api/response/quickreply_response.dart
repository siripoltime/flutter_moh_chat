import 'package:mohpromt_chat/api/model/message_model.dart';
import 'package:mohpromt_chat/api/model/quickreply_model.dart';
import 'package:mohpromt_chat/api/response/base_response.dart';

class QuickReplyResponse extends BaseResponse {
  QuickReplyModel? quickreplyData;
  List<Choice> quickreplyList = [];

  QuickReplyResponse({dynamic json}) : super(json);

  factory QuickReplyResponse.fromJson(Map<String, dynamic> json) {
    QuickReplyResponse response = QuickReplyResponse(json: json);
    if (json['data'] != null) {
      response.quickreplyData = QuickReplyModel.fromJson(json['data']);
      if (json['data']["data"] != null) {
        var list = json['data']["data"] as List;
        List<Choice> typeList = list.map((data) => Choice.fromJson(data)).toList();
        response.quickreplyList = typeList;
      }
    }

    return response;
  }
}
