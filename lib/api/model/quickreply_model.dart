import 'package:mohpromt_chat/api/model/message_model.dart';

class QuickReplyModel {
  int? seq;
  String? uid;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? roomId;
  String? userId;
  String? sender;
  String? senderType;
  String? message;
  List<Choice>? data;

  QuickReplyModel(
      {this.seq,
      this.uid,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.roomId,
      this.userId,
      this.sender,
      this.senderType,
      this.message,
      this.data});

  QuickReplyModel.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    uid = json['uid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    roomId = json['room_id'];
    userId = json['user_id'];
    sender = json['sender'];
    senderType = json['sender_type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Choice>[];
      json['data'].forEach((v) {
        data!.add(new Choice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seq'] = this.seq;
    data['uid'] = this.uid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['room_id'] = this.roomId;
    data['user_id'] = this.userId;
    data['sender'] = this.sender;
    data['sender_type'] = this.senderType;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
