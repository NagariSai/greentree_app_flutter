import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/add_exercise_controller.dart';
import 'package:fit_beat/app/features/todaySchedule/controller/select_exercise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomExerciseController extends GetxController {
  ExerciseData exercise;
  int index;
  bool fromTodaySchedule;
  var exercisesSpecifications;

  String rest_bw_exercises;
  String rest_bw_sets;

  final ApiRepository repository;

  BottomExerciseController(
      {this.exercise,
      this.index,
      this.fromTodaySchedule,
      this.rest_bw_exercises,
      this.rest_bw_sets,
      this.exercisesSpecifications,
      @required this.repository});

  List<ExerciseSpecification> durationList = [];
  List<ExerciseSpecification> repsList = [];
  List<ExerciseSpecification> weightRepsList = [];

  TextEditingController restSetController = TextEditingController();
  TextEditingController restExerciseController = TextEditingController();

  TextEditingController repsSetController = TextEditingController();
  TextEditingController repsExerciseController = TextEditingController();

  TextEditingController weightRepsSetController = TextEditingController();
  TextEditingController weightRepsExerciseController = TextEditingController();
  List<ExerciseSpecification> exerciseSpecification = [];
  @override
  void onInit() {
    super.onInit();
    getSpecificationData();
  }

  onDoneClick() {
    exerciseSpecification = [];
    if (durationList.length > 0) {
      exerciseSpecification = durationList;
    } else if (repsList.length > 0) {
      exerciseSpecification = repsList;
    } else if (weightRepsList.length > 0) {
      exerciseSpecification = weightRepsList;
    }
    Get.find<SelectExerciseController>()
        .exerciseList[index]
        .exercisesSpecifications = exerciseSpecification;

    if (exerciseSpecification.length > 0) {
      for (int i = 0; i < exerciseSpecification.length; i++) {
        if (exerciseSpecification[i].specificationType == 1) {
          Get.find<SelectExerciseController>()
                  .exerciseList[index]
                  .exercisesSpecifications[i]
                  .setVal1 =
              exerciseSpecification[i].textEditingController.text.toString();

          Get.find<SelectExerciseController>().exerciseList[index].restBwSets =
              restSetController.text.toString();
          Get.find<SelectExerciseController>()
              .exerciseList[index]
              .restBwExercises = restExerciseController.text.toString();
        } else if (exerciseSpecification[i].specificationType == 2) {
          Get.find<SelectExerciseController>()
                  .exerciseList[index]
                  .exercisesSpecifications[i]
                  .setVal1 =
              exerciseSpecification[i].textEditingController.text.toString();

          Get.find<SelectExerciseController>().exerciseList[index].restBwSets =
              repsSetController.text.toString();
          Get.find<SelectExerciseController>()
              .exerciseList[index]
              .restBwExercises = repsExerciseController.text.toString();
        } else if (exerciseSpecification[i].specificationType == 3) {
          Get.find<SelectExerciseController>()
                  .exerciseList[index]
                  .exercisesSpecifications[i]
                  .setVal1 =
              exerciseSpecification[i]
                  .weightAndRepsController
                  .repsController
                  .text
                  .toString();
          Get.find<SelectExerciseController>()
                  .exerciseList[index]
                  .exercisesSpecifications[i]
                  .setVal2 =
              exerciseSpecification[i]
                  .weightAndRepsController
                  .weightController
                  .text
                  .toString();

          Get.find<SelectExerciseController>().exerciseList[index].restBwSets =
              weightRepsSetController.text.toString();
          Get.find<SelectExerciseController>()
              .exerciseList[index]
              .restBwExercises = weightRepsExerciseController.text.toString();
        }
      }
    }

    Get.find<SelectExerciseController>()
        .exerciseList[index]
        .exercisesSpecifications = exerciseSpecification;
    Get.find<SelectExerciseController>().exerciseList[index].isAddClick = true;
    Get.find<SelectExerciseController>().onAddRemoveClick(
        true, exercise.exerciseId, index,
        isUpdationDone: true);
    Get.find<SelectExerciseController>().update();
  }

  void getSpecificationData() {
    bool isAddClick = fromTodaySchedule
        ? false
        : Get.find<SelectExerciseController>().exerciseList[index].isAddClick;

    print("isAddClick : ${isAddClick}");
    durationList = [];
    repsList = [];
    weightRepsList = [];
    if (fromTodaySchedule) {
      exerciseSpecification = exercisesSpecifications;
    } else {
      exerciseSpecification = Get.find<SelectExerciseController>()
          .exerciseList[index]
          .exercisesSpecifications;
    }

    if (exerciseSpecification != null && exerciseSpecification.length > 0) {
      for (int i = 0; i < exerciseSpecification.length; i++) {
        if (exerciseSpecification[0].specificationType == 1) {
          exerciseSpecification[i].textEditingController =
              TextEditingController(text: exerciseSpecification[i].setVal1);
          durationList.add(exerciseSpecification[i]);
          restSetController.text = rest_bw_sets ?? exercise.restBwSets;
          restExerciseController.text =
              rest_bw_exercises ?? exercise.restBwExercises;
        } else if (exerciseSpecification[i].specificationType == 2) {
          exerciseSpecification[i].textEditingController =
              TextEditingController(text: exerciseSpecification[i].setVal1);
          repsList.add(exerciseSpecification[i]);
          repsSetController.text = rest_bw_sets ?? exercise.restBwSets;
          repsExerciseController.text =
              rest_bw_exercises ?? exercise.restBwExercises;
        } else if (exerciseSpecification[i].specificationType == 3) {
          exerciseSpecification[i].weightAndRepsController =
              WeightAndRepsController(
                  weightController: TextEditingController(
                      text: exerciseSpecification[i].setVal1),
                  repsController: TextEditingController(
                      text: exerciseSpecification[i].setVal2));
          weightRepsList.add(exerciseSpecification[i]);
          weightRepsSetController.text = rest_bw_sets ?? exercise.restBwSets;
          weightRepsExerciseController.text =
              rest_bw_exercises ?? exercise.restBwExercises;
        }
      }
    }
  }

  addDuration() {
    durationList.add(ExerciseSpecification(
        textEditingController: TextEditingController(), specificationType: 1));
    update();
  }

  removeDuration(textEditController) {
    if (durationList.length > 1) {
      durationList.remove(textEditController);
    }
    update();
  }

  addReps() {
    repsList.add(ExerciseSpecification(
        textEditingController: TextEditingController(), specificationType: 2));
    update();
  }

  removeReps(textEditController) {
    if (repsList.length > 1) {
      repsList.remove(textEditController);
    }
    update();
  }

  addWeightReps() {
    weightRepsList.add(ExerciseSpecification(
        weightAndRepsController: WeightAndRepsController(
            weightController: TextEditingController(),
            repsController: TextEditingController()),
        specificationType: 3));
    update();
  }

  removeWeightReps(textEditController) {
    if (weightRepsList.length > 1) {
      weightRepsList.remove(textEditController);
    }
    update();
  }

  void updateSpecificationStatus(
      var userScheduleActivitySpecificationId) async {
    try {
      var response = await repository.updateSpecificationStatus(
          userScheduleActivitySpecificationId:
              userScheduleActivitySpecificationId);
      if (response.status) {}
      update();
    } catch (e) {
      print("error ${e.toString()}");
      update();
    }
  }

  @override
  void dispose() {
    restSetController.dispose();
    restExerciseController.dispose();

    repsSetController.dispose();
    repsExerciseController.dispose();

    weightRepsSetController.dispose();
    weightRepsExerciseController.dispose();
    super.dispose();
  }
}
