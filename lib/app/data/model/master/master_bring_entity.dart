// To parse this JSON data, do
//
//     final masterBringEntity = masterBringEntityFromMap(jsonString);

import 'dart:convert';

MasterBringEntity masterBringEntityFromMap(String str) => MasterBringEntity.fromMap(json.decode(str));

String masterBringEntityToMap(MasterBringEntity data) => json.encode(data.toMap());

class MasterBringEntity {
  MasterBringEntity({
    this.masterBringId,
    this.title,
    this.icon,
    this.fillIcon,
    this.shadowColor,
    this.color,
    this.userBring,
  });

  int masterBringId;
  String title;
  String icon;
  String fillIcon;
  String shadowColor;
  String color;
  dynamic userBring;

  factory MasterBringEntity.fromMap(Map<String, dynamic> json) => MasterBringEntity(
    masterBringId: json["master_bring_id"] == null ? null : json["master_bring_id"],
    title: json["title"] == null ? null : json["title"],
    icon: json["icon"] == null ? null : json["icon"],
    fillIcon: json["fill_icon"] == null ? null : json["fill_icon"],
    shadowColor: json["shadow_color"] == null ? null : json["shadow_color"],
    color: json["color"] == null ? null : json["color"],
    userBring: json["user_bring"],
  );

  Map<String, dynamic> toMap() => {
    "master_bring_id": masterBringId == null ? null : masterBringId,
    "title": title == null ? null : title,
    "icon": icon == null ? null : icon,
    "fill_icon": fillIcon == null ? null : fillIcon,
    "shadow_color": shadowColor == null ? null : shadowColor,
    "color": color == null ? null : color,
    "user_bring": userBring,
  };
}
