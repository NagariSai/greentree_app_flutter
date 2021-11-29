// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ResendOtpResponse forgotPasswordResponseFromJson(String str) =>
    ResendOtpResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ResendOtpResponse data) =>
    json.encode(data.toJson());

class ResendOtpResponse {
  ResendOtpResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  String data;

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json.containsKey('data') ? json["data"] : "",
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
