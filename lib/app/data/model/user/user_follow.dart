class UserFollowModel {
  UserFollowModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<UserFollow> data;

  factory UserFollowModel.fromJson(Map<String, dynamic> json) =>
      UserFollowModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<UserFollow>.from(
                json["data"].map((x) => UserFollow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserFollow {
  UserFollow({
    this.userFollowId,
    this.userProfileId,
    this.userId,
    this.fullName,
    this.profileUrl,
    this.totalPost,
    this.totalFollowers,
    this.isFollow,
  });

  int userFollowId;
  int userProfileId;
  int userId;
  String fullName;
  dynamic profileUrl;
  int totalPost;
  int totalFollowers;
  int isFollow;

  factory UserFollow.fromJson(Map<String, dynamic> json) => UserFollow(
        userFollowId:
            json["user_follow_id"] == null ? null : json["user_follow_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"] == null ? "" : json["profile_url"],
        totalPost: json["total_post"] == null ? null : json["total_post"],
        totalFollowers:
            json["total_followers"] == null ? null : json["total_followers"],
        isFollow: json["is_follow"] == null ? null : json["is_follow"],
      );

  Map<String, dynamic> toJson() => {
        "user_follow_id": userFollowId == null ? null : userFollowId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "total_post": totalPost == null ? null : totalPost,
        "total_followers": totalFollowers == null ? null : totalFollowers,
        "is_follow": isFollow == null ? null : isFollow,
      };
}
