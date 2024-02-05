class ChatTokenRequest {
  String? botId;
  String? cid;
  String? firstname;
  String? lastname;
  String? masterToken;
  String? urlApi;

  ChatTokenRequest({
    this.botId,
    this.cid,
    this.firstname,
    this.lastname,
    this.masterToken,
    this.urlApi,
  });

  ChatTokenRequest.fromJson(Map<String, dynamic> json) {
    botId = json['bot_id'];
    cid = json['cid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    masterToken = json['master_token'];
    urlApi = json['url_api'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bot_id'] = botId;
    data['cid'] = cid;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['master_token'] = masterToken;
    data['url_api'] = urlApi;
    return data;
  }
}
