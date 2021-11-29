class ExerciseMuscleTypeModel {
  ExerciseMuscleTypeModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ExerciseMuscleType> data;

  factory ExerciseMuscleTypeModel.fromJson(Map<String, dynamic> json) =>
      ExerciseMuscleTypeModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ExerciseMuscleType>.from(
                json["data"].map((x) => ExerciseMuscleType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ExerciseMuscleType {
  ExerciseMuscleType({
    this.exerciseMuscleTypeId,
    this.title,
  });

  int exerciseMuscleTypeId;
  String title;

  factory ExerciseMuscleType.fromJson(Map<String, dynamic> json) =>
      ExerciseMuscleType(
        exerciseMuscleTypeId: json["exercise_muscle_type_id"] == null
            ? null
            : json["exercise_muscle_type_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_muscle_type_id":
            exerciseMuscleTypeId == null ? null : exerciseMuscleTypeId,
        "title": title == null ? null : title,
      };
}
