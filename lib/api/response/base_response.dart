class BaseResponse {
  int? status = 200;
  String? message = "";

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(json);
  }

  BaseResponse(Map<String, dynamic> json) {
    status = json["status"] as int;
    message = json["message"] as String;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["success"]["status"] = status;
    data["success"]["message"] = message;

    return data;
  }
}
