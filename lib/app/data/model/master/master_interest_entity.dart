// To parse this JSON data, do
//
//     final masterInterestEntity = masterInterestEntityFromMap(jsonString);

import 'dart:convert';

MasterInterestEntity masterInterestEntityFromMap(String str) =>
    MasterInterestEntity.fromMap(json.decode(str));

String masterInterestEntityToMap(MasterInterestEntity data) =>
    json.encode(data.toMap());

class MasterInterestEntity {
  MasterInterestEntity({
    this.masterInterestId,
    this.title,
    this.userInterest,
  });

  int masterInterestId;
  String title;
  dynamic userInterest;

  factory MasterInterestEntity.fromMap(Map<String, dynamic> json) =>
      MasterInterestEntity(
        masterInterestId: json["master_interest_id"] == null
            ? null
            : json["master_interest_id"],
        title: json["title"] == null ? null : json["title"],
        userInterest: json["user_interest"],
      );

  Map<String, dynamic> toMap() => {
        "master_interest_id":
            masterInterestId == null ? null : masterInterestId,
        "title": title == null ? null : title,
        "user_interest": userInterest,
      };
}
