import 'package:fit_beat/app/data/model/exercise_muscle_type_model.dart';
import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart'
    as data;
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/exercise_controller.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/add_exercise_controller.dart';

class SelectExerciseController extends GetxController {
  final ApiRepository repository;

  SelectExerciseController({@required this.repository})
      : assert(repository != null);

  List<ExerciseMuscleType> exerciseTypeList = [];
  List<data.ExerciseData> exerciseList = [];
  ExerciseMuscleType selectedExerciseType;
  TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  bool isSearching = false;

  var pageNo = 1;
  var pageRecord = 10;

  bool isAddClick = false;
  int addedCount = 0;
  var userScheduleId;
  var scheduleDate;

  bool feedLastPage = false;

  List<ExerciseScheduleActivityInput> input = [];

  @override
  void onInit() async {
    super.onInit();
    userScheduleId = Get.find<ExerciseController>().userScheduleId ?? 0;
    scheduleDate = Get.find<ExerciseController>().selectedDate;
    await getExerciseTypeList();
    getExerciseList();
  }

  onAddRemoveClick(bool isAddClick, var exerciseId, int index,
      {isUpdationDone = false}) {
    // isAddClick = !isAddClick;
    if (isAddClick) {
      bool isDuplicate = false;
      for (int i = 0; i < input.length; i++) {
        print(
            "$i == ${input[i].exerciseId} $exerciseId ${input[i].exerciseId == exerciseId}");
        if (input[i].exerciseId == exerciseId) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate) {
        addedCount += 1;
        String rest_bw_exercises = "";
        String rest_bw_sets = "";
        if (!isUpdationDone) {
          if (exerciseList[index].exercisesSpecifications.length > 0) {
            rest_bw_exercises = exerciseList[index]
                    .exercisesSpecifications[0]
                    ?.restBwExercises ??
                "";
            rest_bw_sets =
                exerciseList[index].exercisesSpecifications[0]?.restBwSets ??
                    "";
          }
        } else {
          rest_bw_exercises = exerciseList[index].restBwExercises ?? "";
          rest_bw_sets = exerciseList[index].restBwSets ?? "";
        }

        input.add(ExerciseScheduleActivityInput(
            exerciseId: exerciseId,
            userScheduleActivityId: 0,
            isDeleted: 0,
            rest_bw_exercises: rest_bw_exercises,
            userScheduleActivitySpecifications:
                exerciseList[index].exercisesSpecifications ?? [],
            rest_bw_sets: rest_bw_sets));
      }
    } else {
      addedCount -= 1;
      input.removeWhere((item) => item.exerciseId == exerciseId);
      //input.remove(index);
    }
    update();
  }

  onClearSearch() {
    searchController.text = "";
    feedLastPage = false;
    onSearchChange();
  }

  addExerciseInScheduleActivity() async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.addScheduleActivityForExercise(
          userScheduleId: userScheduleId,
          isKcal: 0,
          scheduleDate: scheduleDate,
          exercises: input);
      Utils.dismissLoadingDialog();
      if (response.status) {
        Get.find<ExerciseController>().getExerciseData();
        Get.back();
        Utils.showSucessSnackBar(response.message);
      } else {
        Utils.showErrorSnackBar(response.message);
      }
    } catch (e) {
      print("error ${e.toString()}");
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(CustomException.ERROR_CRASH_MSG);
    }
  }

  void loadNextFeed() {
    print("loadNextFeed");
    pageNo++;
    getExerciseList();
  }

  onSearchChange() async {
    try {
      isSearching = true;
      pageNo = 1;
      feedLastPage = false;
      exerciseList.clear();
      update();
      var response = await repository.getExerciseList(
          pageNo: pageNo,
          pageRecord: pageRecord,
          exerciseMuscleTypeId: selectedExerciseType.exerciseMuscleTypeId,
          search: searchController.text.toString());
      if (response.status) {
        if (response.data != null &&
            response.data.rows != null &&
            response.data.rows.isNotEmpty) {
          if (pageNo == 1) {
            exerciseList.clear();
          }
          exerciseList.addAll(response.data.rows);
        } else {
          feedLastPage = true;
        }
      }
      isSearching = false;
      update();
    } catch (e) {
      isSearching = false;
      update();
    }
  }

  void getExerciseList() async {
    try {
      isLoading = true;
      String search = searchController.text.toString().trim();
      var response = await repository.getExerciseList(
          pageNo: pageNo,
          pageRecord: pageRecord,
          exerciseMuscleTypeId: selectedExerciseType.exerciseMuscleTypeId,
          search: search);
      isLoading = false;
      if (response.status) {
        if (response.data != null &&
            response.data.rows != null &&
            response.data.rows.isNotEmpty) {
          if (pageNo == 1) {
            exerciseList.clear();
          }
          exerciseList.addAll(response.data.rows);
        } else {
          feedLastPage = true;
        }
      }
      update();
    } catch (e) {
      isLoading = false;
      update();
      print("error search ${e.toString()}");
    }
  }

  onExerciseTypeSelect(ExerciseMuscleType selectedExerciseType) {
    this.selectedExerciseType = selectedExerciseType;
    onSearchChange();
    update();
  }

  void getExerciseTypeList() async {
    try {
      isLoading = true;
      var response = await repository.getExerciseMuscleType();
      if (response.status) {
        exerciseTypeList.clear();
        exerciseTypeList
            .add(ExerciseMuscleType(exerciseMuscleTypeId: 0, title: "All"));
        exerciseTypeList.addAll(response.data);
        selectedExerciseType = exerciseTypeList[0];
      }
      update();
    } catch (e) {
      isLoading = false;
      print("error ${e.toString()}");
      update();
    }
  }
}

class ExerciseScheduleActivityInput {
  ExerciseScheduleActivityInput({
    this.userScheduleActivityId,
    this.exerciseId,
    this.isDeleted,
    this.rest_bw_sets,
    this.rest_bw_exercises,
    this.userScheduleActivitySpecifications,
  });

  int userScheduleActivityId;
  int exerciseId;
  int isDeleted;
  String rest_bw_sets;
  String rest_bw_exercises;
  List<ExerciseSpecification> userScheduleActivitySpecifications;

  factory ExerciseScheduleActivityInput.fromJson(Map<String, dynamic> json) =>
      ExerciseScheduleActivityInput(
        userScheduleActivityId: json["user_schedule_activity_id"] == null
            ? null
            : json["user_schedule_activity_id"],
        exerciseId: json["exercise_id"] == null ? null : json["exercise_id"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        rest_bw_sets:
            json["rest_bw_sets"] == null ? null : json["rest_bw_sets"],
        rest_bw_exercises: json["rest_bw_exercises"] == null
            ? null
            : json["rest_bw_exercises"],
        userScheduleActivitySpecifications:
            json["userScheduleActivitySpecifications"] == null
                ? null
                : List<ExerciseSpecification>.from(
                    json["userScheduleActivitySpecifications"]
                        .map((x) => ExerciseSpecification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_schedule_activity_id":
            userScheduleActivityId == null ? null : userScheduleActivityId,
        "exercise_id": exerciseId == null ? null : exerciseId,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "rest_bw_sets": rest_bw_sets == null ? null : rest_bw_sets,
        "rest_bw_exercises":
            rest_bw_exercises == null ? null : rest_bw_exercises,
        "userScheduleActivitySpecifications":
            userScheduleActivitySpecifications == null
                ? null
                : userScheduleActivitySpecifications,
      };
}
