import 'package:uuid/uuid.dart';

class sendMessageRequest {
  String message = "";
  String messageUid = Uuid().v4();

  Map<String, String> toJson() {
    Map<String, String> data = Map<String, String>();
    data["message"] = message;
    data["message_uid"] = messageUid;

    return data;
  }
}
