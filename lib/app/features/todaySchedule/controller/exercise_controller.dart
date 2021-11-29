import 'package:fit_beat/app/data/model/schedule_activity_list_model.dart';
import 'package:fit_beat/app/data/provider/custom_exception.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExerciseController extends GetxController {
  final ApiRepository repository;

  ExerciseController({@required this.repository}) : assert(repository != null);

  var selectedDate;
  final requestDobFormat = new DateFormat("yyyy-MM-dd");

  @override
  void onInit() {
    super.onInit();
    selectedDate = requestDobFormat.format(DateTime.now());
    getExerciseData();
  }

  setCalenderDate(DateTime dateTime) {
    selectedDate = requestDobFormat.format(dateTime);
    getExerciseData();
    update();
  }

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  DateTime focusedDay = DateTime.now();

  var userScheduleId;
  bool isLoading = true;
  List<AsExercise> asExercises = [];
  String rest_bw_sets = "";
  String rest_bw_exercises = "";

  void getExerciseData() async {
    try {
      isLoading = true;
      var response = await repository.getScheduleActivityListForExercise(
          startDate: selectedDate, endDate: selectedDate);
      isLoading = false;
      if (response.status) {
        userScheduleId = response.data[0].userScheduleId;
        asExercises = response.data[0].asExercises;
      }
      update();
    } catch (e) {
      isLoading = false;
      asExercises = [];
      update();
    }
  }

  deleteExerciseInScheduleActivity(
      var userScheduleId, var userScheduleActivityId) async {
    try {
      Utils.showLoadingDialog();
      var response = await repository.deleteScheduleActivity(
          userScheduleId: userScheduleId,
          activityType: 2,
          userScheduleActivityId: userScheduleActivityId);
      Utils.dismissLoadingDialog();
      if (response.status) {
        getExerciseData();
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
}
