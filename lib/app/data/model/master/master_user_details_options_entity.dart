// To parse this JSON data, do
//
//     final userDetailsOptionsEntity = userDetailsOptionsEntityFromMap(jsonString);

import 'dart:convert';

import 'package:fit_beat/app/data/model/master/master_bring_entity.dart';
import 'package:fit_beat/app/data/model/master/master_interest_entity.dart';

MasterUserDetailsOptionsEntity masterUserDetailsOptionsEntityFromMap(String str) =>
    MasterUserDetailsOptionsEntity.fromMap(json.decode(str));

String masterUserDetailsOptionsEntity(MasterUserDetailsOptionsEntity data) =>
    json.encode(data.toMap());

class MasterUserDetailsOptionsEntity {
  MasterUserDetailsOptionsEntity({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory MasterUserDetailsOptionsEntity.fromMap(Map<String, dynamic> json) =>
      MasterUserDetailsOptionsEntity(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
    this.masterBrings,
    this.masterInterests,
  });

  List<MasterBringEntity> masterBrings;
  List<MasterInterestEntity> masterInterests;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        masterBrings: json["master_brings"] == null
            ? null
            : List<MasterBringEntity>.from(
                json["master_brings"].map((x) => MasterBringEntity.fromMap(x))),
        masterInterests: json["master_interests"] == null
            ? null
            : List<MasterInterestEntity>.from(json["master_interests"]
                .map((x) => MasterInterestEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "master_brings": masterBrings == null
            ? null
            : List<dynamic>.from(masterBrings.map((x) => x.toMap())),
        "master_interests": masterInterests == null
            ? null
            : List<dynamic>.from(masterInterests.map((x) => x.toMap())),
      };
}
