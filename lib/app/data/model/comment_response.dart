class CommentResponse {
  CommentResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  CommentData data;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : CommentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class CommentData {
  CommentData({
    this.count,
    this.rows,
  });

  int count;
  List<Comment> rows;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<Comment>.from(json["rows"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.userCommentId,
    this.uniqueId,
    this.type,
    this.userId,
    this.commentDescription,
    this.createDatetime,
    this.createDatetimeUnix,
    this.fullName,
    this.profileUrl,
    this.isMyLike,
    this.totalLikes,
    this.totalSubComment,
    this.subComment,
  });

  int userCommentId;
  int uniqueId;
  int type;
  int userId;
  String commentDescription;
  DateTime createDatetime;
  String createDatetimeUnix;
  String fullName;
  dynamic profileUrl;
  int isMyLike;
  int totalLikes;
  int totalSubComment;
  List<Comment> subComment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userCommentId:
            json["user_comment_id"] == null ? null : json["user_comment_id"],
        uniqueId: json["unique_id"] == null ? null : json["unique_id"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        commentDescription: json["comment_description"] == null
            ? null
            : json["comment_description"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        isMyLike: json["is_my_like"] == null ? null : json["is_my_like"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalSubComment: json["total_sub_comment"] == null
            ? null
            : json["total_sub_comment"],
        subComment: json["sub_comment"] == null
            ? null
            : List<Comment>.from(
                json["sub_comment"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_comment_id": userCommentId == null ? null : userCommentId,
        "unique_id": uniqueId == null ? null : uniqueId,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "comment_description":
            commentDescription == null ? null : commentDescription,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "is_my_like": isMyLike == null ? null : isMyLike,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_sub_comment": totalSubComment == null ? null : totalSubComment,
        "sub_comment": subComment == null
            ? null
            : List<dynamic>.from(subComment.map((x) => x)),
      };
}
