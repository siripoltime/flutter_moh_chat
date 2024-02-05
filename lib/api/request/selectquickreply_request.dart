import 'package:uuid/uuid.dart';

class SelectQuickReplyRequest {
  String? label;
  String? type;
  String? message;
  String? payload;
  String messageUid = const Uuid().v4();

  SelectQuickReplyRequest({this.label, this.type, this.message, this.payload});

  SelectQuickReplyRequest.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    type = json['type'];
    message = json['message'];
    payload = json['payload'];
    messageUid = json['message_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['type'] = type;
    data['message'] = message;
    data['payload'] = payload;
    data['message_uid'] = messageUid;
    return data;
  }
}
