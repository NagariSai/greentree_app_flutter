class BlockUserModel {
  BlockUserModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory BlockUserModel.fromJson(Map<String, dynamic> json) => BlockUserModel(
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
    this.blockUserList,
  });

  int count;
  List<BlockUser> blockUserList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        blockUserList: json["rows"] == null
            ? null
            : List<BlockUser>.from(
                json["rows"].map((x) => BlockUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": blockUserList == null
            ? null
            : List<dynamic>.from(blockUserList.map((x) => x.toJson())),
      };
}

class BlockUser {
  BlockUser({
    this.userBlockId,
    this.userProfileId,
    this.userId,
    this.fullName,
    this.profileUrl,
    this.totalPost,
    this.totalFollowers,
  });

  int userBlockId;
  int userProfileId;
  int userId;
  String fullName;
  dynamic profileUrl;
  int totalPost;
  int totalFollowers;

  factory BlockUser.fromJson(Map<String, dynamic> json) => BlockUser(
        userBlockId:
            json["user_block_id"] == null ? null : json["user_block_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        totalPost: json["total_post"] == null ? null : json["total_post"],
        totalFollowers:
            json["total_followers"] == null ? null : json["total_followers"],
      );

  Map<String, dynamic> toJson() => {
        "user_block_id": userBlockId == null ? null : userBlockId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "total_post": totalPost == null ? null : totalPost,
        "total_followers": totalFollowers == null ? null : totalFollowers,
      };
}
