// To parse this JSON data, do
//
//     final chatRequestResponse = chatRequestResponseFromJson(jsonString);

import 'dart:convert';

ChatRequestResponse chatRequestResponseFromJson(String str) =>
    ChatRequestResponse.fromJson(json.decode(str));

String chatRequestResponseToJson(ChatRequestResponse data) =>
    json.encode(data.toJson());

class ChatRequestResponse {
  ChatRequestResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ChatRequestData> data;

  factory ChatRequestResponse.fromJson(Map<String, dynamic> json) =>
      ChatRequestResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ChatRequestData>.from(
                json["data"].map((x) => ChatRequestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ChatRequestData {
  ChatRequestData({
    this.userChatConnectionId,
    this.userId,
    this.createDatetime,
    this.msg,
    this.fullName,
    this.profileUrl,
  });

  int userChatConnectionId;
  int userId;
  DateTime createDatetime;
  String msg;
  String fullName;
  dynamic profileUrl;

  factory ChatRequestData.fromJson(Map<String, dynamic> json) =>
      ChatRequestData(
        userChatConnectionId: json["user_chat_connection_id"] == null
            ? null
            : json["user_chat_connection_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        msg: json["msg"] == null ? null : json["msg"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "user_chat_connection_id":
            userChatConnectionId == null ? null : userChatConnectionId,
        "user_id": userId == null ? null : userId,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "msg": msg == null ? null : msg,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
      };
}
