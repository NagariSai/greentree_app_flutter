import 'dart:convert';

CoachListModel coachListModelFromJson(String str) =>
    CoachListModel.fromJson(json.decode(str));

String coachListModelToJson(CoachListModel data) => json.encode(data.toJson());

class CoachListModel {
  CoachListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory CoachListModel.fromJson(Map<String, dynamic> json) => CoachListModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.count,
    this.rows,
  });

  int count;
  List<Coach> rows;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"] == null ? null : json["count"],
        rows: json["rows"] == null
            ? null
            : List<Coach>.from(json["rows"].map((x) => Coach.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Coach {
  Coach({
    this.userId,
    this.fullName,
    this.profileUrl,
    this.experienceLevel,
    this.createDatetime,
    this.userFitnessCategories,
    this.rating,
    this.trained,
    this.availSlots,
  });

  int userId;
  String fullName;
  dynamic profileUrl;
  int experienceLevel;
  DateTime createDatetime;
  List<UserFitnessCategory> userFitnessCategories;
  String rating;
  int trained;
  int availSlots;

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        profileUrl: json["profile_url"],
        experienceLevel:
            json["experience_level"] == null ? null : json["experience_level"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        userFitnessCategories: json["user_fitness_categories"] == null
            ? null
            : List<UserFitnessCategory>.from(json["user_fitness_categories"]
                .map((x) => UserFitnessCategory.fromJson(x))),
        rating: json["rating"] == null ? null : json["rating"],
        trained: json["trained"] == null ? null : json["trained"],
        availSlots: json["avail_slots"] == null ? null : json["avail_slots"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "profile_url": profileUrl,
        "experience_level": experienceLevel == null ? null : experienceLevel,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "user_fitness_categories": userFitnessCategories == null
            ? null
            : List<UserFitnessCategory>.from(
                userFitnessCategories.map((x) => x.toJson())),
        "rating": rating == null ? null : rating,
        "trained": trained == null ? null : trained,
        "avail_slots": availSlots == null ? null : availSlots,
      };
}

class UserFitnessCategory {
  UserFitnessCategory({
    this.userFitnessCategoryId,
    this.fitnessCategoryId,
    this.title,
  });

  int userFitnessCategoryId;
  int fitnessCategoryId;
  String title;

  factory UserFitnessCategory.fromJson(Map<String, dynamic> json) =>
      UserFitnessCategory(
        userFitnessCategoryId: json["user_fitness_category_id"] == null
            ? null
            : json["user_fitness_category_id"],
        fitnessCategoryId: json["fitness_category_id"] == null
            ? null
            : json["fitness_category_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "user_fitness_category_id":
            userFitnessCategoryId == null ? null : userFitnessCategoryId,
        "fitness_category_id":
            fitnessCategoryId == null ? null : fitnessCategoryId,
        "title": title == null ? null : title,
      };
}
