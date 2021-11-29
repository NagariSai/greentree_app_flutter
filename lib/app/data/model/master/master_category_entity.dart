// To parse this JSON data, do
//
//     final masterCategoryEntity = masterCategoryEntityFromMap(jsonString);

import 'dart:convert';

MasterCategoryEntity masterCategoryEntityFromMap(String str) => MasterCategoryEntity.fromMap(json.decode(str));

String masterCategoryEntityToMap(MasterCategoryEntity data) => json.encode(data.toMap());

class MasterCategoryEntity {
  MasterCategoryEntity({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MasterCategoryEntity.fromMap(Map<String, dynamic> json) => MasterCategoryEntity(
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
    this.masterCategoryTypeId,
    this.title,
  });

  int masterCategoryTypeId;
  String title;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    masterCategoryTypeId: json["master_category_type_id"] == null ? null : json["master_category_type_id"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toMap() => {
    "master_category_type_id": masterCategoryTypeId == null ? null : masterCategoryTypeId,
    "title": title == null ? null : title,
  };
}
