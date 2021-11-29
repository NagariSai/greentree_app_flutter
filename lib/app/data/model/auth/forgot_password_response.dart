// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
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
    this.userId,
    this.passcode,
  });

  int userId;
  String passcode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] == null ? null : json["user_id"],
        passcode: json["passcode"] == null ? null : json["passcode"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "passcode": passcode == null ? null : passcode,
      };
}
