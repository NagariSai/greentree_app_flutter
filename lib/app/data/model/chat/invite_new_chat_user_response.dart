// To parse this JSON data, do
//
//     final inviteNewChatResponse = inviteNewChatResponseFromJson(jsonString);

import 'dart:convert';

InviteNewChatResponse inviteNewChatResponseFromJson(String str) =>
    InviteNewChatResponse.fromJson(json.decode(str));

String inviteNewChatResponseToJson(InviteNewChatResponse data) =>
    json.encode(data.toJson());

class InviteNewChatResponse {
  InviteNewChatResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory InviteNewChatResponse.fromJson(Map<String, dynamic> json) =>
      InviteNewChatResponse(
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
    this.userList,
  });

  int count;
  List<NewUserChat> userList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        userList: json["rows"] == null
            ? null
            : List<NewUserChat>.from(
                json["rows"].map((x) => NewUserChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": userList == null
            ? null
            : List<dynamic>.from(userList.map((x) => x.toJson())),
      };
}

class NewUserChat {
  NewUserChat({
    this.userId,
    this.fullName,
    this.profileUrl,
    this.invideFlag,
    this.totalPost,
    this.followersCount,
    this.userChatConnectionId,
  });

  int userId;
  String fullName;
  dynamic profileUrl;
  int invideFlag;
  int totalPost;
  int followersCount;
  int userChatConnectionId;

  factory NewUserChat.fromJson(Map<String, dynamic> json) => NewUserChat(
        userChatConnectionId: json["user_chat_connection_id"] == null
            ? null
            : json["user_chat_connection_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        invideFlag: json["invide_flag"] == null ? null : json["invide_flag"],
        totalPost: json["total_post"] == null ? null : json["total_post"],
        followersCount:
            json["followers_count"] == null ? null : json["followers_count"],
      );

  Map<String, dynamic> toJson() => {
        "user_chat_connection_id":
            userChatConnectionId == null ? null : userChatConnectionId,
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "invide_flag": invideFlag == null ? null : invideFlag,
        "total_post": totalPost == null ? null : totalPost,
        "followers_count": followersCount == null ? null : followersCount,
      };
}
