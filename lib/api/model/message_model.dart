import 'package:mohpromt_chat/api/request/selectquickreply_request.dart';

class MessageModel {
  String? createdAt;
  String? deletedAt;
  bool? isShow;
  String? message;
  String? messageType;
  String? roomId;
  String? sender;
  String? senderType;
  int? seq;
  List<TemplateModel>? templateData = [];
  String? uid;
  String? updatedAt;
  String? url;
  String? messageUid = "";
  bool isLoading = false;
  bool isRetry = false;
  String sendType = "";
  SelectQuickReplyRequest quickreplyRequest = SelectQuickReplyRequest();

  MessageModel(
      {this.createdAt,
      this.deletedAt,
      this.isShow,
      this.message,
      this.messageType,
      this.roomId,
      this.sender,
      this.senderType,
      this.seq,
      this.templateData,
      this.uid,
      this.updatedAt,
      this.url,
      this.messageUid});

  MessageModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    isShow = json['is_show'];
    message = json['message'];
    messageType = json['message_type'];
    roomId = json['room_id'];
    sender = json['sender'];
    senderType = json['sender_type'];
    seq = json['seq'];
    if (json['template_data'] != null) {
      templateData = <TemplateModel>[];
      json['template_data'].forEach((v) {
        templateData!.add(TemplateModel.fromJson(v));
      });
    }
    uid = json['uid'];
    updatedAt = json['updated_at'];
    url = json['url'];
    messageUid = json['message_uid'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['is_show'] = isShow;
    data['message'] = message;
    data['message_type'] = messageType;
    data['room_id'] = roomId;
    data['sender'] = sender;
    data['sender_type'] = senderType;
    data['seq'] = seq;
    if (templateData != null) {
      data['template_data'] = templateData!.map((v) => v.toJson()).toList();
    }
    data['uid'] = uid;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    data['message_uid'] = messageUid;
    return data;
  }
}

class TemplateModel {
  List<Choice>? choice;
  String? createdAt;
  String? deletedAt;
  String? detail;
  String? image;
  String? messageId;
  int? seq;
  String? title;
  String? uid;
  String? updatedAt;

  TemplateModel(
      {this.choice,
      this.createdAt,
      this.deletedAt,
      this.detail,
      this.image,
      this.messageId,
      this.seq,
      this.title,
      this.uid,
      this.updatedAt});

  TemplateModel.fromJson(Map<String, dynamic> json) {
    if (json['choice'] != null) {
      choice = <Choice>[];
      json['choice'].forEach((v) {
        choice!.add(Choice.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    detail = json['detail'];
    image = json['image'];
    messageId = json['message_id'];
    seq = json['seq'];
    title = json['title'];
    uid = json['uid'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (choice != null) {
      data['choice'] = choice!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['detail'] = detail;
    data['image'] = image;
    data['message_id'] = messageId;
    data['seq'] = seq;
    data['title'] = title;
    data['uid'] = uid;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Choice {
  String? label;
  String? payload;
  String? type;
  String? url;

  Choice({this.label, this.payload, this.type, this.url});

  Choice.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    payload = json['payload'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['payload'] = payload;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
