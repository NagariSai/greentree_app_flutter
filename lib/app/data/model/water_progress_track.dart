// To parse this JSON data, do
//
//     final waterProgressResponse = waterProgressResponseFromJson(jsonString);

import 'dart:convert';

WaterProgressResponse waterProgressResponseFromJson(String str) =>
    WaterProgressResponse.fromJson(json.decode(str));

String waterProgressResponseToJson(WaterProgressResponse data) =>
    json.encode(data.toJson());

class WaterProgressResponse {
  WaterProgressResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  WaterProgress data;

  factory WaterProgressResponse.fromJson(Map<String, dynamic> json) =>
      WaterProgressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : WaterProgress.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class WaterProgress {
  WaterProgress({
    this.progTrackActivityId,
    this.activityDate,
    this.waterLevel,
    this.bodyWeight,
  });

  int progTrackActivityId;
  DateTime activityDate;
  String waterLevel;
  int bodyWeight;

  factory WaterProgress.fromJson(Map<String, dynamic> json) => WaterProgress(
        progTrackActivityId: json["prog_track_activity_id"] == null
            ? null
            : json["prog_track_activity_id"],
        activityDate:
            json["activity_date"] == null || json["activity_date"] == ""
                ? null
                : DateTime.parse(json["activity_date"]),
        waterLevel: json["water_level"] == null ? null : json["water_level"],
        bodyWeight: json["body_weight"] == null || json["body_weight"] == ""
            ? null
            : json["body_weight"],
      );

  Map<String, dynamic> toJson() => {
        "prog_track_activity_id":
            progTrackActivityId == null ? null : progTrackActivityId,
        "activity_date":
            activityDate == null ? null : activityDate.toIso8601String(),
        "water_level": waterLevel == null ? null : waterLevel,
        "body_weight": bodyWeight == null ? null : bodyWeight,
      };
}
