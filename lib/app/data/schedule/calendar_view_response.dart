// To parse this JSON data, do
//
//     final calendarViewResponse = calendarViewResponseFromJson(jsonString);

import 'dart:convert';

CalendarViewResponse calendarViewResponseFromJson(String str) =>
    CalendarViewResponse.fromJson(json.decode(str));

String calendarViewResponseToJson(CalendarViewResponse data) =>
    json.encode(data.toJson());

class CalendarViewResponse {
  CalendarViewResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<CalendarData> data;

  factory CalendarViewResponse.fromJson(Map<String, dynamic> json) =>
      CalendarViewResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<CalendarData>.from(
                json["data"].map((x) => CalendarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CalendarData {
  CalendarData({
    this.userScheduleId,
    this.scheduleDate,
    this.setKcal,
    this.completeKcal,
  });

  int userScheduleId;
  DateTime scheduleDate;
  int setKcal;
  int completeKcal;

  factory CalendarData.fromJson(Map<String, dynamic> json) => CalendarData(
        userScheduleId:
            json["user_schedule_id"] == null ? null : json["user_schedule_id"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        setKcal: json["set_kcal"] == null ? null : json["set_kcal"],
        completeKcal:
            json["complete_kcal"] == null ? null : json["complete_kcal"],
      );

  Map<String, dynamic> toJson() => {
        "user_schedule_id": userScheduleId == null ? null : userScheduleId,
        "schedule_date":
            scheduleDate == null ? null : scheduleDate.toIso8601String(),
        "set_kcal": setKcal == null ? null : setKcal,
        "complete_kcal": completeKcal == null ? null : completeKcal,
      };
}
