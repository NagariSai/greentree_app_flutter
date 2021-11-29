// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.data,
    this.accessToken,
  });

  bool status;
  String message;
  UserData data;
  String accessToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
        "access_token": accessToken == null ? null : accessToken,
      };
}

class UserData {
  UserData({
    this.userId,
    this.roleId,
    this.socialId,
    this.fullName,
    this.emailAddress,
    this.phoneNumber,
    this.password,
    this.passcode,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.foodPreference,
    this.fitnessLevel,
    this.lastPasscodeDatetime,
    this.referralUserId,
    this.referralCode,
    this.isActive,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
    this.scope,
    this.loginType,
    this.weightType,
    this.heightUnit,
    this.profileUrl,
    this.userAuthId,
  });

  int userId;
  int userAuthId;
  int roleId;
  String socialId;
  String fullName;
  String emailAddress;
  String phoneNumber;
  String password;
  String passcode;
  int gender;
  dynamic dateOfBirth;
  String height;
  String weight;
  dynamic foodPreference;
  dynamic fitnessLevel;
  dynamic lastPasscodeDatetime;
  int referralUserId;
  String referralCode;
  int isActive;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  DateTime updateDatetime;
  String updateDatetimeUnix;
  String scope;
  String loginType;
  String profileUrl;
  int weightType;
  int heightUnit;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        heightUnit: json["height_unit"] == null ? null : json["height_unit"],
        weightType: json["weight_type"] == null ? null : json["weight_type"],
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userAuthId: json["user_auth_id"] == null ? null : json["user_auth_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        socialId: json["social_id"] == null ? null : json["social_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        password: json["password"] == null ? null : json["password"],
        passcode: json["passcode"] == null ? null : json["passcode"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth: json["date_of_birth"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        foodPreference: json["food_preference"],
        fitnessLevel: json["fitness_level"],
        lastPasscodeDatetime: json["last_passcode_datetime"],
        referralUserId:
            json["referral_user_id"] == null ? null : json["referral_user_id"],
        referralCode:
            json["referral_code"] == null ? null : json["referral_code"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"] == null
            ? null
            : DateTime.parse(json["update_datetime"]),
        updateDatetimeUnix: json["update_datetime_unix"] == null
            ? null
            : json["update_datetime_unix"],
        scope: json["scope"] == null ? null : json["scope"],
        loginType: json["login_type"] == null ? null : json["login_type"],
      );

  Map<String, dynamic> toJson() => {
        "height_unit": heightUnit == null ? null : heightUnit,
        "weight_type": weightType == null ? null : weightType,
        "profile_url": profileUrl == null ? null : profileUrl,
        "user_id": userId == null ? null : userId,
        "user_auth_id": userAuthId == null ? null : userAuthId,
        "role_id": roleId == null ? null : roleId,
        "social_id": socialId == null ? null : socialId,
        "full_name": fullName == null ? null : fullName,
        "email_address": emailAddress == null ? null : emailAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "password": password == null ? null : password,
        "passcode": passcode == null ? null : passcode,
        "gender": gender == null ? null : gender,
        "date_of_birth": dateOfBirth,
        "height": height == null ? null : height,
        "weight": weight == null ? null : weight,
        "food_preference": foodPreference,
        "fitness_level": fitnessLevel,
        "last_passcode_datetime": lastPasscodeDatetime,
        "referral_user_id": referralUserId == null ? null : referralUserId,
        "referral_code": referralCode == null ? null : referralCode,
        "is_active": isActive == null ? null : isActive,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime":
            updateDatetime == null ? null : updateDatetime.toIso8601String(),
        "update_datetime_unix":
            updateDatetimeUnix == null ? null : updateDatetimeUnix,
        "scope": scope == null ? null : scope,
        "login_type": loginType == null ? null : loginType,
      };
}
