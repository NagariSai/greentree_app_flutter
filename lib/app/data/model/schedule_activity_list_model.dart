import 'package:fit_beat/app/features/todaySchedule/controller/add_exercise_controller.dart';
import 'package:flutter/cupertino.dart';

class ScheduleActivityListModel {
  ScheduleActivityListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ScheduleActivity> data;

  factory ScheduleActivityListModel.fromJson(Map<String, dynamic> json) =>
      ScheduleActivityListModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ScheduleActivity>.from(
                json["data"].map((x) => ScheduleActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ScheduleActivity {
  ScheduleActivity({
    this.userScheduleId,
    this.userId,
    this.scheduleDate,
    this.setKcal,
    this.completeKcal,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
    this.asNutritions,
    this.asExercises,
    this.asWater,
    this.protein,
    this.carbs,
    this.fat,
  });

  int userScheduleId;
  int userId;
  DateTime scheduleDate;
  dynamic setKcal;
  dynamic completeKcal;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  DateTime updateDatetime;
  String updateDatetimeUnix;
  List<AsNutrition> asNutritions;
  List<AsExercise> asExercises;
  List<AsWater> asWater;
  double protein;
  double carbs;
  double fat;

  factory ScheduleActivity.fromJson(Map<String, dynamic> json) =>
      ScheduleActivity(
        userScheduleId:
            json["user_schedule_id"] == null ? null : json["user_schedule_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        setKcal: json["set_kcal"] == null ? null : json["set_kcal"],
        completeKcal:
            json["complete_kcal"] == null ? null : json["complete_kcal"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime:
            json["create_datetime"] == null || json["create_datetime"] == ""
                ? null
                : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime:
            json["update_datetime"] == null || json["update_datetime"] == ""
                ? null
                : DateTime.parse(json["update_datetime"]),
        updateDatetimeUnix: json["update_datetime_unix"] == null
            ? null
            : json["update_datetime_unix"],
        asExercises: json["as_exercises"] == null
            ? null
            : List<AsExercise>.from(
                json["as_exercises"].map((x) => AsExercise.fromJson(x))),
        asNutritions: json["as_nutritions"] == null
            ? null
            : List<AsNutrition>.from(
                json["as_nutritions"].map((x) => AsNutrition.fromJson(x))),
        asWater: json["as_water"] == null
            ? null
            : List<AsWater>.from(
                json["as_water"].map((x) => AsWater.fromJson(x))),
        protein: json["protein"] == null
            ? null
            : double.parse(json["protein"].toString()),
        carbs: json["carbs"] == null
            ? null
            : double.parse(json["carbs"].toString()),
        fat: json["fat"] == null ? null : double.parse(json["fat"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "user_schedule_id": userScheduleId == null ? null : userScheduleId,
        "user_id": userId == null ? null : userId,
        "schedule_date":
            scheduleDate == null ? null : scheduleDate.toIso8601String(),
        "set_kcal": setKcal == null ? null : setKcal,
        "complete_kcal": completeKcal == null ? null : completeKcal,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime":
            updateDatetime == null ? null : updateDatetime.toIso8601String(),
        "update_datetime_unix":
            updateDatetimeUnix == null ? null : updateDatetimeUnix,
        "as_exercises": asExercises == null
            ? null
            : List<dynamic>.from(asExercises.map((x) => x.toJson())),
        "as_nutritions": asNutritions == null
            ? null
            : List<dynamic>.from(asNutritions.map((x) => x.toJson())),
        "as_water": asWater == null
            ? null
            : List<dynamic>.from(asWater.map((x) => x.toJson())),
        "protein": protein == null ? null : protein,
        "carbs": carbs == null ? null : carbs,
        "fat": fat == null ? null : fat,
      };
}

class AsNutrition {
  AsNutrition({
    this.masterCategoryTypeId,
    this.title,
    this.nutritions,
  });

  int masterCategoryTypeId;
  String title;
  List<Nutrition> nutritions;

  factory AsNutrition.fromJson(Map<String, dynamic> json) => AsNutrition(
        masterCategoryTypeId: json["master_category_type_id"] == null
            ? null
            : json["master_category_type_id"],
        title: json["title"] == null ? null : json["title"],
        nutritions: json["nutritions"] == null
            ? null
            : List<Nutrition>.from(
                json["nutritions"].map((x) => Nutrition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "master_category_type_id":
            masterCategoryTypeId == null ? null : masterCategoryTypeId,
        "title": title == null ? null : title,
        "nutritions": nutritions == null
            ? null
            : List<dynamic>.from(nutritions.map((x) => x.toJson())),
      };
}

class Nutrition {
  Nutrition(
      {this.userScheduleActivityId,
      this.userScheduleId,
      this.globalId,
      this.activityType,
      this.isDone,
      this.createDatetime,
      this.createDatetimeUnix,
      this.updateDatetime,
      this.updateDatetimeUnix,
      this.isDeleted,
      this.nutritionData,
      this.nutritionCalory});

  int userScheduleActivityId;
  int userScheduleId;
  int globalId;
  int activityType;
  int isDone;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;
  int isDeleted;
  NutritionData nutritionData;
  NutritionCalory nutritionCalory;


  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        userScheduleActivityId: json["user_schedule_activity_id"] == null
            ? null
            : json["user_schedule_activity_id"],
        userScheduleId:
            json["user_schedule_id"] == null ? null : json["user_schedule_id"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        activityType:
            json["activity_type"] == null ? null : json["activity_type"],
        isDone: json["is_done"] == null ? null : json["is_done"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
        nutritionCalory: json["nutrition_calory"] == null
            ? null
            : NutritionCalory.fromJson(json["nutrition_calory"]),
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        nutritionData: json["nutrition_data"] == null
            ? null
            : NutritionData.fromJson(json["nutrition_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_schedule_activity_id":
            userScheduleActivityId == null ? null : userScheduleActivityId,
        "user_schedule_id": userScheduleId == null ? null : userScheduleId,
        "global_id": globalId == null ? null : globalId,
        "activity_type": activityType == null ? null : activityType,
        "is_done": isDone == null ? null : isDone,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "nutrition_data": nutritionData == null ? null : nutritionData.toJson(),
        "nutrition_calory":
            nutritionCalory == null ? null : nutritionCalory.toJson(),
      };
}

class NutritionData {
  NutritionData(
      {this.nutritionId,
      this.title,
      this.foodType,
      this.kcal,
      this.masterCategoryTypeId,
      this.quantity,
      this.isSystem,
      this.userId,
      this.isDeleted,
      this.createDatetime,
      this.createDatetimeUnix,
      this.updateDatetime,
      this.updateDatetimeUnix,
      this.nutritionCalory,
      this.nutritionMedia,
      this.description,
      this.isDone,
      this.masterCategoryTypeTitle,
      this.quantityType});

  int nutritionId;
  String title;
  int foodType;
  int kcal;
  int masterCategoryTypeId;
  int quantity;
  int quantityType;
  int isSystem;
  int userId;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;
  NutritionCalory nutritionCalory;
  List<NutritionMedia> nutritionMedia;
  String description;
  String masterCategoryTypeTitle;
  int isDone;

  factory NutritionData.fromJson(Map<String, dynamic> json) => NutritionData(
        quantityType:
            json["quantity_type"] == null ? null : json["quantity_type"],
        description: json["description"] == null ? null : json["description"],
        masterCategoryTypeTitle: json["master_category_type_title"] == null
            ? null
            : json["master_category_type_title"],
        nutritionId: json["nutrition_id"] == null ? null : json["nutrition_id"],
        title: json["title"] == null ? null : json["title"],
        foodType: json["food_type"] == null ? null : json["food_type"],
        kcal: json["kcal"] == null ? null : json["kcal"],
        masterCategoryTypeId: json["master_category_type_id"] == null
            ? null
            : json["master_category_type_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        isSystem: json["is_system"] == null ? null : json["is_system"],
        userId: json["user_id"] == null ? null : json["user_id"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        isDone: json["is_done"] == null ? null : json["is_done"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
        nutritionCalory: json["nutrition_calory"] == null
            ? null
            : NutritionCalory.fromJson(json["nutrition_calory"]),
        nutritionMedia: json["nutrition_media"] == null
            ? null
            : List<NutritionMedia>.from(
                json["nutrition_media"].map((x) => NutritionMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quantity_type": quantityType == null ? null : quantityType,
        "nutrition_id": nutritionId == null ? null : nutritionId,
        "title": title == null ? null : title,
        "food_type": foodType == null ? null : foodType,
        "master_category_type_title":
            masterCategoryTypeTitle == null ? null : masterCategoryTypeTitle,
        "description": description == null ? null : description,
        "kcal": kcal == null ? null : kcal,
        "master_category_type_id":
            masterCategoryTypeId == null ? null : masterCategoryTypeId,
        "quantity": quantity == null ? null : quantity,
        "is_system": isSystem == null ? null : isSystem,
        "user_id": userId == null ? null : userId,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
        "is_done": isDone == null ? null : isDone,
        "nutrition_calory":
            nutritionCalory == null ? null : nutritionCalory.toJson(),
        "nutrition_media": nutritionMedia == null
            ? null
            : List<dynamic>.from(nutritionMedia.map((x) => x.toJson())),
      };
}

class NutritionCalory {
  NutritionCalory({
    this.nutritionCaloriesId,
    this.nutritionId,
    this.protein,
    this.carbs,
    this.fat,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
  });

  int nutritionCaloriesId;
  int nutritionId;
  double protein;
  double carbs;
  double fat;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;

  factory NutritionCalory.fromJson(Map<String, dynamic> json) =>
      NutritionCalory(
        nutritionCaloriesId: json["nutrition_calories_id"] == null
            ? null
            : json["nutrition_calories_id"],
        nutritionId: json["nutrition_id"] == null ? null : json["nutrition_id"],
        protein: json["protein"] == null ? null : json["protein"].toDouble(),
        carbs: json["carbs"] == null ? null : json["carbs"].toDouble(),
        fat: json["fat"] == null ? null : json["fat"].toDouble(),
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
      );

  Map<String, dynamic> toJson() => {
        "nutrition_calories_id":
            nutritionCaloriesId == null ? null : nutritionCaloriesId,
        "nutrition_id": nutritionId == null ? null : nutritionId,
        "protein": protein == null ? null : protein,
        "carbs": carbs == null ? null : carbs,
        "fat": fat == null ? null : fat,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
      };
}

class NutritionMedia {
  NutritionMedia({
    this.nutritionMediaId,
    this.nutritionId,
    this.mediaUrl,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
  });

  int nutritionMediaId;
  int nutritionId;
  String mediaUrl;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;

  factory NutritionMedia.fromJson(Map<String, dynamic> json) => NutritionMedia(
        nutritionMediaId: json["nutrition_media_id"] == null
            ? null
            : json["nutrition_media_id"],
        nutritionId: json["nutrition_id"] == null ? null : json["nutrition_id"],
        mediaUrl: json["media_url"] == null ? null : json["media_url"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
      );

  Map<String, dynamic> toJson() => {
        "nutrition_media_id":
            nutritionMediaId == null ? null : nutritionMediaId,
        "nutrition_id": nutritionId == null ? null : nutritionId,
        "media_url": mediaUrl == null ? null : mediaUrl,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
      };
}

class AsExercise {
  AsExercise(
      {this.userScheduleActivityId,
      this.userScheduleId,
      this.globalId,
      this.activityType,
      this.isDone,
      this.createDatetime,
      this.createDatetimeUnix,
      this.updateDatetime,
      this.updateDatetimeUnix,
      this.isDeleted,
      this.exerciseData,
      this.rest_bw_sets,
      this.rest_bw_exercises,
      this.userScheduleActivitySpecifications});

  int userScheduleActivityId;
  int userScheduleId;
  int globalId;
  int activityType;
  int isDone;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;
  int isDeleted;
  List<ExerciseSpecification> userScheduleActivitySpecifications;
  ExerciseData exerciseData;
  String rest_bw_sets;
  String rest_bw_exercises;

  factory AsExercise.fromJson(Map<String, dynamic> json) => AsExercise(
        rest_bw_sets:
            json["rest_bw_sets"] == null ? null : json["rest_bw_sets"],
        rest_bw_exercises: json["rest_bw_exercises"] == null
            ? null
            : json["rest_bw_exercises"],
        userScheduleActivityId: json["user_schedule_activity_id"] == null
            ? null
            : json["user_schedule_activity_id"],
        userScheduleId:
            json["user_schedule_id"] == null ? null : json["user_schedule_id"],
        globalId: json["global_id"] == null ? null : json["global_id"],
        activityType:
            json["activity_type"] == null ? null : json["activity_type"],
        isDone: json["is_done"] == null ? null : json["is_done"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        userScheduleActivitySpecifications:
            json["user_schedule_activity_specifications"] == null
                ? null
                : List<ExerciseSpecification>.from(
                    json["user_schedule_activity_specifications"]
                        .map((x) => ExerciseSpecification.fromJson(x))),
        exerciseData: json["exercise_data"] == null
            ? null
            : ExerciseData.fromJson(json["exercise_data"]),
      );

  Map<String, dynamic> toJson() => {
        "rest_bw_sets": rest_bw_sets == null ? null : rest_bw_sets,
        "rest_bw_exercises":
            rest_bw_exercises == null ? null : rest_bw_exercises,
        "user_schedule_activity_id":
            userScheduleActivityId == null ? null : userScheduleActivityId,
        "user_schedule_id": userScheduleId == null ? null : userScheduleId,
        "global_id": globalId == null ? null : globalId,
        "activity_type": activityType == null ? null : activityType,
        "is_done": isDone == null ? null : isDone,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "exercise_data": exerciseData == null ? null : exerciseData.toJson(),
      };
}

class ExerciseData {
  ExerciseData(
      {this.exerciseId,
      this.userId,
      this.title,
      this.duration,
      this.exerciseMuscleTypeId,
      this.isSystem,
      this.isDeleted,
      this.createDatetime,
      this.createDatetimeUnix,
      this.updateDatetime,
      this.updateDatetimeUnix,
      this.exerciseMuscleType,
      this.exerciseVideos,
      this.description,
      this.exercisesSpecifications,
      this.exerciseMuscleTypeTitle,
      this.restBwSets,
      this.restBwExercises,
      this.isAddClick = false});

  int exerciseId;
  int userId;
  String title;
  String duration;
  int exerciseMuscleTypeId;
  int isSystem;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;
  ExerciseMuscleType exerciseMuscleType;
  List<ExerciseVideo> exerciseVideos;
  String exerciseMuscleTypeTitle;
  String description;
  List<ExerciseSpecification> exercisesSpecifications;
  bool isAddClick;
  String restBwSets;
  String restBwExercises;

  factory ExerciseData.fromJson(Map<String, dynamic> json) => ExerciseData(
        restBwSets: json["rest_bw_sets"] == null ? null : json["rest_bw_sets"],
        restBwExercises: json["rest_bw_exercises"] == null
            ? null
            : json["rest_bw_exercises"],
        description: json["description"] == null ? null : json["description"],
        exerciseMuscleTypeTitle: json["exercise_muscle_type_title"] == null
            ? null
            : json["exercise_muscle_type_title"],
        exerciseId: json["exercise_id"] == null ? null : json["exercise_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        duration: json["duration"] == null ? null : json["duration"],
        exerciseMuscleTypeId: json["exercise_muscle_type_id"] == null
            ? null
            : json["exercise_muscle_type_id"],
        isSystem: json["is_system"] == null ? null : json["is_system"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
        exerciseMuscleType: json["exercise_muscle_type"] == null
            ? null
            : ExerciseMuscleType.fromJson(json["exercise_muscle_type"]),
        exercisesSpecifications: json["exercises_specifications"] == null
            ? json["user_schedule_activity_specifications"] == null
                ? null
                : List<ExerciseSpecification>.from(
                    json["user_schedule_activity_specifications"]
                        .map((x) => ExerciseSpecification.fromJson(x)))
            : List<ExerciseSpecification>.from(json["exercises_specifications"]
                .map((x) => ExerciseSpecification.fromJson(x))),
        exerciseVideos: json["exercise_videos"] == null
            ? null
            : List<ExerciseVideo>.from(
                json["exercise_videos"].map((x) => ExerciseVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exercises_specifications": exercisesSpecifications == null
            ? null
            : List<dynamic>.from(
                exercisesSpecifications.map((x) => x.toJson())),
        "rest_bw_sets": restBwSets == null ? null : restBwSets,
        "rest_bw_exercises": restBwExercises == null ? null : restBwExercises,
        "description": description == null ? null : description,
        "exercise_id": exerciseId == null ? null : exerciseId,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "duration": duration == null ? null : duration,
        "exercise_muscle_type_id":
            exerciseMuscleTypeId == null ? null : exerciseMuscleTypeId,
        "is_system": isSystem == null ? null : isSystem,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
        "exercise_muscle_type":
            exerciseMuscleType == null ? null : exerciseMuscleType.toJson(),
        "exercise_muscle_type_title":
            exerciseMuscleTypeTitle == null ? null : exerciseMuscleTypeTitle,
        "exercise_videos": exerciseVideos == null
            ? null
            : List<dynamic>.from(exerciseVideos.map((x) => x.toJson())),
      };
}

class ExerciseMuscleType {
  ExerciseMuscleType({
    this.exerciseMuscleTypeId,
    this.title,
    this.isActive,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
  });

  int exerciseMuscleTypeId;
  String title;
  int isActive;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;

  factory ExerciseMuscleType.fromJson(Map<String, dynamic> json) =>
      ExerciseMuscleType(
        exerciseMuscleTypeId: json["exercise_muscle_type_id"] == null
            ? null
            : json["exercise_muscle_type_id"],
        title: json["title"] == null ? null : json["title"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_muscle_type_id":
            exerciseMuscleTypeId == null ? null : exerciseMuscleTypeId,
        "title": title == null ? null : title,
        "is_active": isActive == null ? null : isActive,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
      };
}

class ExerciseVideo {
  ExerciseVideo({
    this.exerciseVideoId,
    this.exerciseId,
    this.videoUrl,
    this.isDeleted,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
  });

  int exerciseVideoId;
  int exerciseId;
  String videoUrl;
  int isDeleted;
  DateTime createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  dynamic updateDatetimeUnix;

  factory ExerciseVideo.fromJson(Map<String, dynamic> json) => ExerciseVideo(
        exerciseVideoId: json["exercise_video_id"] == null
            ? null
            : json["exercise_video_id"],
        exerciseId: json["exercise_id"] == null ? null : json["exercise_id"],
        videoUrl: json["video_url"] == null ? null : json["video_url"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        createDatetime: json["create_datetime"] == null
            ? null
            : DateTime.parse(json["create_datetime"]),
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_video_id": exerciseVideoId == null ? null : exerciseVideoId,
        "exercise_id": exerciseId == null ? null : exerciseId,
        "video_url": videoUrl == null ? null : videoUrl,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "create_datetime":
            createDatetime == null ? null : createDatetime.toIso8601String(),
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix": updateDatetimeUnix,
      };
}

class AsWater {
  AsWater({
    this.waterActivityId,
    this.userScheduleId,
    this.waterLevel,
    this.reminderStartTime,
    this.reminderTimeTime,
    this.reminderSchedule,
    this.createDatetime,
    this.createDatetimeUnix,
    this.updateDatetime,
    this.updateDatetimeUnix,
  });

  int waterActivityId;
  int userScheduleId;
  String waterLevel;
  String reminderStartTime;
  String reminderTimeTime;
  int reminderSchedule;
  dynamic createDatetime;
  String createDatetimeUnix;
  dynamic updateDatetime;
  String updateDatetimeUnix;

  factory AsWater.fromJson(Map<String, dynamic> json) => AsWater(
        waterActivityId: json["water_activity_id"] == null
            ? null
            : json["water_activity_id"],
        userScheduleId:
            json["user_schedule_id"] == null ? null : json["user_schedule_id"],
        waterLevel: json["water_level"] == null ? null : json["water_level"],
        reminderStartTime: json["reminder_start_time"] == null
            ? null
            : json["reminder_start_time"],
        reminderTimeTime: json["reminder_time_time"] == null
            ? null
            : json["reminder_time_time"],
        reminderSchedule: json["reminder_schedule"] == null
            ? null
            : json["reminder_schedule"],
        createDatetime: json["create_datetime"],
        createDatetimeUnix: json["create_datetime_unix"] == null
            ? null
            : json["create_datetime_unix"],
        updateDatetime: json["update_datetime"],
        updateDatetimeUnix: json["update_datetime_unix"] == null
            ? null
            : json["update_datetime_unix"],
      );

  Map<String, dynamic> toJson() => {
        "water_activity_id": waterActivityId == null ? null : waterActivityId,
        "user_schedule_id": userScheduleId == null ? null : userScheduleId,
        "water_level": waterLevel == null ? null : waterLevel,
        "reminder_start_time":
            reminderStartTime == null ? null : reminderStartTime,
        "reminder_time_time":
            reminderTimeTime == null ? null : reminderTimeTime,
        "reminder_schedule": reminderSchedule == null ? null : reminderSchedule,
        "create_datetime": createDatetime,
        "create_datetime_unix":
            createDatetimeUnix == null ? null : createDatetimeUnix,
        "update_datetime": updateDatetime,
        "update_datetime_unix":
            updateDatetimeUnix == null ? null : updateDatetimeUnix,
      };
}
