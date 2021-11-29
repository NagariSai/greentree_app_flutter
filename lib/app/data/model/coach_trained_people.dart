class CoachTrainedPeople {
  CoachTrainedPeople({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory CoachTrainedPeople.fromJson(Map<String, dynamic> json) =>
      CoachTrainedPeople(
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
  List<CoachTrained> rows;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<CoachTrained>.from(
                json["rows"].map((x) => CoachTrained.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class CoachTrained {
  CoachTrained({
    this.userEnrollId,
    this.userProfileId,
    this.status,
    this.validUptoDatetime,
    this.profileUrl,
    this.fullName,
    this.packageTitle,
  });

  int userEnrollId;
  int userProfileId;
  int status;
  DateTime validUptoDatetime;
  String profileUrl;
  String fullName;
  String packageTitle;

  factory CoachTrained.fromJson(Map<String, dynamic> json) => CoachTrained(
        userEnrollId:
            json["user_enroll_id"] == null ? null : json["user_enroll_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        status: json["status"] == null ? null : json["status"],
        validUptoDatetime: json["valid_upto_datetime"] == null
            ? null
            : DateTime.parse(json["valid_upto_datetime"]),
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        packageTitle:
            json["package_title"] == null ? null : json["package_title"],
      );

  Map<String, dynamic> toJson() => {
        "user_enroll_id": userEnrollId == null ? null : userEnrollId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "status": status == null ? null : status,
        "valid_upto_datetime": validUptoDatetime == null
            ? null
            : validUptoDatetime.toIso8601String(),
        "profile_url": profileUrl == null ? null : profileUrl,
        "full_name": fullName == null ? null : fullName,
        "package_title": packageTitle == null ? null : packageTitle,
      };
}
