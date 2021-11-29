// To parse this JSON data, do
//
//     final masterCuisineEntity = masterCuisineEntityFromMap(jsonString);

import 'dart:convert';

MasterCuisineEntity masterCuisineEntityFromMap(String str) => MasterCuisineEntity.fromMap(json.decode(str));

String masterCuisineEntityToMap(MasterCuisineEntity data) => json.encode(data.toMap());

class MasterCuisineEntity {
  MasterCuisineEntity({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MasterCuisineEntity.fromMap(Map<String, dynamic> json) => MasterCuisineEntity(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    this.masterCuisineId,
    this.title,
  });

  int masterCuisineId;
  String title;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    masterCuisineId: json["master_cuisine_id"] == null ? null : json["master_cuisine_id"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "master_cuisine_id": masterCuisineId == null ? null : masterCuisineId,
    "title": title == null ? null : title,
  };
}
