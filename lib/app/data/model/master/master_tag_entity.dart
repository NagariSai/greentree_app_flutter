// To parse this JSON data, do
//
//     final masterTagEntity = masterTagEntityFromMap(jsonString);

import 'dart:convert';

MasterTagEntity masterTagEntityFromMap(String str) =>
    MasterTagEntity.fromMap(json.decode(str));

String masterTagEntityToMap(MasterTagEntity data) => json.encode(data.toMap());

class MasterTagEntity {
  MasterTagEntity({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MasterTagEntity.fromMap(Map<String, dynamic> json) => MasterTagEntity(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.masterTagId,
    this.title,
    this.tagType,
  });

  int masterTagId;
  String title;
  int tagType;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        masterTagId:
            json["master_tag_id"] == null ? null : json["master_tag_id"],
        title: json["title"] == null ? null : json["title"],
        tagType: json["tag_type"] == null ? null : json["tag_type"],
      );

  Map<String, dynamic> toMap() => {
        "master_tag_id": masterTagId == null ? null : masterTagId,
        "title": title == null ? null : title,
        "tag_type": tagType == null ? null : tagType,
      };
}
