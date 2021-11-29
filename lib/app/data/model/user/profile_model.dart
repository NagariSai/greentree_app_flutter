// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  UserProfile data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : UserProfile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class UserProfile {
  UserProfile({
    this.userId,
    this.fullName,
    this.profileUrl,
    this.bio,
    this.userInterests,
    this.userGoals,
    this.followersCount,
    this.followingCount,
    this.isFollow,
    this.isPlan,
    this.isChat,
    this.userChatConnectionId,
  });

  int userId;
  String fullName;
  dynamic profileUrl;
  dynamic bio;
  List<UserInterest> userInterests;
  List<UserGoal> userGoals;
  int followersCount;
  int followingCount;
  int isFollow;
  bool isPlan;
  int isChat;
  int userChatConnectionId;

  ///0 for not connected, 1 for when I have sent the request, 2 for when someone else has sent the request, and final 3  when we are connected

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        bio: json["bio"],
        userInterests: json["user_interests"] == null
            ? null
            : List<UserInterest>.from(
                json["user_interests"].map((x) => UserInterest.fromJson(x))),
        userGoals: json["user_goals"] == null
            ? null
            : List<UserGoal>.from(
                json["user_goals"].map((x) => UserGoal.fromJson(x))),
        followersCount:
            json["followers_count"] == null ? null : json["followers_count"],
        followingCount:
            json["following_count"] == null ? null : json["following_count"],
        isFollow: json["is_follow"] == null ? null : json["is_follow"],
        isChat: json["is_chat"] == null ? null : json["is_chat"],
        isPlan: json["is_plan"] == null ? null : json["is_plan"],
        userChatConnectionId: json["user_chat_connection_id"] == null
            ? null
            : json["user_chat_connection_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "bio": bio,
        "user_interests": userInterests == null
            ? null
            : List<dynamic>.from(userInterests.map((x) => x.toJson())),
        "user_goals": userGoals == null
            ? null
            : List<dynamic>.from(userGoals.map((x) => x.toJson())),
        "followers_count": followersCount == null ? null : followersCount,
        "following_count": followingCount == null ? null : followingCount,
        "is_follow": isFollow == null ? null : isFollow,
        "is_plan": isPlan == null ? null : isPlan,
        "is_chat": isChat == null ? null : isChat,
        "user_chat_connection_id":
            userChatConnectionId == null ? null : userChatConnectionId,
      };
}

class UserGoal {
  UserGoal({
    this.userBringId,
    this.userId,
    this.masterBringId,
    this.title,
  });

  int userBringId;
  int userId;
  int masterBringId;
  String title;

  factory UserGoal.fromJson(Map<String, dynamic> json) => UserGoal(
        userBringId:
            json["user_bring_id"] == null ? null : json["user_bring_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        masterBringId:
            json["master_bring_id"] == null ? null : json["master_bring_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "user_bring_id": userBringId == null ? null : userBringId,
        "user_id": userId == null ? null : userId,
        "master_bring_id": masterBringId == null ? null : masterBringId,
        "title": title == null ? null : title,
      };
}

class UserInterest {
  UserInterest({
    this.userInterestId,
    this.userId,
    this.masterInterestId,
    this.title,
  });

  int userInterestId;
  int userId;
  int masterInterestId;
  String title;

  factory UserInterest.fromJson(Map<String, dynamic> json) => UserInterest(
        userInterestId:
            json["user_interest_id"] == null ? null : json["user_interest_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        masterInterestId: json["master_interest_id"] == null
            ? null
            : json["master_interest_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "user_interest_id": userInterestId == null ? null : userInterestId,
        "user_id": userId == null ? null : userId,
        "master_interest_id":
            masterInterestId == null ? null : masterInterestId,
        "title": title == null ? null : title,
      };
}
