class CoachEnrollUserResponse {
  CoachEnrollUserResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory CoachEnrollUserResponse.fromJson(Map<String, dynamic> json) =>
      CoachEnrollUserResponse(
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
    this.rows,
  });

  int count;
  List<CoachEnrollUser> rows;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<CoachEnrollUser>.from(
                json["rows"].map((x) => CoachEnrollUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class CoachEnrollUser {
  CoachEnrollUser({
    this.userEnrollId,
    this.userProfileId,
    this.packageTitle,
    this.createDatetime,
    this.validUptoDatetime,
    this.switchedDatetime,
    this.switchedReason,
    this.profileUrl,
    this.fullName,
  });

  int userEnrollId;
  int userProfileId;
  String packageTitle;
  DateTime createDatetime;
  DateTime validUptoDatetime;
  dynamic switchedDatetime;
  dynamic switchedReason;
  dynamic profileUrl;
  String fullName;

  factory CoachEnrollUser.fromJson(Map<String, dynamic> json) =>
      CoachEnrollUser(
        userEnrollId:
            json["user_enroll_id"] == null ? null : json["user_enroll_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        packageTitle:
            json["package_title"] == null ? null : json["package_title"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        validUptoDatetime: json["valid_upto_datetime"] == null
            ? null
            : DateTime.parse(json["valid_upto_datetime"]),
        switchedDatetime: json["switched_datetime"],
        switchedReason: json["switched_reason"],
        profileUrl: json["profile_url"],
        fullName: json["full_name"] == null ? null : json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_enroll_id": userEnrollId == null ? null : userEnrollId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "package_title": packageTitle == null ? null : packageTitle,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "valid_upto_datetime": validUptoDatetime == null
            ? null
            : validUptoDatetime.toIso8601String(),
        "switched_datetime": switchedDatetime,
        "switched_reason": switchedReason,
        "profile_url": profileUrl,
        "full_name": fullName == null ? null : fullName,
      };
}
