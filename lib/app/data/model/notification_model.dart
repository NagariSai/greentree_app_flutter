class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  NotificationData data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class NotificationData {
  NotificationData({
    this.count,
    this.rows,
  });

  int count;
  List<UserNotification> rows;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<UserNotification>.from(
                json["rows"].map((x) => UserNotification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class UserNotification {
  UserNotification({
    this.userNotificationId,
    this.fromUserId,
    this.toUserId,
    this.globalId,
    this.globalType,
    this.type,
    this.notificationContent,
    this.fullName,
    this.createDatetime,
    this.createDatetimeUnix,
    this.notificationType,
    this.profileUrl,
    this.triedCount,
    this.userChatConnectionId,
    this.title,
  });

  int userNotificationId;
  int fromUserId;
  int toUserId;
  int globalId;
  int globalType;
  int type;
  int triedCount;
  int notificationType;
  int userChatConnectionId;

  String notificationContent;
  String title;
  String fullName;
  DateTime createDatetime;
  String createDatetimeUnix;
  String profileUrl;

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        userNotificationId: json["user_notification_id"] == null
            ? null
            : json["user_notification_id"],
        userChatConnectionId: json["user_chat_connection_id"] == null
            ? null
            : json["user_chat_connection_id"],
        notificationType: json["notification_type"] == null
            ? null
            : json["notification_type"],
        title: json["title"] == null ? null : json["title"],
        triedCount: json["tried_count"] == null ? null : json["tried_count"],
        fromUserId: json["from_user_id"] == null ? null : json["from_user_id"],
        toUserId: json["to_user_id"] == null ? null : json["to_user_id"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        globalType: json["global_type"] == null ? null : json["global_type"],
        type: json["type"] == null ? null : json["type"],
        notificationContent: json["notification_content"] == null
            ? null
            : json["notification_content"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "user_notification_id":
            userNotificationId == null ? null : userNotificationId,
        "notification_type": notificationType == null ? null : notificationType,
        "from_user_id": fromUserId == null ? null : fromUserId,
        "to_user_id": toUserId == null ? null : toUserId,
        "global_id": globalId == null ? null : globalId,
        "global_type": globalType == null ? null : globalType,
        "type": type == null ? null : type,
        "tried_count": triedCount == null ? null : triedCount,
        "notification_content":
            notificationContent == null ? null : notificationContent,
        "user_chat_connection_id":
            userChatConnectionId == null ? null : userChatConnectionId,
        "title": title == null ? null : title,
        "full_name": fullName == null ? null : fullName,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "profile_url": profileUrl == null ? null : profileUrl,
      };
}
