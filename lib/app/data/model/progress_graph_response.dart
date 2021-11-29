// To parse this JSON data, do
//
//     final progressGraphResponse = progressGraphResponseFromJson(jsonString);

import 'dart:convert';

ProgressGraphResponse progressGraphResponseFromJson(String str) =>
    ProgressGraphResponse.fromJson(json.decode(str));

String progressGraphResponseToJson(ProgressGraphResponse data) =>
    json.encode(data.toJson());

class ProgressGraphResponse {
  ProgressGraphResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  ProgressGraph data;

  factory ProgressGraphResponse.fromJson(Map<String, dynamic> json) =>
      ProgressGraphResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : ProgressGraph.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class ProgressGraph {
  ProgressGraph({
    this.bodyweight,
    this.water,
  });

  List<Bodyweight> bodyweight;
  List<Bodyweight> water;

  factory ProgressGraph.fromJson(Map<String, dynamic> json) => ProgressGraph(
        bodyweight: json["bodyweight"] == null
            ? null
            : List<Bodyweight>.from(
                json["bodyweight"].map((x) => Bodyweight.fromJson(x))),
        water: json["water"] == null
            ? null
            : List<Bodyweight>.from(
                json["water"].map((x) => Bodyweight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bodyweight": bodyweight == null
            ? null
            : List<dynamic>.from(bodyweight.map((x) => x.toJson())),
        "water": water == null
            ? null
            : List<dynamic>.from(water.map((x) => x.toJson())),
      };
}

class Bodyweight {
  Bodyweight({
    this.weeks,
    this.avg,
  });

  int weeks;
  String avg;

  factory Bodyweight.fromJson(Map<String, dynamic> json) => Bodyweight(
        weeks: json["weeks"] == null ? null : json["weeks"],
        avg: json["avg"] == null ? null : json["avg"],
      );

  Map<String, dynamic> toJson() => {
        "weeks": weeks == null ? null : weeks,
        "avg": avg == null ? null : avg,
      };
}
