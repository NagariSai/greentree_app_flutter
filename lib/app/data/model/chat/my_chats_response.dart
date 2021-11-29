// To parse this JSON data, do
//
//     final myChatResponse = myChatResponseFromJson(jsonString);

import 'dart:convert';

MyChatResponse myChatResponseFromJson(String str) =>
    MyChatResponse.fromJson(json.decode(str));

String myChatResponseToJson(MyChatResponse data) => json.encode(data.toJson());

class MyChatResponse {
  MyChatResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory MyChatResponse.fromJson(Map<String, dynamic> json) => MyChatResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.count,
    this.myChats,
  });

  int count;
  List<MyChat> myChats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        myChats: json["rows"] == null
            ? null
            : List<MyChat>.from(json["rows"].map((x) => MyChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": MyChat == null
            ? null
            : List<dynamic>.from(myChats.map((x) => x.toJson())),
      };
}

class MyChat {
  MyChat({
    this.userChatConnectionId,
    this.userId,
    this.createDatetime,
    this.fullName,
    this.profileUrl,
    this.userChatId,
    this.chatType,
    this.lastChatUserId,
    this.content,
  });

  int userChatConnectionId;
  int userId;
  DateTime createDatetime;
  String fullName;
  dynamic profileUrl;
  int userChatId;
  int chatType;
  int lastChatUserId;
  String content;

  factory MyChat.fromJson(Map<String, dynamic> json) => MyChat(
        userChatConnectionId: json["user_chat_connection_id"] == null
            ? null
            : json["user_chat_connection_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        userChatId: json["user_chat_id"] == null ? null : json["user_chat_id"],
        chatType: json["chat_type"] == null ? null : json["chat_type"],
        lastChatUserId: json["last_chat_user_id"] == null
            ? null
            : json["last_chat_user_id"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "user_chat_connection_id":
            userChatConnectionId == null ? null : userChatConnectionId,
        "user_id": userId == null ? null : userId,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "user_chat_id": userChatId == null ? null : userChatId,
        "chat_type": chatType == null ? null : chatType,
        "last_chat_user_id": lastChatUserId == null ? null : lastChatUserId,
        "content": content == null ? null : content,
      };
}
