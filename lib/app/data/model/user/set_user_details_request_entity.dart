// To parse this JSON data, do
//
//     final setUserDetailsRequestEntity = setUserDetailsRequestEntityFromMap(jsonString);

import 'dart:convert';

SetUserDetailsRequestEntity setUserDetailsRequestEntityFromMap(String str) => SetUserDetailsRequestEntity.fromMap(json.decode(str));

String setUserDetailsRequestEntityToMap(SetUserDetailsRequestEntity data) => json.encode(data.toMap());

class SetUserDetailsRequestEntity {
  SetUserDetailsRequestEntity({
    this.gender,
    this.dateOfBirth,
    this.heightUnit,
    this.height,
    this.weightType,
    this.weight,
    this.foodPreference,
    this.fitnessLevel,
    this.userBrings,
    this.userInterests,
  });

  int gender;
  String dateOfBirth;
  int heightUnit;
  String height;
  int weightType;
  String weight;
  String foodPreference;
  String fitnessLevel;
  List<UserBring> userBrings;
  List<UserInterest> userInterests;

  factory SetUserDetailsRequestEntity.fromMap(Map<String, dynamic> json) => SetUserDetailsRequestEntity(
    gender: json["gender"] == null ? null : json["gender"],
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    heightUnit: json["height_unit"] == null ? null : json["height_unit"],
    height: json["height"] == null ? null : json["height"],
    weightType: json["weight_type"] == null ? null : json["weight_type"],
    weight: json["weight"] == null ? null : json["weight"],
    foodPreference: json["food_preference"] == null ? null : json["food_preference"],
    fitnessLevel: json["fitness_level"] == null ? null : json["fitness_level"],
    userBrings: json["user_brings"] == null ? null : List<UserBring>.from(json["user_brings"].map((x) => UserBring.fromMap(x))),
    userInterests: json["user_interests"] == null ? null : List<UserInterest>.from(json["user_interests"].map((x) => UserInterest.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "gender": gender == null ? null : gender,
    "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
    "height_unit": heightUnit == null ? null : heightUnit,
    "height": height == null ? null : height,
    "weight_type": weightType == null ? null : weightType,
    "weight": weight == null ? null : weight,
    "food_preference": foodPreference == null ? null : foodPreference,
    "fitness_level": fitnessLevel == null ? null : fitnessLevel,
    "user_brings": userBrings == null ? null : List<dynamic>.from(userBrings.map((x) => x.toMap())),
    "user_interests": userInterests == null ? null : List<dynamic>.from(userInterests.map((x) => x.toMap())),
  };
}

class UserBring {
  UserBring({
    this.masterBringId,
  });

  int masterBringId;

  factory UserBring.fromMap(Map<String, dynamic> json) => UserBring(
    masterBringId: json["master_bring_id"] == null ? null : json["master_bring_id"],
  );

  Map<String, dynamic> toMap() => {
    "master_bring_id": masterBringId == null ? null : masterBringId,
  };
}

class UserInterest {
  UserInterest({
    this.masterInterestId,
  });

  int masterInterestId;

  factory UserInterest.fromMap(Map<String, dynamic> json) => UserInterest(
    masterInterestId: json["master_interest_id"] == null ? null : json["master_interest_id"],
  );

  Map<String, dynamic> toMap() => {
    "master_interest_id": masterInterestId == null ? null : masterInterestId,
  };
}
