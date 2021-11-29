// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.status,
    this.message,
    this.data,
    this.accessToken,
  });

  bool status;
  String message;
  Data data;
  String accessToken;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
        "access_token": accessToken == null ? null : accessToken,
      };
}

class Data {
  Data({
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
  });

  int userId;
  int roleId;
  String socialId;
  String fullName;
  String emailAddress;
  String phoneNumber;
  String password;
  String passcode;
  dynamic gender;
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
  dynamic updateDatetime;
  String updateDatetimeUnix;
  String scope;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] == null ? null : json["user_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        socialId: json["social_id"] == null ? null : json["social_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        password: json["password"] == null ? null : json["password"],
        passcode: json["passcode"] == null ? null : json["passcode"],
        gender: json["gender"],
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
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"] == null
            ? null
            : json["update_datetime_unix"],
        scope: json["scope"] == null ? null : json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "role_id": roleId == null ? null : roleId,
        "social_id": socialId == null ? null : socialId,
        "full_name": fullName == null ? null : fullName,
        "email_address": emailAddress == null ? null : emailAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "password": password == null ? null : password,
        "passcode": passcode == null ? null : passcode,
        "gender": gender,
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
        "update_datetime": updateDatetime,
        "update_datetime_unix":
            updateDatetimeUnix == null ? null : updateDatetimeUnix,
        "scope": scope == null ? null : scope,
      };
}
