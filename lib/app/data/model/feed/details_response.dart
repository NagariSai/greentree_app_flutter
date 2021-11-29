import 'feed_response.dart';

class DetailsResponse {
  DetailsResponse({
    this.status,
    this.message,
    this.feedData,
  });

  bool status;
  String message;
  Feed feedData;

  factory DetailsResponse.fromJson(Map<String, dynamic> json) =>
      DetailsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        feedData: json["data"] == null ? null : Feed.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": feedData == null ? null : feedData.toJson(),
      };
}
