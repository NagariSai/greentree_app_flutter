// To parse this JSON data, do
//
//     final userDetailResponse = userDetailResponseFromMap(jsonString);

import 'dart:convert';

UserDetailEntity userDetailEntityFromMap(String str) =>
    UserDetailEntity.fromMap(json.decode(str));

String userDetailEntityToMap(UserDetailEntity data) =>
    json.encode(data.toMap());

class UserDetailEntity {
  UserDetailEntity({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  UserDetailData data;

  factory UserDetailEntity.fromMap(Map<String, dynamic> json) =>
      UserDetailEntity(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : UserDetailData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };
}

class UserDetailData {
  UserDetailData({
    this.isSetup,
    this.userData,
    this.masterBrings,
    this.masterInterests,
  });

  int isSetup;
  UserData userData;
  List<MasterBring> masterBrings;
  List<MasterInterest> masterInterests;
  List<String> foodList;

  factory UserDetailData.fromMap(Map<String, dynamic> json) => UserDetailData(
        isSetup: json["is_setup"] == null ? null : json["is_setup"],
        userData: json["userData"] == null
            ? null
            : UserData.fromMap(json["userData"]),
        masterBrings: json["master_brings"] == null
            ? null
            : List<MasterBring>.from(
                json["master_brings"].map((x) => MasterBring.fromMap(x))),
        masterInterests: json["master_interests"] == null
            ? null
            : List<MasterInterest>.from(
                json["master_interests"].map((x) => MasterInterest.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "is_setup": isSetup == null ? null : isSetup,
        "userData": userData == null ? null : userData.toMap(),
        "master_brings": masterBrings == null
            ? null
            : List<dynamic>.from(masterBrings.map((x) => x.toMap())),
        "master_interests": masterInterests == null
            ? null
            : List<dynamic>.from(masterInterests.map((x) => x.toMap())),
      };
}

class MasterBring {
  MasterBring({
    this.masterBringId,
    this.title,
    this.icon,
    this.fillIcon,
    this.shadowColor,
    this.color,
    this.userBring,
  });

  int masterBringId;
  String title;
  String icon;
  String fillIcon;
  String shadowColor;
  String color;
  dynamic userBring;

  factory MasterBring.fromMap(Map<String, dynamic> json) => MasterBring(
        masterBringId:
            json["master_bring_id"] == null ? null : json["master_bring_id"],
        title: json["title"] == null ? null : json["title"],
        icon: json["icon"] == null ? null : json["icon"],
        fillIcon: json["fill_icon"] == null ? null : json["fill_icon"],
        shadowColor: json["shadow_color"] == null ? null : json["shadow_color"],
        color: json["color"] == null ? null : json["color"],
        userBring: json["user_bring"],
      );

  Map<String, dynamic> toMap() => {
        "master_bring_id": masterBringId == null ? null : masterBringId,
        "title": title == null ? null : title,
        "icon": icon == null ? null : icon,
        "fill_icon": fillIcon == null ? null : fillIcon,
        "shadow_color": shadowColor == null ? null : shadowColor,
        "color": color == null ? null : color,
        "user_bring": userBring,
      };
}

class MasterInterest {
  MasterInterest({
    this.masterInterestId,
    this.title,
    this.userInterest,
  });

  int masterInterestId;
  String title;
  dynamic userInterest;

  factory MasterInterest.fromMap(Map<String, dynamic> json) => MasterInterest(
        masterInterestId: json["master_interest_id"] == null
            ? null
            : json["master_interest_id"],
        title: json["title"] == null ? null : json["title"],
        userInterest: json["user_interest"],
      );

  Map<String, dynamic> toMap() => {
        "master_interest_id":
            masterInterestId == null ? null : masterInterestId,
        "title": title == null ? null : title,
        "user_interest": userInterest,
      };
}

class UserData {
  UserData(
      {this.userId,
      this.fullName,
      this.gender,
      this.dateOfBirth,
      this.heightUnit,
      this.height,
      this.weightType,
      this.weight,
      this.foodPreference,
      this.fitnessLevel,
      this.isSetup,
      this.emailAddress,
      this.phoneNumber,
      this.bio,
      this.country,
      this.countryCode,
      this.userInterests,
      this.userBrings,
      this.profileUrl});

  int userId;
  String fullName;
  dynamic gender;
  dynamic dateOfBirth;
  int heightUnit;
  String height;
  int weightType;
  String weight;
  dynamic foodPreference;
  dynamic fitnessLevel;
  int isSetup;
  String emailAddress;
  String phoneNumber;
  String bio;
  String country;
  String countryCode;
  List<User> userInterests;
  List<User> userBrings;
  String profileUrl;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        profileUrl: json["profile_url"] == null ? "" : json["profile_url"],
        userId: json["user_id"] == null ? null : json["user_id"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        bio: json["bio"] == null ? null : json["bio"],
        country: json["country"] == null ? null : json["country"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        heightUnit: json["height_unit"] == null ? null : json["height_unit"],
        height: json["height"] == null ? null : json["height"],
        weightType: json["weight_type"] == null ? null : json["weight_type"],
        weight: json["weight"] == null ? null : json["weight"],
        foodPreference: json["food_preference"],
        fitnessLevel: json["fitness_level"],
        isSetup: json["is_setup"] == null ? null : json["is_setup"],
        userInterests: json["user_interests"] == null
            ? null
            : List<User>.from(
                json["user_interests"].map((x) => User.fromJson(x))),
        userBrings: json["user_brings"] == null
            ? null
            : List<User>.from(json["user_brings"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "profile_url": profileUrl == null ? null : profileUrl,
        "email_address": emailAddress == null ? null : emailAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country_code": countryCode == null ? null : countryCode,
        "bio": bio == null ? null : bio,
        "country": country == null ? null : country,
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "height_unit": heightUnit == null ? null : heightUnit,
        "height": height == null ? null : height,
        "weight_type": weightType == null ? null : weightType,
        "weight": weight == null ? null : weight,
        "food_preference": foodPreference,
        "fitness_level": fitnessLevel,
        "is_setup": isSetup == null ? null : isSetup,
        "user_interests": userInterests == null
            ? null
            : List<dynamic>.from(userInterests.map((x) => x.toJson())),
        "user_brings": userBrings == null
            ? null
            : List<dynamic>.from(userBrings.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.userBringId,
    this.userId,
    this.masterBringId,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
    this.userInterestId,
    this.masterInterestId,
  });

  int userBringId;
  int userId;
  int masterBringId;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;
  int userInterestId;
  int masterInterestId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userBringId:
            json["user_bring_id"] == null ? null : json["user_bring_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        masterBringId:
            json["master_bring_id"] == null ? null : json["master_bring_id"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
        userInterestId:
            json["user_interest_id"] == null ? null : json["user_interest_id"],
        masterInterestId: json["master_interest_id"] == null
            ? null
            : json["master_interest_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_bring_id": userBringId == null ? null : userBringId,
        "user_id": userId == null ? null : userId,
        "master_bring_id": masterBringId == null ? null : masterBringId,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
        "user_interest_id": userInterestId == null ? null : userInterestId,
        "master_interest_id":
            masterInterestId == null ? null : masterInterestId,
      };
}
