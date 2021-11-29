// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

ChatResponse chatResponseFromJson(String str) =>
    ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  ChatResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
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
    this.chats,
  });

  int count;
  List<ChatData> chats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        chats: json["rows"] == null
            ? null
            : List<ChatData>.from(
                json["rows"].map((x) => ChatData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": chats == null
            ? null
            : List<dynamic>.from(chats.map((x) => x.toJson())),
      };
}

class ChatData {
  ChatData({
    this.userChatId,
    this.firstUserId,
    this.secondUserId,
    this.chatType,
    this.content,
    this.fullName,
    this.profileUrl,
    this.createDatetime,
  });

  int userChatId;
  int firstUserId;
  int secondUserId;
  int chatType;
  String content;
  String fullName;
  String profileUrl;
  DateTime createDatetime;

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        userChatId: json["user_chat_id"] == null ? null : json["user_chat_id"],
        firstUserId:
            json["first_user_id"] == null ? null : json["first_user_id"],
        secondUserId:
            json["second_user_id"] == null ? null : json["second_user_id"],
        chatType: json["chat_type"] == null ? null : json["chat_type"],
        content: json["content"] == null ? null : json["content"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "user_chat_id": userChatId == null ? null : userChatId,
        "first_user_id": firstUserId == null ? null : firstUserId,
        "second_user_id": secondUserId == null ? null : secondUserId,
        "chat_type": chatType == null ? null : chatType,
        "content": content == null ? null : content,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl == null ? null : profileUrl,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
      };
}
