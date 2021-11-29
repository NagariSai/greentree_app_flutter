class CoachReviewModel {
  CoachReviewModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory CoachReviewModel.fromJson(Map<String, dynamic> json) =>
      CoachReviewModel(
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
  List<CoachReview> rows;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<CoachReview>.from(
                json["rows"].map((x) => CoachReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class CoachReview {
  CoachReview({
    this.coachReviewId,
    this.userProfileId,
    this.rating,
    this.reviewContent,
    this.createDatetimeUnix,
    this.fullName,
    this.profileUrl,
  });

  int coachReviewId;
  int userProfileId;
  int rating;
  String reviewContent;
  String createDatetimeUnix;
  String fullName;
  dynamic profileUrl;

  factory CoachReview.fromJson(Map<String, dynamic> json) => CoachReview(
        coachReviewId:
            json["coach_review_id"] == null ? null : json["coach_review_id"],
        userProfileId:
            json["user_profile_id"] == null ? null : json["user_profile_id"],
        rating: json["rating"] == null ? null : json["rating"],
        reviewContent:
            json["review_content"] == null ? null : json["review_content"],
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "coach_review_id": coachReviewId == null ? null : coachReviewId,
        "user_profile_id": userProfileId == null ? null : userProfileId,
        "rating": rating == null ? null : rating,
        "review_content": reviewContent == null ? null : reviewContent,
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
      };
}
