// To parse this JSON data, do
//
//     final coachPaymentResponse = coachPaymentResponseFromJson(jsonString);

import 'dart:convert';

CoachPaymentResponse coachPaymentResponseFromJson(String str) =>
    CoachPaymentResponse.fromJson(json.decode(str));

String coachPaymentResponseToJson(CoachPaymentResponse data) =>
    json.encode(data.toJson());

class CoachPaymentResponse {
  CoachPaymentResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory CoachPaymentResponse.fromJson(Map<String, dynamic> json) =>
      CoachPaymentResponse(
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
    this.barData,
    this.rawData,
  });

  List<BarDatum> barData;
  List<RawDatum> rawData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        barData: json["bar_data"] == null
            ? null
            : List<BarDatum>.from(
                json["bar_data"].map((x) => BarDatum.fromJson(x))),
        rawData: json["raw_data"] == null
            ? null
            : List<RawDatum>.from(
                json["raw_data"].map((x) => RawDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bar_data": barData == null
            ? null
            : List<dynamic>.from(barData.map((x) => x.toJson())),
        "raw_data": rawData == null
            ? null
            : List<dynamic>.from(rawData.map((x) => x.toJson())),
      };
}

class BarDatum {
  BarDatum({
    this.weeks,
    this.totalPackagePrice,
  });

  int weeks;
  int totalPackagePrice;

  factory BarDatum.fromJson(Map<String, dynamic> json) => BarDatum(
        weeks: json["weeks"] == null ? null : json["weeks"],
        totalPackagePrice: json["total_package_price"] == null
            ? null
            : json["total_package_price"],
      );

  Map<String, dynamic> toJson() => {
        "weeks": weeks == null ? null : weeks,
        "total_package_price":
            totalPackagePrice == null ? null : totalPackagePrice,
      };
}

class RawDatum {
  RawDatum({
    this.userEnrollId,
    this.userProfileId,
    this.validUptoDatetime,
    this.profileUrl,
    this.fullName,
    this.packageTitle,
    this.packagePrice,
    this.activityDate,
  });

  int userEnrollId;
  int userProfileId;
  DateTime validUptoDatetime;
  String profileUrl;
  String fullName;
  String packageTitle;
  int packagePrice;
  DateTime activityDate;

  factory RawDatum.fromJson(Map<String, dynamic> json) => RawDatum(
        userEnrollId:
            json["user_enroll_id"] == null ? null : json["user_enroll_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        validUptoDatetime: json["valid_upto_datetime"] == null
            ? null
            : DateTime.parse(json["valid_upto_datetime"]),
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        packageTitle:
            json["package_title"] == null ? null : json["package_title"],
        packagePrice:
            json["package_price"] == null ? null : json["package_price"],
        activityDate: json["activity_date"] == null
            ? null
            : DateTime.parse(json["activity_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_enroll_id": userEnrollId == null ? null : userEnrollId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "valid_upto_datetime": validUptoDatetime == null
            ? null
            : validUptoDatetime.toIso8601String(),
        "profile_url": profileUrl == null ? null : profileUrl,
        "full_name": fullName == null ? null : fullName,
        "package_title": packageTitle == null ? null : packageTitle,
        "package_price": packagePrice == null ? null : packagePrice,
        "activity_date": activityDate == null
            ? null
            : "${activityDate.year.toString().padLeft(4, '0')}-${activityDate.month.toString().padLeft(2, '0')}-${activityDate.day.toString().padLeft(2, '0')}",
      };
}
