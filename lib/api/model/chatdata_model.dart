class ChatDataModel {
  String? token;
  String? roomId;
  String? userId;

  ChatDataModel({this.token, this.roomId, this.userId});

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    roomId = json['room_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['room_id'] = this.roomId;
    data['user_id'] = this.userId;
    return data;
  }
}